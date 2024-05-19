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

    final markerIds = markers.map((e) => e.markerId.value).toList();
    // 既に同じmarkerIdが存在する場合は追加しない
    if (markerIds.contains(marker.markerId.value)) {
      return markers;
    }
    markers.add(marker);
    return markers;
  }
}
