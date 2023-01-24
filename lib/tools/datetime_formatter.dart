import 'package:intl/intl.dart';

String diffDatetime(DateTime from) {
  DateTime now = DateTime.now();
  // 1시간 이내
  if (now.millisecondsSinceEpoch - from.millisecondsSinceEpoch <
      1000 * 60 * 60) {
    var minAgo = int.parse(now.difference(from).toString().substring(2, 4));
    return "$minAgo분 전";
  }
  // 오늘
  if (DateFormat('dd').format(now) == DateFormat('dd').format(from)) {
    return DateFormat('aa h:mm', 'ko').format(from);
  }
  // 나머지
  return DateFormat('yyyy-MM-dd aa h:mm', 'ko').format(from);
}
