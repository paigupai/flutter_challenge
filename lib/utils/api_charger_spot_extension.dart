import 'package:openapi/api.dart';

///
/// APIChargerSpotの拡張
///
extension APIChargerSpotEx on APIChargerSpot {
  // 営業時間の取得
  String get businessHours {
    final spotServiceTime =
        chargerSpotServiceTimes.firstWhere((element) => element.today);
    final openTime = spotServiceTime.startTime;
    final closeTime = spotServiceTime.endTime;
    if (openTime == null || closeTime == null) {
      return '-';
    }
    return '$openTime - $closeTime';
  }

  // 営業時間内かどうか
  bool get isOpen {
    final spotServiceTime =
        chargerSpotServiceTimes.firstWhere((element) => element.today);
    final openTime = spotServiceTime.startTime;
    final closeTime = spotServiceTime.endTime;
    if (openTime == null || closeTime == null) {
      return false;
    }
    final now = DateTime.now();
    final nowTime =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    return openTime.compareTo(nowTime) <= 0 &&
        closeTime.compareTo(nowTime) >= 0;
  }

  // 定休日の取得
  String get regularHoliday {
    final holidays = [];
    for (final serviceTime in chargerSpotServiceTimes) {
      // 定休日の場合
      if (serviceTime.businessDay ==
          APIChargerSpotServiceTimeBusinessDayEnum.no) {
        holidays.add(serviceTime.day.value);
      }
    }
    if (holidays.isEmpty) {
      return '-';
    }
    return holidays.join('、');
  }

  // 充電出力の取得
  String get devicesPower {
    final devicesPower = [];
    for (final device in chargerDevices) {
      devicesPower.add(device.power);
    }
    if (devicesPower.isEmpty) {
      return '-';
    }
    return '${devicesPower.toSet().toList().join('kw、')}kw';
  }
}
