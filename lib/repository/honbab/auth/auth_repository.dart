import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_state.dart';
import 'package:honbap_signal_flutter/models/kakao_login_model.dart';

class HonbabAuthRepository {
  Future<bool> autoSignin({
    required String jwt,
  }) async {
    // TODO: sign in with jwt
    await Future.delayed(const Duration(seconds: 1));

    print('jwt auto login');

    return true;
  }

  Future<String?> signin({
    required AuthenticationWith platform,
    KakaoLoginModel? kakaoModel,
    String? email,
    String? password,
  }) async {
    // TODO: sign in with account
    await Future.delayed(const Duration(seconds: 1));

    if (platform == AuthenticationWith.kakao) {
      // 카카로 로그인 api
      return 'jwt-kakao';
    }

    if (platform == AuthenticationWith.honbab) {
      // honbab 로그인 api
      return 'jwt-honbab';
    }

    return null;
  }

  Future<void> signout() async {
    // TODO: sign out and delete jwt
  }
}
