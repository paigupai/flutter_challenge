import 'dart:async';

import 'package:flutter_map_app/ui/pages/map_page/charger_spot_card_swiper_state.dart';
import 'package:flutter_map_app/ui/pages/map_page/map_page_notifier.dart';
import 'package:openapi/api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'charger_spot_card_swiper_notifier.g.dart';

///
/// 充電スポットカードスワイパーの状態を管理するNotifier
///
@riverpod
class ChargerSpotCardSwiperNotifier extends _$ChargerSpotCardSwiperNotifier {
  Timer? _debounceTimer;

  @override
  ChargerSpotCardSwiperState build() {
    return const ChargerSpotCardSwiperState();
  }

  // 現在選択されている充電スポットを更新
  // card swiperで選択された充電スポットのマーカーを更新
  void updateSelectedChargerSpot(APIChargerSpot chargerSpot) {
    state = state.copyWith(
        needShowCardSwiper: true, selectedCardId: chargerSpot.uuid);
  }

  // MarkerIdを更新
  void updateOnTapMakerId(APIChargerSpot chargerSpot) {
    // 頻繁に呼ばれるのでデバウンス処理つける
    if (_debounceTimer != null) {
      _debounceTimer!.cancel();
    }
    _debounceTimer = Timer(const Duration(microseconds: 500), () {
      ref
          .read(mapPageNotifierProvider.notifier)
          .updateOnTapMakerId(chargerSpot.uuid);
    });
  }

  // card swiper move中かどうかを更新
  void updateIsSwiping(bool isSwiping) {
    state = state.copyWith(isSwiping: isSwiping);
  }

  // card swiperを表示するかどうかを更新
  void updateNeedShowCardSwiper(bool needShowCardSwiper) {
    state = state.copyWith(needShowCardSwiper: needShowCardSwiper);
  }
}
