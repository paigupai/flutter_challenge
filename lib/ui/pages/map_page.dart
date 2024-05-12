import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map_app/ui/pages/map_page_view_model.dart';
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
  GoogleMapController? _controller;

  // デフォルトの位置情報
  static const _defaultLocation = LatLng(35.681236, 139.767125);

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

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
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // アプリがフォアグラウンドに戻った時の処理
      print('App is back to foreground');
      _refreshCurrentLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    _showPermissionDialogListener();
    return Scaffold(
      body: SafeArea(
        child: _buildMap(),
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
    return Consumer(builder: (context, ref, _) {
      // マーカーの取得
      final markersList = ref.watch(mapPageNotifierProvider.select((value) {
        return value.markersList;
      }));
      return GoogleMap(
        mapType: MapType.normal,
        zoomControlsEnabled: false,
        initialCameraPosition: const CameraPosition(
          target: _defaultLocation,
          zoom: 15.0,
        ),
        onMapCreated: (GoogleMapController controller) async {
          _controller = controller;

          // 位置情報の設定ダイアログを表示するかどうかをチェック
          await _notifier.checkLocationSettingDialog();
          await _refreshCurrentLocation();
        },
        onCameraIdle: () async {
          // カメラの位置が変更された時の処理
          final bounds = await _controller!.getVisibleRegion();
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
    await _controller?.animateCamera(CameraUpdate.newLatLng(currentLocation));
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
}
