import 'dart:convert';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_state.dart';
import 'package:honbap_signal_flutter/constants/api.dart';
import 'package:honbap_signal_flutter/models/auth/auth_signin_model.dart';
import 'package:honbap_signal_flutter/models/kakao_login_model.dart';
import 'package:honbap_signal_flutter/models/user/user_model.dart';
import 'package:http/http.dart' as http;

class HonbabAuthRepository {
  Future<bool> autoSignin({
    required String jwt,
  }) async {
    // TODO: sign in with jwt
    await Future.delayed(const Duration(seconds: 1));

    print('[JWT auto login]');

    return true;
  }

  Future<AuthSigninMyInfoModel?> signin({
    required AuthenticationWith platform,
    KakaoLoginModel? kakaoModel,
    String? email,
    String? password,
  }) async {
    print('[Get JWT] Platform: $platform');
    try {
      if (platform == AuthenticationWith.kakao) {
        print(kakaoModel?.kakaoAccount.email);
        // 카카로 로그인 api
        return null;
      }

      if (platform == AuthenticationWith.honbab) {
        final Map<String, String> headers = {
          "Content-Type": "application/json",
        };
        final body = jsonEncode({
          "email": email,
          "password": password,
        });

        final res = await http.post(
          Uri.parse('${ApiEndpoint.honbab}/user/login'),
          headers: headers,
          body: body,
        );

        print(res.body);

        return AuthSigninMyInfoModel.fromJson(json.decode(res.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<UserModel?> getUserData(String jwt) async {
    try {
      final Map<String, String> headers = {
        "Content-Type": "application/json",
        'x-access-token': jwt,
      };

      final res = await http.get(
        Uri.parse('${ApiEndpoint.honbab}/user/myinfo'),
        headers: headers,
      );

      final resModel =
          AuthSigninMyInfoModel.fromJson(await json.decode(res.body));

      return UserModel.fromJson(resModel.result!.toJson());
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<AuthSigninMyPageModel?> getUserProfileData(String jwt) async {
    try {
      final Map<String, String> headers = {
        "Content-Type": "application/json",
        'x-access-token': jwt,
      };

      final res = await http.get(
        Uri.parse('${ApiEndpoint.honbab}/user/mypage'),
        headers: headers,
      );

      print(res.body);

      return AuthSigninMyPageModel.fromJson(await json.decode(res.body));
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> signout() async {
    // TODO: sign out and delete jwt
  }
}
