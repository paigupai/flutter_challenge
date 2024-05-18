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
    // マーカーset
    @Default(<Marker>{}) Set<Marker> markersSet,
    // 充電スポットリスト
    @Default([]) List<APIChargerSpot> chargerSpotsList,
    // tapされたマーカーのID
    String? onTapMakerId,
    // 自動検索
    @Default(true) bool autoSearch,
    // 位置情報の設定有効化行うているかどうか
    @Default(false) bool isEnableLocationSetting,
  }) = _MapPageState;
}
