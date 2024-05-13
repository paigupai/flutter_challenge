import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map_app/ui/pages/map_page_view_model.dart';
import 'package:flutter_map_app/utils/api_charger_spot_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:openapi/api.dart';

///
/// 地図ページ
///
class MapPage extends ConsumerStatefulWidget {
  const MapPage({super.key});

  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends ConsumerState<MapPage> with WidgetsBindingObserver {
  GoogleMapController? _controller;

  // デフォルトの位置情報
  static const _defaultLocation = LatLng(35.681236, 139.767125);

  late final MapPageNotifier _notifier;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _notifier = ref.read(mapPageNotifierProvider.notifier);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // アプリがフォアグラウンドに戻った時の処理
      print('App is back to foreground');
      _refreshCurrentLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    // 位置情報の設定ダイアログlistener
    _showPermissionDialogListener();
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          _buildMap(),
          _buildChargerSpotCardList(),
        ]),
      ),
      floatingActionButton: IconButton(
        onPressed: _refreshCurrentLocation,
        icon: SvgPicture.asset(
          'assets/icons/location_button_icon.svg',
          width: 62,
          height: 62,
        ),
      ),
    );
  }

  // 地図ウィジェット
  Widget _buildMap() {
    return Consumer(builder: (context, ref, _) {
      // マーカーの取得
      final markersList = ref.watch(mapPageNotifierProvider.select((value) {
        return value.markersList;
      }));
      return GoogleMap(
        mapType: MapType.normal,
        zoomControlsEnabled: false,
        initialCameraPosition: const CameraPosition(
          target: _defaultLocation,
          zoom: 15.0,
        ),
        onMapCreated: (GoogleMapController controller) async {
          _controller = controller;

          // 位置情報の設定ダイアログを表示するかどうかをチェック
          await _notifier.checkLocationSettingDialog();
          await _refreshCurrentLocation();
        },
        onCameraIdle: () async {
          // カメラの位置が変更された時の処理
          final bounds = await _controller!.getVisibleRegion();
          // 左下と右上の座標を取得
          final southwest = bounds.southwest;
          final northeast = bounds.northeast;
          await _notifier.updateChargingSpot(
            southwest: southwest,
            northeast: northeast,
          );
        },
        markers: markersList.toSet(),
      );
    });
  }

  // 充電スポットカードリスト
  Widget _buildChargerSpotCardList() {
    return Consumer(builder: (context, ref, _) {
      final width = MediaQuery.sizeOf(context).width;
      // 充電スポットのリスト
      final chargerSpots = ref.watch(mapPageNotifierProvider.select(
        (value) => value.chargerSpots,
      ));
      return Align(
        alignment: Alignment.bottomCenter,
        child: FractionallySizedBox(
          heightFactor: 0.3,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: chargerSpots.length,
            itemBuilder: (context, index) {
              final chargerSpot = chargerSpots[index];
              return GestureDetector(
                onTap: () {
                  // 選択された充電スポットのIDを更新
                  // _notifier.updateSelectedId(chargerSpot.uuid);
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 16, bottom: 20),
                  width: width * 0.8,
                  child: Card(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _cardImage(chargerSpot.images),
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
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }

  // カードの画像ウィジェット
  Widget _cardImage(List<APIChargerSpotImage> images) {
    if (images.isEmpty) {
      return SvgPicture.asset(
        'assets/images/no_image.svg',
        height: 60,
        fit: BoxFit.cover,
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
        _notifier.openMapApp(
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

  // 現在の位置情報を更新
  Future<void> _refreshCurrentLocation() async {
    final currentLocation = await _notifier.fetchCurrentLocation();
    // 権限がない場合
    if (currentLocation == null) {
      return;
    }
    await _controller?.animateCamera(CameraUpdate.newLatLng(currentLocation));
    await _notifier.updateCurrentLocation(currentLocation);
  }

  // 位置情報の設定ダイアログlistener
  void _showPermissionDialogListener() {
    ref.listen(
        mapPageNotifierProvider.select(
            (value) => value.needShowPermissionDialog), (previous, next) {
      if (next) {
        // 位置情報の設定ダイアログを表示
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('位置情報の設定'),
              content: const Text('位置情報の設定を有効にしてください'),
              actions: <Widget>[
                TextButton(
                  child: const Text('キャンセル'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('設定'),
                  onPressed: () {
                    _notifier.enableLocationSetting();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }
}
