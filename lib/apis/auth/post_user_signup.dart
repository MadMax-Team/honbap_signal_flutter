import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:honbap_signal_flutter/models/res_code_model.dart';
import 'package:http/http.dart' as http;

Future<ResCodeModel> postUserSignup(
    {required Map<String, String?> formData}) async {
  final Map<String, String> headers = {
    "Content-Type": "application/json",
  };
  final body = jsonEncode(formData);

  final res = await http.post(
    Uri.parse('http://49.50.167.52:3001/user/signup'),
    headers: headers,
    body: body,
  );

  final resJson = ResCodeModel.fromJson(json.decode(res.body));
  if (res.statusCode == 200) return resJson;

  Fluttertoast.showToast(msg: "통신에 실패했습니다.\n잠시 후 다시 시도해주세요.");
  return resJson;
}
