import 'dart:convert';
import 'dart:io';
import 'package:honbap_signal_flutter/models/kakao_login_model.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:http/http.dart' as http;

class KakaoRepository {
  Future<KakaoLoginModel?> authWithKakao() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();

      OAuthToken token = isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();

      final url = Uri.https('kapi.kakao.com', '/v2/user/me');

      final response = await http.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}'
        },
      );

      final profileInfo = json.decode(response.body);
      print(profileInfo);
      // ignore: unused_local_variable
      KakaoLoginModel kakaoAccount = KakaoLoginModel.fromJson(profileInfo);
      return kakaoAccount;
    } catch (error) {
      // ignore: avoid_print
      print('카카오톡으로 로그인 실패 $error');
      return null;
    }
  }
}
