import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map_app/main.dart';
import 'package:flutter_map_app/model/app_model.dart';
import 'package:flutter_map_app/ui/pages/map_page/charger_spot_card_swiper.dart';
import 'package:flutter_map_app/ui/pages/map_page/charger_spot_card_swiper_notifier.dart';
import 'package:flutter_map_app/ui/pages/map_page/map_page_notifier.dart';
import 'package:flutter_map_app/utils/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
          // 位置情報の設定有効化行うているかどうか
          final isEnableLocationSetting =
              ref.read(mapPageNotifierProvider.select((value) {
            return value.isEnableLocationSetting;
          }));
          if (isEnableLocationSetting) {
            // 位置情報の設定有効化完了
            _notifier.updateIsEnableLocationSetting(false);
            _refreshCurrentLocation();
          }
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
          ChargerSpotCardSwiper(
            onRefreshCurrentLocation: _refreshCurrentLocation,
          ),
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: _header(),
    );
  }

  // 地図ウィジェット
  Widget _buildMap() {
    // 現在の位置情報
    final currentLocation = getIt<AppModel>().currentLocation;
    return Consumer(builder: (context, ref, _) {
      // マーカーの取得
      final markersSet = ref.watch(mapPageNotifierProvider.select((value) {
        return value.markersSet;
      }));
      return GoogleMap(
        mapType: MapType.normal,
        zoomControlsEnabled: false,
        initialCameraPosition: CameraPosition(
          target: currentLocation,
          zoom: 15.0,
        ),
        onTap: (position) {
          // card swiperを非表示
          ref
              .read(chargerSpotCardSwiperNotifierProvider.notifier)
              .updateNeedShowCardSwiper(false);
        },
        onMapCreated: (GoogleMapController controller) async {
          _mapController = controller;
          // 位置情報の設定ダイアログを表示するかどうかをチェック
          await _notifier.checkLocationSettingDialog();
          await _refreshCurrentLocation();
        },
        onCameraIdle: () async {
          // 自動検索がオフの場合は何もしない
          final autoSearch = ref.read(
              mapPageNotifierProvider.select((value) => value.autoSearch));
          if (!autoSearch) {
            return;
          }
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
        markers: markersSet,
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

  // map header
  Widget _header() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 16),
        FractionallySizedBox(
          widthFactor: 0.9,
          child: GestureDetector(
            onTap: () async {
              // 充電スポットを更新
              final bounds = await _mapController.getVisibleRegion();
              // 左下と右上の座標を取得
              final southwest = bounds.southwest;
              final northeast = bounds.northeast;
              await _notifier.updateChargingSpot(
                southwest: southwest,
                northeast: northeast,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffECF9E3),
                borderRadius: BorderRadius.circular(34),
              ),
              padding: const EdgeInsets.only(
                  left: 27, right: 16, top: 18, bottom: 18),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'このエリアでスポットを検索',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff56C600),
                    ),
                  ),
                  Icon(
                    Icons.search,
                    color: Color(0xff56C600),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            margin: const EdgeInsets.only(right: 20),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  '自動検索',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff56C600),
                  ),
                ),
                Consumer(builder: (context, ref, _) {
                  final autoSearch =
                      ref.watch(mapPageNotifierProvider.select((value) {
                    return value.autoSearch;
                  }));
                  return Switch(
                    value: autoSearch,
                    onChanged: (value) {
                      ref
                          .read(mapPageNotifierProvider.notifier)
                          .updateAutoSearch(value);
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // tapされた充電スポットを更新
  void _updateMarkerChargerSpotListener() {
    ref.listen(mapPageNotifierProvider.select((value) => value.onTapMakerId),
        (previous, next) async {
      if (next == null) {
        return;
      }

      final chargerSpots = ref.read(
          mapPageNotifierProvider.select((value) => value.chargerSpotsList));
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
}
