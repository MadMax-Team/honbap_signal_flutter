import 'dart:convert';
import 'package:honbap_signal_flutter/models/res_code_model.dart';
import 'package:http/http.dart' as http;

Future<bool> postUserSignup({required Map<String, String?> formData}) async {
  final Map<String, String> headers = {
    "Content-Type": "application/json",
  };
  final body = jsonEncode(formData);

  final res = await http.post(
    // TODO: 테스트를 위해 /success를 붙임. 나중에 제거할 것. 실패한 케이스는 /failed를 붙이면 됨
    Uri.parse(
        'https://544391a2-1b1e-4e12-a33d-d8ff653f40b1.mock.pstmn.io/user/signup/success'),
    headers: headers,
    body: body,
  );

  if (res.statusCode == 200) {
    final resJson = ResCodeModel.fromJson(json.decode(res.body));
    if (resJson.code == 1000) return true;
  }

  return false;
}
