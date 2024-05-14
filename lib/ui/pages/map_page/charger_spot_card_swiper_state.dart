import 'package:freezed_annotation/freezed_annotation.dart';

part 'charger_spot_card_swiper_state.freezed.dart';

///
/// 充電スポットカードスワイパーの状態
///
@freezed
class ChargerSpotCardSwiperState with _$ChargerSpotCardSwiperState {
  const factory ChargerSpotCardSwiperState({
    // 選択中の充電スポットカードのID
    String? selectedCardId,
    // card swiper move中かどうか
    @Default(false) bool isSwiping,
    // card swiperを表示するかどうか
    @Default(true) bool needShowCardSwiper,
  }) = _ChargerSpotCardSwiperState;
}
