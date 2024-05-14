import 'package:openapi/api.dart';

///
/// List Extension
///
class ListEx {
  // 重複を削除
  static List<T> unique<T>(List<T> items, bool Function(T, T) compare) {
    return items.where((item) {
      return !items.where((other) => compare(item, other)).skip(1).isNotEmpty;
    }).toList();
  }

  // 重複したAPIChargerSpotを削除
  static List<APIChargerSpot> uniqueChargerSpot(List<APIChargerSpot> items) {
    return unique(items, (a, b) => a.uuid == b.uuid);
  }
}
