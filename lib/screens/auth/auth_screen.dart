import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/auth_screen/auth_screen_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_app_send_veri/post_app_send_veri_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signup/post_user_signup_bloc.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/models/kakao_login_model.dart';
import 'package:honbap_signal_flutter/repository/honbab/auth/auth_signup_repository.dart';
import 'package:honbap_signal_flutter/screens/auth/auth_signup_route_screen.dart';
import 'package:honbap_signal_flutter/screens/auth/widgets/auth_login_button.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:http/http.dart' as http;

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  void _onSignUpTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider<AuthScreenBloc>(
              create: (context) => AuthScreenBloc(),
            ),
            BlocProvider<SignupUserBloc>(
              create: (context) => SignupUserBloc(
                authSignupRepository:
                    context.read<HonbabAuthSignupRepository>(),
              ),
            ),
            BlocProvider<SignupPhoneBloc>(
              create: (context) => SignupPhoneBloc(
                authSignupRepository:
                    context.read<HonbabAuthSignupRepository>(),
              ),
            ),
          ],
          child: const AuthSignupRouteScreen(),
        ),
      ),
    );
  }

  void _authWithKakao() async {
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
    } catch (error) {
      // ignore: avoid_print
      print('카카오톡으로 로그인 실패 $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(Sizes.size20),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "함께 밥 먹을 친구를",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              "찾아볼까요?",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Flexible(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.grey.shade400,
                    height: 150,
                    child: const Center(
                      child: Text('이미지'),
                    ),
                  ),
                  Gaps.v10,
                  GestureDetector(
                    onTap: () => _onSignUpTap(context),
                    child: AuthLoginButton(
                      title: "회원가입 하기",
                      bgColor: Theme.of(context).primaryColor,
                      borderColor: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                    ),
                  ),
                  Gaps.v10,
                  AuthLoginButton(
                    title: "로그인 하기",
                    bgColor: Colors.white,
                    borderColor: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                          height: Sizes.size2,
                          color: const Color(0xffe6e6e6),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: Sizes.size14),
                        child: Text(
                          '간편로그인',
                          style: TextStyle(
                            color: Color(0xFFB8B8B8),
                            fontSize: Sizes.size14,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          height: Sizes.size2,
                          color: const Color(0xffe6e6e6),
                        ),
                      ),
                    ],
                  ),
                  Gaps.v20,
                  GestureDetector(
                    onTap: _authWithKakao,
                    child: AuthLoginButton(
                      title: "카카오로 로그인",
                      bgColor: const Color(0xffffe500),
                      borderColor: const Color(0xffffe500),
                      textColor: const Color(0xff402326),
                      icon: Image.asset(
                        'assets/images/kakaotalk_logo.png',
                        width: Sizes.size24,
                        height: Sizes.size24,
                      ),
                    ),
                  ),
                  Gaps.v10,
                  Text(
                    '회원가입 시 혼밥시그널의 서비스 이용 약관과 개인정보 보호정책에 동의하게 됩니다.',
                    style: Theme.of(context).textTheme.labelSmall,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
