import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map_app/main.dart';
import 'package:flutter_map_app/model/app_model.dart';
import 'package:flutter_map_app/ui/pages/map_page/charger_spot_card_swiper.dart';
import 'package:flutter_map_app/ui/pages/map_page/map_page_notifier.dart';
import 'package:flutter_map_app/utils/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

///
/// 地図ページ
///
class MapPage extends ConsumerStatefulWidget {
  const MapPage({super.key});

  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends ConsumerState<MapPage> with WidgetsBindingObserver {
  late GoogleMapController _mapController;

  late final MapPageNotifier _notifier;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _notifier = ref.read(mapPageNotifierProvider.notifier);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _mapController.dispose();

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // アプリがフォアグラウンドに戻った時の処理
      logger.d('App is back to foreground');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (ModalRoute.of(context)?.isCurrent ?? false) {
          _refreshCurrentLocation();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // 位置情報の設定ダイアログlistener
    _showPermissionDialogListener();
    // 選択された充電スポットを更新
    _updateMarkerChargerSpotListener();
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          _buildMap(),
          const ChargerSpotCardSwiper(),
        ]),
      ),
      floatingActionButton: IconButton(
        onPressed: _refreshCurrentLocation,
        icon: SvgPicture.asset(
          'assets/icons/location_button_icon.svg',
          width: 62,
          height: 62,
        ),
      ),
    );
  }

  // 地図ウィジェット
  Widget _buildMap() {
    // 現在の位置情報
    final currentLocation = getIt<AppModel>().currentLocation;
    return Consumer(builder: (context, ref, _) {
      // マーカーの取得
      final markersList = ref.watch(mapPageNotifierProvider.select((value) {
        return value.markersList;
      }));
      return GoogleMap(
        mapType: MapType.normal,
        zoomControlsEnabled: false,
        initialCameraPosition: CameraPosition(
          target: currentLocation,
          zoom: 15.0,
        ),
        onMapCreated: (GoogleMapController controller) async {
          _mapController = controller;
          // 位置情報の設定ダイアログを表示するかどうかをチェック
          await _notifier.checkLocationSettingDialog();
          await _refreshCurrentLocation();
        },
        onCameraIdle: () async {
          // カメラの位置が変更された時の処理
          final bounds = await _mapController.getVisibleRegion();
          // 左下と右上の座標を取得
          final southwest = bounds.southwest;
          final northeast = bounds.northeast;
          await _notifier.updateChargingSpot(
            southwest: southwest,
            northeast: northeast,
          );
        },
        markers: markersList.toSet(),
      );
    });
  }

  // 現在の位置情報を更新
  Future<void> _refreshCurrentLocation() async {
    final currentLocation = await _notifier.fetchCurrentLocation();
    // 権限がない場合
    if (currentLocation == null) {
      return;
    }
    await _mapController.animateCamera(CameraUpdate.newLatLng(currentLocation));
    await _notifier.updateCurrentLocation(currentLocation);
  }

  // 位置情報の設定ダイアログlistener
  void _showPermissionDialogListener() {
    ref.listen(
        mapPageNotifierProvider.select(
            (value) => value.needShowPermissionDialog), (previous, next) {
      if (next) {
        // 位置情報の設定ダイアログを表示
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('位置情報の設定'),
              content: const Text('位置情報の設定を有効にしてください'),
              actions: <Widget>[
                TextButton(
                  child: const Text('キャンセル'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('設定'),
                  onPressed: () {
                    _notifier.enableLocationSetting();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  // tapされた充電スポットを更新
  void _updateMarkerChargerSpotListener() {
    ref.listen(mapPageNotifierProvider.select((value) => value.onTapMakerId),
        (previous, next) async {
      if (next == null) {
        return;
      }

      final chargerSpots = ref
          .read(mapPageNotifierProvider.select((value) => value.chargerSpots));
      final onTapChargerSpot =
          chargerSpots.firstWhere((element) => element.uuid == next);

      final onTapPosition = LatLng(onTapChargerSpot.latitude.toDouble(),
          onTapChargerSpot.longitude.toDouble());
      final markerId = MarkerId(onTapChargerSpot.uuid);

      // マーカーの位置に移動
      await _mapController.animateCamera(CameraUpdate.newLatLng(onTapPosition));
      final isShown = await _mapController.isMarkerInfoWindowShown(markerId);

      if (!isShown) {
        await _mapController
            .showMarkerInfoWindow(MarkerId(onTapChargerSpot.uuid));
      }
    });
  }

  // 選択中の充電スポットカードのIDを更新
}
