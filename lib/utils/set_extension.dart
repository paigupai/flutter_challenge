import 'package:google_maps_flutter/google_maps_flutter.dart';

///
/// Set extension methods
///
class SetEx {
  ///
  /// MarkerをSet<Marker>に追加メソード
  /// BitmapDescriptorの違いが比較出来ないため、
  /// markerId.valueで比較
  ///
  static Set<Marker> addMarker(Set<Marker> markers, Marker marker) {
    // 初回追加
    if (markers.isEmpty) {
      markers.add(marker);
      return markers;
    }

    var canAdd = true;
    for (var element in markers) {
      // 既に同じmarkerIdがある場合は追加しない
      if (element.markerId.value == marker.markerId.value) {
        canAdd = false;
      }
    }

    if (canAdd) {
      markers.add(marker);
    }
    return markers;
  }
}
