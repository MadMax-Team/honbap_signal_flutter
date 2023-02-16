import 'dart:convert';

import 'package:honbap_signal_flutter/models/mypage/mypage_user_myinfo_model.dart';
import 'package:http/http.dart' as http;

Future<MyPageMyInfoModel> getMyPageMyInfo() async {
  final res = await http.get(Uri.parse(
      'https://bdaea459-09f9-46a9-88c2-06b28b0bee37.mock.pstmn.io/user/myinfo'));

  if (res.statusCode == 200) {
    return MyPageMyInfoModel.fromJson(json.decode(res.body)['result']);
  } else {
    throw Exception('_getMyPageMyInfo() failed');
  }
}
