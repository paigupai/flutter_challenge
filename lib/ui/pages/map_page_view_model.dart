import 'package:flutter_map_app/ui/pages/map_page_state.dart';
import 'package:flutter_map_app/utils/logger.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_page_view_model.g.dart';

enum LocationSettingResult {
  // 位置情報が使えない
  serviceDisabled,
  // 位置情報のパーミッションが拒否されている
  permissionDenied,
  // 位置情報のパーミッションが永久に拒否されている
  permissionDeniedForever,
  // 位置情報が有効
  enabled,
}

///
///  地図ページの状態を管理するNotifier
///
@riverpod
class MapPageNotifier extends _$MapPageNotifier {
  @override
  MapPageState build() {
    return const MapPageState();
  }

  // 位置情報の設定ダイアログを表示するかどうかをチェック
  Future<void> checkLocationSettingDialog() async {
    final locationResult = await checkLocationSetting();
    if (locationResult == LocationSettingResult.serviceDisabled ||
        locationResult == LocationSettingResult.permissionDenied ||
        locationResult == LocationSettingResult.permissionDeniedForever) {
      state = state.copyWith(needShowPermissionDialog: true);
    }
  }

  // 位置情報の設定有効化
  Future<void> enableLocationSetting() async {
    final locationResult = await checkLocationSetting();
    if (locationResult == LocationSettingResult.enabled) {
      return;
    }
    if (locationResult == LocationSettingResult.serviceDisabled) {
      await Geolocator.openLocationSettings();
    } else {
      await Geolocator.openAppSettings();
    }
  }

  // 位置情報に関する権限を確認
  Future<LocationSettingResult> checkLocationSetting() async {
    // 位置情報が有効かどうか
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      logger.w('Location services are disabled.');
      return LocationSettingResult.serviceDisabled;
    }
    // 位置情報のパーミッションが拒否されているかどうか
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // パーミッションのリクエスト
      permission = await Geolocator.requestPermission();
      // パーミッションが拒否された場合
      if (permission == LocationPermission.denied) {
        logger.w('Location permissions are denied.');
        return LocationSettingResult.permissionDenied;
      }
    }

    // 位置情報のパーミッションが永久に拒否されているかどうか
    if (permission == LocationPermission.deniedForever) {
      logger.w('Location permissions are permanently denied.');
      return LocationSettingResult.permissionDeniedForever;
    }
    // 位置情報が有効
    return LocationSettingResult.enabled;
  }

  // 現在の位置情報を取得
  Future<LatLng?> fetchCurrentLocation() async {
    final locationResult = await checkLocationSetting();
    // 位置情報権限が使えない場合
    if (locationResult != LocationSettingResult.enabled) {
      return null;
    }
    final position = await Geolocator.getCurrentPosition();
    return LatLng(position.latitude, position.longitude);
  }
}
