import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:openapi/api.dart';

part 'map_page_state.freezed.dart';

///
/// 地図ページの状態
///
@freezed
class MapPageState with _$MapPageState {
  const factory MapPageState({
    // 位置情報の設定ダイアログを表示するかどうか
    @Default(false) bool needShowPermissionDialog,
    // 現在地
    LatLng? currentLocation,
    // マーカーリスト
    @Default([]) List<Marker> markersList,
    // 充電スポットリスト
    @Default([]) List<APIChargerSpot> chargerSpots,
    // 選択された充電スポット
    String? selectedId,
  }) = _MapPageState;
}
