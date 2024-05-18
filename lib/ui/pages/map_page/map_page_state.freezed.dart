// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MapPageState {
// 位置情報の設定ダイアログを表示するかどうか
  bool get needShowPermissionDialog =>
      throw _privateConstructorUsedError; // マーカーset
  Set<Marker> get markersSet => throw _privateConstructorUsedError; // 充電スポットリスト
  List<APIChargerSpot> get chargerSpotsList =>
      throw _privateConstructorUsedError; // tapされたマーカーのID
  String? get onTapMakerId => throw _privateConstructorUsedError; // 自動検索
  bool get autoSearch =>
      throw _privateConstructorUsedError; // 位置情報の設定有効化行うているかどうか
  bool get isEnableLocationSetting => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MapPageStateCopyWith<MapPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapPageStateCopyWith<$Res> {
  factory $MapPageStateCopyWith(
          MapPageState value, $Res Function(MapPageState) then) =
      _$MapPageStateCopyWithImpl<$Res, MapPageState>;
  @useResult
  $Res call(
      {bool needShowPermissionDialog,
      Set<Marker> markersSet,
      List<APIChargerSpot> chargerSpotsList,
      String? onTapMakerId,
      bool autoSearch,
      bool isEnableLocationSetting});
}

/// @nodoc
class _$MapPageStateCopyWithImpl<$Res, $Val extends MapPageState>
    implements $MapPageStateCopyWith<$Res> {
  _$MapPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? needShowPermissionDialog = null,
    Object? markersSet = null,
    Object? chargerSpotsList = null,
    Object? onTapMakerId = freezed,
    Object? autoSearch = null,
    Object? isEnableLocationSetting = null,
  }) {
    return _then(_value.copyWith(
      needShowPermissionDialog: null == needShowPermissionDialog
          ? _value.needShowPermissionDialog
          : needShowPermissionDialog // ignore: cast_nullable_to_non_nullable
              as bool,
      markersSet: null == markersSet
          ? _value.markersSet
          : markersSet // ignore: cast_nullable_to_non_nullable
              as Set<Marker>,
      chargerSpotsList: null == chargerSpotsList
          ? _value.chargerSpotsList
          : chargerSpotsList // ignore: cast_nullable_to_non_nullable
              as List<APIChargerSpot>,
      onTapMakerId: freezed == onTapMakerId
          ? _value.onTapMakerId
          : onTapMakerId // ignore: cast_nullable_to_non_nullable
              as String?,
      autoSearch: null == autoSearch
          ? _value.autoSearch
          : autoSearch // ignore: cast_nullable_to_non_nullable
              as bool,
      isEnableLocationSetting: null == isEnableLocationSetting
          ? _value.isEnableLocationSetting
          : isEnableLocationSetting // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MapPageStateImplCopyWith<$Res>
    implements $MapPageStateCopyWith<$Res> {
  factory _$$MapPageStateImplCopyWith(
          _$MapPageStateImpl value, $Res Function(_$MapPageStateImpl) then) =
      __$$MapPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool needShowPermissionDialog,
      Set<Marker> markersSet,
      List<APIChargerSpot> chargerSpotsList,
      String? onTapMakerId,
      bool autoSearch,
      bool isEnableLocationSetting});
}

/// @nodoc
class __$$MapPageStateImplCopyWithImpl<$Res>
    extends _$MapPageStateCopyWithImpl<$Res, _$MapPageStateImpl>
    implements _$$MapPageStateImplCopyWith<$Res> {
  __$$MapPageStateImplCopyWithImpl(
      _$MapPageStateImpl _value, $Res Function(_$MapPageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? needShowPermissionDialog = null,
    Object? markersSet = null,
    Object? chargerSpotsList = null,
    Object? onTapMakerId = freezed,
    Object? autoSearch = null,
    Object? isEnableLocationSetting = null,
  }) {
    return _then(_$MapPageStateImpl(
      needShowPermissionDialog: null == needShowPermissionDialog
          ? _value.needShowPermissionDialog
          : needShowPermissionDialog // ignore: cast_nullable_to_non_nullable
              as bool,
      markersSet: null == markersSet
          ? _value._markersSet
          : markersSet // ignore: cast_nullable_to_non_nullable
              as Set<Marker>,
      chargerSpotsList: null == chargerSpotsList
          ? _value._chargerSpotsList
          : chargerSpotsList // ignore: cast_nullable_to_non_nullable
              as List<APIChargerSpot>,
      onTapMakerId: freezed == onTapMakerId
          ? _value.onTapMakerId
          : onTapMakerId // ignore: cast_nullable_to_non_nullable
              as String?,
      autoSearch: null == autoSearch
          ? _value.autoSearch
          : autoSearch // ignore: cast_nullable_to_non_nullable
              as bool,
      isEnableLocationSetting: null == isEnableLocationSetting
          ? _value.isEnableLocationSetting
          : isEnableLocationSetting // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$MapPageStateImpl implements _MapPageState {
  const _$MapPageStateImpl(
      {this.needShowPermissionDialog = false,
      final Set<Marker> markersSet = const <Marker>{},
      final List<APIChargerSpot> chargerSpotsList = const [],
      this.onTapMakerId,
      this.autoSearch = true,
      this.isEnableLocationSetting = false})
      : _markersSet = markersSet,
        _chargerSpotsList = chargerSpotsList;

// 位置情報の設定ダイアログを表示するかどうか
  @override
  @JsonKey()
  final bool needShowPermissionDialog;
// マーカーset
  final Set<Marker> _markersSet;
// マーカーset
  @override
  @JsonKey()
  Set<Marker> get markersSet {
    if (_markersSet is EqualUnmodifiableSetView) return _markersSet;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_markersSet);
  }

// 充電スポットリスト
  final List<APIChargerSpot> _chargerSpotsList;
// 充電スポットリスト
  @override
  @JsonKey()
  List<APIChargerSpot> get chargerSpotsList {
    if (_chargerSpotsList is EqualUnmodifiableListView)
      return _chargerSpotsList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chargerSpotsList);
  }

// tapされたマーカーのID
  @override
  final String? onTapMakerId;
// 自動検索
  @override
  @JsonKey()
  final bool autoSearch;
// 位置情報の設定有効化行うているかどうか
  @override
  @JsonKey()
  final bool isEnableLocationSetting;

  @override
  String toString() {
    return 'MapPageState(needShowPermissionDialog: $needShowPermissionDialog, markersSet: $markersSet, chargerSpotsList: $chargerSpotsList, onTapMakerId: $onTapMakerId, autoSearch: $autoSearch, isEnableLocationSetting: $isEnableLocationSetting)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MapPageStateImpl &&
            (identical(
                    other.needShowPermissionDialog, needShowPermissionDialog) ||
                other.needShowPermissionDialog == needShowPermissionDialog) &&
            const DeepCollectionEquality()
                .equals(other._markersSet, _markersSet) &&
            const DeepCollectionEquality()
                .equals(other._chargerSpotsList, _chargerSpotsList) &&
            (identical(other.onTapMakerId, onTapMakerId) ||
                other.onTapMakerId == onTapMakerId) &&
            (identical(other.autoSearch, autoSearch) ||
                other.autoSearch == autoSearch) &&
            (identical(
                    other.isEnableLocationSetting, isEnableLocationSetting) ||
                other.isEnableLocationSetting == isEnableLocationSetting));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      needShowPermissionDialog,
      const DeepCollectionEquality().hash(_markersSet),
      const DeepCollectionEquality().hash(_chargerSpotsList),
      onTapMakerId,
      autoSearch,
      isEnableLocationSetting);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MapPageStateImplCopyWith<_$MapPageStateImpl> get copyWith =>
      __$$MapPageStateImplCopyWithImpl<_$MapPageStateImpl>(this, _$identity);
}

abstract class _MapPageState implements MapPageState {
  const factory _MapPageState(
      {final bool needShowPermissionDialog,
      final Set<Marker> markersSet,
      final List<APIChargerSpot> chargerSpotsList,
      final String? onTapMakerId,
      final bool autoSearch,
      final bool isEnableLocationSetting}) = _$MapPageStateImpl;

  @override // 位置情報の設定ダイアログを表示するかどうか
  bool get needShowPermissionDialog;
  @override // マーカーset
  Set<Marker> get markersSet;
  @override // 充電スポットリスト
  List<APIChargerSpot> get chargerSpotsList;
  @override // tapされたマーカーのID
  String? get onTapMakerId;
  @override // 自動検索
  bool get autoSearch;
  @override // 位置情報の設定有効化行うているかどうか
  bool get isEnableLocationSetting;
  @override
  @JsonKey(ignore: true)
  _$$MapPageStateImplCopyWith<_$MapPageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
