import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_app/ui/pages/map_page/charger_spot_card_swiper_view_model.dart';
import 'package:flutter_map_app/ui/pages/map_page/map_page_view_model.dart';
import 'package:flutter_map_app/utils/api_charger_spot_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:openapi/api.dart';

///
/// 充電スポットカードのスワイパー
///
class ChargerSpotCardSwiper extends ConsumerStatefulWidget {
  const ChargerSpotCardSwiper({super.key});

  @override
  ConsumerState createState() => _ChargerSpotCardSwiperState();
}

class _ChargerSpotCardSwiperState extends ConsumerState<ChargerSpotCardSwiper> {
  late SwiperController _swiperController;
  late final MapPageNotifier _mapNotifier;
  late final ChargerSpotCardSwiperNotifier _cardNotifier;

  @override
  void initState() {
    super.initState();
    _swiperController = SwiperController();
    _mapNotifier = ref.read(mapPageNotifierProvider.notifier);
    _cardNotifier = ref.read(chargerSpotCardSwiperNotifierProvider.notifier);
  }

  @override
  void dispose() {
    _swiperController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _updateChargerSpotCardSwiperListener();
    // 充電スポットのリスト
    final chargerSpots = ref.watch(mapPageNotifierProvider.select(
      (value) => value.chargerSpots,
    ));

    if (chargerSpots.isEmpty) {
      return const SizedBox.shrink();
    }

    return Align(
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: 0.3,
        child: Swiper(
          itemCount: chargerSpots.length,
          loop: false,
          viewportFraction: 0.85,
          controller: _swiperController,
          onIndexChanged: (index) {
            final isSwiping = ref.read(chargerSpotCardSwiperNotifierProvider
                .select((value) => value.isSwiping));
            // スワイプ中は処理しない
            if (isSwiping) {
              return;
            }
            // カードがスワイプされた時の処理
            _cardNotifier.updateOnTapMakerId(chargerSpots[index]);
          },
          itemBuilder: (context, index) {
            final chargerSpot = chargerSpots[index];
            return chargerSpotCardSwiper(chargerSpot);
          },
        ),
      ),
    );
  }

  // 充電スポットカードウィジェット
  Widget chargerSpotCardSwiper(APIChargerSpot chargerSpot) {
    return Card(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
              child: _cardImage(chargerSpot.images)),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 8),
            child: Text(chargerSpot.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: _chargerSpotInfo(chargerSpot),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: _openMapAppLinkView(chargerSpot),
          ),
        ],
      ),
    );
  }

  // カードの画像ウィジェット
  Widget _cardImage(List<APIChargerSpotImage> images) {
    if (images.isEmpty) {
      return Row(
        children: [
          Expanded(
            child: SvgPicture.asset(
              'assets/images/no_image.svg',
              height: 60,
              fit: BoxFit.fill,
            ),
          ),
        ],
      );
    }
    if (images.length > 1) {
      return Row(children: [
        Expanded(
          child: Image.network(
            images[0].url,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          width: 6,
        ),
        Expanded(
          child: Image.network(
            images[1].url,
            height: 60,
            fit: BoxFit.cover,
          ),
        )
      ]);
    }

    return Image.network(
      images.first.url,
      width: MediaQuery.sizeOf(context).width * 0.8,
      height: 60,
      fit: BoxFit.cover,
    );
  }

  // 充電スポット情報
  Widget _chargerSpotInfo(APIChargerSpot chargerSpot) {
    return Table(columnWidths: const {
      0: FlexColumnWidth(1),
      1: FlexColumnWidth(2),
    }, children: [
      TableRow(children: [
        const Text('充電器数'),
        Text('${chargerSpot.chargerDevices.length.toString()}台'),
      ]),
      TableRow(children: [
        const Text('充電出力'),
        Text(chargerSpot.devicesPower),
      ]),
      TableRow(children: [
        if (chargerSpot.isOpen)
          const Text(
            '営業中',
            style: TextStyle(
              color: Colors.green,
            ),
          )
        else
          const Text(
            '営業時間外',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        Text(chargerSpot.businessHours),
      ]),
      TableRow(children: [
        const Text('定休日'),
        Text(chargerSpot.regularHoliday),
      ]),
    ]);
  }

  // 地図アプリを開くlink view
  Widget _openMapAppLinkView(APIChargerSpot chargerSpot) {
    return GestureDetector(
      onTap: () {
        // 地図アプリを開く
        _mapNotifier.openMapApp(
          latitude: chargerSpot.latitude,
          longitude: chargerSpot.longitude,
        );
      },
      child: const Row(
        children: [
          Text(
            '地図アプリで開く',
            style: TextStyle(
              decoration: TextDecoration.underline,
              decorationColor: Colors.green,
              color: Colors.green,
            ),
          ),
          Icon(Icons.filter_none, color: Colors.green, size: 16),
        ],
      ),
    );
  }

  // 選択させた充電スポットカードを更新
  void _updateChargerSpotCardSwiperListener() {
    ref.listen(
        chargerSpotCardSwiperNotifierProvider
            .select((value) => value.selectedCardId), (previous, next) async {
      if (next == null) {
        return;
      }
      final chargerSpots = ref
          .read(mapPageNotifierProvider.select((value) => value.chargerSpots));
      final index = chargerSpots.indexWhere((element) => element.uuid == next);

      _cardNotifier.updateIsSwiping(true);
      await _swiperController.move(index, animation: true);
      _cardNotifier.updateIsSwiping(false);
    });
  }
}
