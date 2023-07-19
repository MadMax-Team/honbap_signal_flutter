import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_state.dart';
import 'package:honbap_signal_flutter/models/kakao_login_model.dart';
import 'package:honbap_signal_flutter/models/user/user_model.dart';

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

  Future<UserModel?> getUserData(String jwt) async {
    // TODO : [POST] /user/myinfo
    // get user data
    await Future.delayed(const Duration(seconds: 1));

    return const UserModel(
      userId: 1,
      userName: 'test-woong',
      birth: '2000년06월11일',
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
