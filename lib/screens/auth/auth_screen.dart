import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/auth_screen/auth_screen_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_event.dart';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_state.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_app_send_veri/post_app_send_veri_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signin/post_user_signin_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signup/post_user_signup_bloc.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/cubit/fcm_cubit.dart';
import 'package:honbap_signal_flutter/models/kakao_login_model.dart';
import 'package:honbap_signal_flutter/repository/honbab/auth/auth_repository.dart';
import 'package:honbap_signal_flutter/repository/honbab/auth/auth_signup_repository.dart';
import 'package:honbap_signal_flutter/repository/kakao/kakao_repository.dart';
import 'package:honbap_signal_flutter/screens/auth/signin/auth_signin_screen.dart';
import 'package:honbap_signal_flutter/screens/auth/signup_routes/auth_signup_route_screen.dart';
import 'package:honbap_signal_flutter/screens/auth/widgets/auth_login_button.dart';

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

  void _onSignInTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
            create: (context) =>
                SigninUserBloc(context.read<HonbabAuthRepository>()),
            child: const AuthSigninScreen()),
      ),
    );
  }

  void _authWithKakao(BuildContext context) async {
    KakaoLoginModel? kakaoModel =
        await context.read<KakaoRepository>().authWithKakao();

    if (kakaoModel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('카카오톡 로그인에 실패했습니다.'),
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
      return;
    }

    var res = await context.read<HonbabAuthRepository>().signin(
          platform: AuthenticationWith.kakao,
          kakaoModel: kakaoModel,
        );

    if (res == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('로그인에 실패했습니다.'),
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
      return;
    }

    // jwt 저장
    // const storage = FlutterSecureStorage();
    // await storage.write(key: 'jwt', value: jwt);

    // splash 화면으로 돌아가기
    context.read<AuthenticationBloc>().add(const AuthenticaionSetState(
          status: AuthenticationStatus.init,
        ));
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
      // TODO: move to home screen
      body: BlocListener<FCMCubit, FCMState>(
        listener: (context, state) {
          if (state.state == FCMEvent.message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.body ?? 'na'),
              ),
            );
          }
        },
        child: Padding(
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
                    GestureDetector(
                      onTap: () => _onSignInTap(context),
                      child: AuthLoginButton(
                        title: "로그인 하기",
                        bgColor: Colors.white,
                        borderColor: Theme.of(context).primaryColor,
                        textColor: Theme.of(context).primaryColor,
                      ),
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
                          padding:
                              EdgeInsets.symmetric(horizontal: Sizes.size14),
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
                      onTap: () => _authWithKakao(context),
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
      ),
    );
  }
}
