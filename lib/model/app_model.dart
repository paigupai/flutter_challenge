import 'package:google_maps_flutter/google_maps_flutter.dart';

///
/// アプリ全体で使用するモデル
///
class AppModel {
  AppModel({
    required this.currentLocation,
  });

  // 現在地
  LatLng currentLocation;
}
