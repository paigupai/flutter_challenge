import 'dart:async';
import 'dart:io';

import 'package:flutter_map_app/repository/charger_spots_repository.dart';
import 'package:flutter_map_app/ui/common/custom_marker_icon.dart';
import 'package:flutter_map_app/ui/pages/map_page/charger_spot_card_swiper_notifier.dart';
import 'package:flutter_map_app/ui/pages/map_page/map_page_state.dart';
import 'package:flutter_map_app/utils/list_extension.dart';
import 'package:flutter_map_app/utils/logger.dart';
import 'package:flutter_map_app/utils/set_extension.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:openapi/api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

part 'map_page_notifier.g.dart';

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
  Timer? _debounceTimer;

  // 充電スポットのリポジトリ
  final ChargerSpotsRepository _chargerSpotsRepository =
      ChargerSpotsRepository();

  @override
  MapPageState build() {
    ref.onDispose(() {
      // タイマーをキャンセル
      _debounceTimer?.cancel();
    });

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
    // 位置情報の設定有効化を行う
    state = state.copyWith(isEnableLocationSetting: true);
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
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);
    return LatLng(position.latitude, position.longitude);
  }

  // 現在位置のmarkerを更新
  Future<void> updateCurrentLocation(LatLng currentLocation) async {
    final currentLocationMarker = Marker(
      markerId: const MarkerId('currentLocation'),
      position: currentLocation,
      infoWindow: const InfoWindow(title: '現在地'),
      icon: await CustomMarkerIcon.getCurrentLocationIcon(),
    );
    final set = Set<Marker>.from(state.markersSet);
    final updatedSet = SetEx.addMarker(set, currentLocationMarker);
    state = state.copyWith(markersSet: updatedSet);
  }

  // 充電スポットのmarkerを更新
  // [southwest] 左下の座標
  // [northeast] 右上の座標
  Future<void> updateChargingSpot({
    required LatLng southwest,
    required LatLng northeast,
  }) async {
    // 頻繁に呼ばれるのでデバウンス処理つける
    if (_debounceTimer != null) {
      _debounceTimer!.cancel();
    }
    _debounceTimer = Timer(const Duration(microseconds: 600), () async {
      // 最南西（左下）の緯度
      final swLat = southwest.latitude;
      // 最南西（左下）の経度
      final swLng = southwest.longitude;
      // 最北東（右上）の緯度
      final neLat = northeast.latitude;
      // 最北東（右上）の経度
      final neLng = northeast.longitude;

      APIResponse? result;
      try {
        result = await _chargerSpotsRepository.getChargerSpots(
          swLat: swLat.toString(),
          swLng: swLng.toString(),
          neLat: neLat.toString(),
          neLng: neLng.toString(),
        );
      } catch (e) {
        logger.w('error: $e');
      }

      // 取得失敗時
      if (result == null || result.status != APIResponseStatusEnum.ok) {
        return;
      }
      // 充電スポットがない場合
      if (result.chargerSpots.isEmpty) {
        return;
      }
      // 充電スポットのリスト
      final chargerSpots = result.chargerSpots;
      var updatedSet = Set<Marker>.from(state.markersSet);

      // 充電スポットのマーカーを作成
      await Future.wait(chargerSpots.map((spot) async {
        logger.d(
            'chargerSpot: name:${spot.name} \n lat:${spot.latitude} \n lng:${spot.longitude}');
        final marker = Marker(
          markerId: MarkerId(spot.uuid),
          position: LatLng(spot.latitude.toDouble(), spot.longitude.toDouble()),
          infoWindow: InfoWindow(title: spot.name),
          icon: await CustomMarkerIcon.getChargingSpotIcon(
            chargerCount: spot.chargerDevices.length,
          ),
          onTap: () {
            logger.d('marker tapped: ${spot.name}');
            ref
                .read(chargerSpotCardSwiperNotifierProvider.notifier)
                .updateSelectedChargerSpot(spot);
            updateOnTapMakerId(spot.uuid);
          },
        );
        updatedSet = SetEx.addMarker(updatedSet, marker);
      }));

      final chargerSpotsList =
          List<APIChargerSpot>.from(state.chargerSpotsList);
      // 重複を削除
      final maxChargerSpots = chargerSpotsList + chargerSpots;
      final needUpdateChargerSpotsList =
          ListEx.uniqueChargerSpot(maxChargerSpots);
      final updatedChargerSpotsList =
          chargerSpotsList + needUpdateChargerSpotsList;

      state = state.copyWith(
          markersSet: updatedSet, chargerSpotsList: updatedChargerSpotsList);
    });
  }

  // tapされたマーカーのIDを更新
  void updateOnTapMakerId(String onTapMakerId) {
    state = state.copyWith(onTapMakerId: onTapMakerId);
  }

  // 自動検索の更新
  void updateAutoSearch(bool autoSearch) {
    state = state.copyWith(autoSearch: autoSearch);
  }

  // 地図アプリを開く
  Future<void> openMapApp({
    required num latitude,
    required num longitude,
  }) async {
    // 地図アプリを開く
    final googleUrl = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
    final appleUrl =
        Uri.parse('https://maps.apple.com/?q=$latitude,$longitude');

    // iOSの場合はApple Mapを開く
    if (Platform.isIOS && await canLaunchUrl(appleUrl)) {
      await launchUrl(appleUrl);
    }

    // それ以外の場合はGoogle Mapを開く
    if (await canLaunchUrl(googleUrl)) {
      await launchUrl(
        googleUrl,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  // 位置情報の設定有効化行うているかどうかを更新
  void updateIsEnableLocationSetting(bool isEnableLocationSetting) {
    state = state.copyWith(isEnableLocationSetting: isEnableLocationSetting);
  }
}
