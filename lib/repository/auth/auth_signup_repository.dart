import 'dart:convert';
import 'package:honbap_signal_flutter/models/auth/auth_signup_model.dart';
import 'package:honbap_signal_flutter/models/res_code_model.dart';
import 'package:http/http.dart' as http;

class AuthSignupRepository {
  Future<bool> postAppSend({required String phoneNumber}) async {
    final Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    final body = jsonEncode({
      "phoneNumber": phoneNumber.replaceAll('-', ''),
    });

    final res = await http.post(
      Uri.parse(
          'https://61a5ce82-a5aa-4ae7-ad16-eb51bad03e46.mock.pstmn.io/app/send'),
      headers: headers,
      body: body,
    );

    if (res.statusCode == 200) {
      final resJson = ResCodeModel.fromJson(json.decode(res.body));
      if (resJson.code == 5000) return true;
    }

    return false;
  }

  Future<bool> postAppVerify(
      {required String phoneNumber, required String verifyCode}) async {
    final Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    final body = jsonEncode({
      "phoneNumber": phoneNumber.replaceAll('-', ''),
      "verifyCode": verifyCode,
    });

    final res = await http.post(
      Uri.parse(
          'https://61a5ce82-a5aa-4ae7-ad16-eb51bad03e46.mock.pstmn.io/app/verify'),
      headers: headers,
      body: body,
    );

    if (res.statusCode == 200) {
      final resJson = ResCodeModel.fromJson(json.decode(res.body));
      if (resJson.code == 5001) return true;
    }

    return false;
  }

  Future<ResCodeModel> postUserSignup(
      {required AuthSignupModel formData}) async {
    final Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    final body = jsonEncode(formData.toJson());

    final res = await http.post(
      Uri.parse('http://49.50.167.52:3001/user/signup'),
      headers: headers,
      body: body,
    );

    return ResCodeModel.fromJson(json.decode(res.body));
  }
}
