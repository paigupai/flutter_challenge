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
      throw _privateConstructorUsedError; // 現在地
  LatLng? get currentLocation => throw _privateConstructorUsedError; // マーカーリスト
  List<Marker> get markersList =>
      throw _privateConstructorUsedError; // 充電スポットリスト
  List<APIChargerSpot> get chargerSpots =>
      throw _privateConstructorUsedError; // 選択された充電スポット
  String? get selectedId => throw _privateConstructorUsedError;

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
      LatLng? currentLocation,
      List<Marker> markersList,
      List<APIChargerSpot> chargerSpots,
      String? selectedId});
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
    Object? currentLocation = freezed,
    Object? markersList = null,
    Object? chargerSpots = null,
    Object? selectedId = freezed,
  }) {
    return _then(_value.copyWith(
      needShowPermissionDialog: null == needShowPermissionDialog
          ? _value.needShowPermissionDialog
          : needShowPermissionDialog // ignore: cast_nullable_to_non_nullable
              as bool,
      currentLocation: freezed == currentLocation
          ? _value.currentLocation
          : currentLocation // ignore: cast_nullable_to_non_nullable
              as LatLng?,
      markersList: null == markersList
          ? _value.markersList
          : markersList // ignore: cast_nullable_to_non_nullable
              as List<Marker>,
      chargerSpots: null == chargerSpots
          ? _value.chargerSpots
          : chargerSpots // ignore: cast_nullable_to_non_nullable
              as List<APIChargerSpot>,
      selectedId: freezed == selectedId
          ? _value.selectedId
          : selectedId // ignore: cast_nullable_to_non_nullable
              as String?,
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
      LatLng? currentLocation,
      List<Marker> markersList,
      List<APIChargerSpot> chargerSpots,
      String? selectedId});
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
    Object? currentLocation = freezed,
    Object? markersList = null,
    Object? chargerSpots = null,
    Object? selectedId = freezed,
  }) {
    return _then(_$MapPageStateImpl(
      needShowPermissionDialog: null == needShowPermissionDialog
          ? _value.needShowPermissionDialog
          : needShowPermissionDialog // ignore: cast_nullable_to_non_nullable
              as bool,
      currentLocation: freezed == currentLocation
          ? _value.currentLocation
          : currentLocation // ignore: cast_nullable_to_non_nullable
              as LatLng?,
      markersList: null == markersList
          ? _value._markersList
          : markersList // ignore: cast_nullable_to_non_nullable
              as List<Marker>,
      chargerSpots: null == chargerSpots
          ? _value._chargerSpots
          : chargerSpots // ignore: cast_nullable_to_non_nullable
              as List<APIChargerSpot>,
      selectedId: freezed == selectedId
          ? _value.selectedId
          : selectedId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$MapPageStateImpl implements _MapPageState {
  const _$MapPageStateImpl(
      {this.needShowPermissionDialog = false,
      this.currentLocation,
      final List<Marker> markersList = const [],
      final List<APIChargerSpot> chargerSpots = const [],
      this.selectedId})
      : _markersList = markersList,
        _chargerSpots = chargerSpots;

// 位置情報の設定ダイアログを表示するかどうか
  @override
  @JsonKey()
  final bool needShowPermissionDialog;
// 現在地
  @override
  final LatLng? currentLocation;
// マーカーリスト
  final List<Marker> _markersList;
// マーカーリスト
  @override
  @JsonKey()
  List<Marker> get markersList {
    if (_markersList is EqualUnmodifiableListView) return _markersList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_markersList);
  }

// 充電スポットリスト
  final List<APIChargerSpot> _chargerSpots;
// 充電スポットリスト
  @override
  @JsonKey()
  List<APIChargerSpot> get chargerSpots {
    if (_chargerSpots is EqualUnmodifiableListView) return _chargerSpots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chargerSpots);
  }

// 選択された充電スポット
  @override
  final String? selectedId;

  @override
  String toString() {
    return 'MapPageState(needShowPermissionDialog: $needShowPermissionDialog, currentLocation: $currentLocation, markersList: $markersList, chargerSpots: $chargerSpots, selectedId: $selectedId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MapPageStateImpl &&
            (identical(
                    other.needShowPermissionDialog, needShowPermissionDialog) ||
                other.needShowPermissionDialog == needShowPermissionDialog) &&
            (identical(other.currentLocation, currentLocation) ||
                other.currentLocation == currentLocation) &&
            const DeepCollectionEquality()
                .equals(other._markersList, _markersList) &&
            const DeepCollectionEquality()
                .equals(other._chargerSpots, _chargerSpots) &&
            (identical(other.selectedId, selectedId) ||
                other.selectedId == selectedId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      needShowPermissionDialog,
      currentLocation,
      const DeepCollectionEquality().hash(_markersList),
      const DeepCollectionEquality().hash(_chargerSpots),
      selectedId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MapPageStateImplCopyWith<_$MapPageStateImpl> get copyWith =>
      __$$MapPageStateImplCopyWithImpl<_$MapPageStateImpl>(this, _$identity);
}

abstract class _MapPageState implements MapPageState {
  const factory _MapPageState(
      {final bool needShowPermissionDialog,
      final LatLng? currentLocation,
      final List<Marker> markersList,
      final List<APIChargerSpot> chargerSpots,
      final String? selectedId}) = _$MapPageStateImpl;

  @override // 位置情報の設定ダイアログを表示するかどうか
  bool get needShowPermissionDialog;
  @override // 現在地
  LatLng? get currentLocation;
  @override // マーカーリスト
  List<Marker> get markersList;
  @override // 充電スポットリスト
  List<APIChargerSpot> get chargerSpots;
  @override // 選択された充電スポット
  String? get selectedId;
  @override
  @JsonKey(ignore: true)
  _$$MapPageStateImplCopyWith<_$MapPageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
