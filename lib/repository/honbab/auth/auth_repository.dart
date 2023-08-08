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

  Future<AuthSigninModel?> signin({
    required AuthenticationWith platform,
    KakaoLoginModel? kakaoModel,
    String? email,
    String? password,
  }) async {
    print('[Get JWT] Platform: $platform');

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

      return AuthSigninModel.fromJson(json.decode(res.body));
    }

    return null;
  }

  Future<UserModel?> getUserData(String jwt) async {
    // TODO : [POST] /user/myinfo
    // get user data
    await Future.delayed(const Duration(seconds: 1));

    return const UserModel(
      userId: 1,
      userName: 'test-woong',
      birth: '2000-06-11',
      email: 'wjlee611@gmail.com',
      phoneNum: '01012341234',
      sex: 'M',
      createAt: '2022-01-20T05:12:01.000Z',
      updateAt: '2022-01-20T05:12:01.000Z',
    );
  }

  Future<UserProfileModel?> getUserProfileData(String jwt) async {
    // TODO : [POST] /user/mypage
    // get user profile data
    await Future.delayed(const Duration(seconds: 1));

    return const UserProfileModel(
      profileImg: 'woong-image-path',
      taste: 'taste',
      hateFood: 'hatefood',
      interest: 'coding',
      avgSpeed: 'speed of light',
      preferArea: 'preferarea',
      mbti: 'ISFJ',
      userIntroduce: 'hello world @from copilot',
      updateAt: '2022-01-20T05:12:01.000Z',
    );
  }

  Future<void> signout() async {
    // TODO: sign out and delete jwt
  }
}
