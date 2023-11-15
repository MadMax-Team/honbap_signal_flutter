import 'package:intl/intl.dart';

String diffDatetime(DateTime from) {
  DateTime now = DateTime.now();
  var timeZoneOffset = now.timeZoneOffset.inMilliseconds;
  int localNow = now.millisecondsSinceEpoch;
  int localFrom = from.millisecondsSinceEpoch - timeZoneOffset;

  DateTime dateNow = DateTime.fromMillisecondsSinceEpoch(localNow);
  DateTime dateFrom = DateTime.fromMillisecondsSinceEpoch(localFrom);
  // 1시간 이내
  if (localNow - localFrom < 1000 * 60 * 60) {
    var time = dateNow
        .difference(dateFrom)
        .toString()
        .split(' ')
        .last
        .split('.')
        .first;
    var minAgo = int.parse(time.padLeft(8, '0').substring(3, 5));
    return "$minAgo분 전";
  }
  // 오늘
  if (DateFormat('dd').format(dateNow) == DateFormat('dd').format(dateFrom)) {
    return DateFormat('aa h:mm', 'ko').format(dateFrom);
  }
  // 나머지
  return DateFormat('yyyy-MM-dd aa h:mm', 'ko').format(dateFrom);
}
