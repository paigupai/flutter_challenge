import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map_app/model/app_model.dart';
import 'package:flutter_map_app/ui/pages/map_page/map_page.dart';
import 'package:flutter_map_app/utils/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// 縦固定
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await setUp();
  runApp(const ProviderScope(child: MyApp()));
}

GetIt getIt = GetIt.instance;

// 初期設定
Future<void> setUp() async {
  // デフォルトの位置情報
  var position = const LatLng(35.681236, 139.767125);
  try {
    // 位置情報の許可を確認
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      // 現在地取得
      final currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      position = LatLng(currentPosition.latitude, currentPosition.longitude);
    }
  } catch (e) {
    logger.d('Failed to get current location: $e');
  }
  getIt.registerSingleton<AppModel>(AppModel(currentLocation: position));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Map App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MapPage(),
    );
  }
}
