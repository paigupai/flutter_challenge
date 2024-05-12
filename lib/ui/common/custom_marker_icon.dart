import 'package:flutter/material.dart';
import 'package:flutter_map_app/utils/widget_extension.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simple_shadow/simple_shadow.dart';

///
/// marker用のカスタムアイコン
///
class CustomMarkerIcon {
  // 現在地アイコン
  static Future<BitmapDescriptor> getCurrentLocationIcon() async {
    return SvgPicture.asset(
      'assets/icons/current_location_icon.svg',
      width: 40,
      height: 40,
      fit: BoxFit.contain,
    ).toBitmapDescriptor();
  }

  // チャージャーアイコン
  static Future<BitmapDescriptor> getChargingSpotIcon({
    required int chargerCount,
  }) async {
    return SizedBox(
      width: 45,
      height: 64,
      child: Stack(
        children: [
          SimpleShadow(
            opacity: 0.3,
            child: SvgPicture.asset(
              'assets/icons/marker_icon.svg',
              width: 45,
              height: 64,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            top: 12,
            left: 9,
            child: Container(
              width: 22,
              height: 22,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  chargerCount.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ).toBitmapDescriptor();
  }
}
