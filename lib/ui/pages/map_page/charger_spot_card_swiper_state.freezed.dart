// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'charger_spot_card_swiper_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChargerSpotCardSwiperState {
// 選択中の充電スポットカードのID
  String? get selectedCardId =>
      throw _privateConstructorUsedError; // card swiper move中かどうか
  bool get isSwiping =>
      throw _privateConstructorUsedError; // card swiperを表示するかどうか
  bool get needShowCardSwiper => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChargerSpotCardSwiperStateCopyWith<ChargerSpotCardSwiperState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChargerSpotCardSwiperStateCopyWith<$Res> {
  factory $ChargerSpotCardSwiperStateCopyWith(ChargerSpotCardSwiperState value,
          $Res Function(ChargerSpotCardSwiperState) then) =
      _$ChargerSpotCardSwiperStateCopyWithImpl<$Res,
          ChargerSpotCardSwiperState>;
  @useResult
  $Res call({String? selectedCardId, bool isSwiping, bool needShowCardSwiper});
}

/// @nodoc
class _$ChargerSpotCardSwiperStateCopyWithImpl<$Res,
        $Val extends ChargerSpotCardSwiperState>
    implements $ChargerSpotCardSwiperStateCopyWith<$Res> {
  _$ChargerSpotCardSwiperStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedCardId = freezed,
    Object? isSwiping = null,
    Object? needShowCardSwiper = null,
  }) {
    return _then(_value.copyWith(
      selectedCardId: freezed == selectedCardId
          ? _value.selectedCardId
          : selectedCardId // ignore: cast_nullable_to_non_nullable
              as String?,
      isSwiping: null == isSwiping
          ? _value.isSwiping
          : isSwiping // ignore: cast_nullable_to_non_nullable
              as bool,
      needShowCardSwiper: null == needShowCardSwiper
          ? _value.needShowCardSwiper
          : needShowCardSwiper // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChargerSpotCardSwiperStateImplCopyWith<$Res>
    implements $ChargerSpotCardSwiperStateCopyWith<$Res> {
  factory _$$ChargerSpotCardSwiperStateImplCopyWith(
          _$ChargerSpotCardSwiperStateImpl value,
          $Res Function(_$ChargerSpotCardSwiperStateImpl) then) =
      __$$ChargerSpotCardSwiperStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? selectedCardId, bool isSwiping, bool needShowCardSwiper});
}

/// @nodoc
class __$$ChargerSpotCardSwiperStateImplCopyWithImpl<$Res>
    extends _$ChargerSpotCardSwiperStateCopyWithImpl<$Res,
        _$ChargerSpotCardSwiperStateImpl>
    implements _$$ChargerSpotCardSwiperStateImplCopyWith<$Res> {
  __$$ChargerSpotCardSwiperStateImplCopyWithImpl(
      _$ChargerSpotCardSwiperStateImpl _value,
      $Res Function(_$ChargerSpotCardSwiperStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedCardId = freezed,
    Object? isSwiping = null,
    Object? needShowCardSwiper = null,
  }) {
    return _then(_$ChargerSpotCardSwiperStateImpl(
      selectedCardId: freezed == selectedCardId
          ? _value.selectedCardId
          : selectedCardId // ignore: cast_nullable_to_non_nullable
              as String?,
      isSwiping: null == isSwiping
          ? _value.isSwiping
          : isSwiping // ignore: cast_nullable_to_non_nullable
              as bool,
      needShowCardSwiper: null == needShowCardSwiper
          ? _value.needShowCardSwiper
          : needShowCardSwiper // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ChargerSpotCardSwiperStateImpl implements _ChargerSpotCardSwiperState {
  const _$ChargerSpotCardSwiperStateImpl(
      {this.selectedCardId,
      this.isSwiping = false,
      this.needShowCardSwiper = true});

// 選択中の充電スポットカードのID
  @override
  final String? selectedCardId;
// card swiper move中かどうか
  @override
  @JsonKey()
  final bool isSwiping;
// card swiperを表示するかどうか
  @override
  @JsonKey()
  final bool needShowCardSwiper;

  @override
  String toString() {
    return 'ChargerSpotCardSwiperState(selectedCardId: $selectedCardId, isSwiping: $isSwiping, needShowCardSwiper: $needShowCardSwiper)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChargerSpotCardSwiperStateImpl &&
            (identical(other.selectedCardId, selectedCardId) ||
                other.selectedCardId == selectedCardId) &&
            (identical(other.isSwiping, isSwiping) ||
                other.isSwiping == isSwiping) &&
            (identical(other.needShowCardSwiper, needShowCardSwiper) ||
                other.needShowCardSwiper == needShowCardSwiper));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, selectedCardId, isSwiping, needShowCardSwiper);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChargerSpotCardSwiperStateImplCopyWith<_$ChargerSpotCardSwiperStateImpl>
      get copyWith => __$$ChargerSpotCardSwiperStateImplCopyWithImpl<
          _$ChargerSpotCardSwiperStateImpl>(this, _$identity);
}

abstract class _ChargerSpotCardSwiperState
    implements ChargerSpotCardSwiperState {
  const factory _ChargerSpotCardSwiperState(
      {final String? selectedCardId,
      final bool isSwiping,
      final bool needShowCardSwiper}) = _$ChargerSpotCardSwiperStateImpl;

  @override // 選択中の充電スポットカードのID
  String? get selectedCardId;
  @override // card swiper move中かどうか
  bool get isSwiping;
  @override // card swiperを表示するかどうか
  bool get needShowCardSwiper;
  @override
  @JsonKey(ignore: true)
  _$$ChargerSpotCardSwiperStateImplCopyWith<_$ChargerSpotCardSwiperStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
