import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_event.dart';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_state.dart';
import 'package:honbap_signal_flutter/bloc/splash/splash_bloc.dart';
import 'package:honbap_signal_flutter/bloc/splash/splash_event.dart';
import 'package:honbap_signal_flutter/bloc/splash/splash_state.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/cubit/user_cubit.dart';
import 'package:honbap_signal_flutter/models/auth/auth_signin_model.dart';
import 'package:honbap_signal_flutter/repository/honbab/auth/auth_repository.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  // 자동 로그인 - jwt 유효성 검사
  Future<void> autoSignin(BuildContext context) async {
    const storage = FlutterSecureStorage();
    String? userAuth = await storage.read(key: 'userAuth');

    if (userAuth == null) {
      // 로그인 실패
      context.read<AuthenticationBloc>().add(const AuthenticaionSetState(
            status: AuthenticationStatus.unauthenticated,
          ));
      return;
    }

    final userAuthModel =
        AuthSigninUserDataModel.fromJson(await jsonDecode(userAuth));

    debugPrint(
        '자동 로그인 - jwt 유효성 검사 [jwt: ${userAuthModel.jwt}, userIdx: ${userAuthModel.userIdx}]');

    var res = await context.read<HonbabAuthRepository>().autoSignin(
          jwt: userAuthModel.jwt!,
          userIdx: userAuthModel.userIdx!,
        );
    if (res) {
      // 로그인 성공
      context.read<UserCubit>().setUserAuth(
            jwt: userAuthModel.jwt!,
            userIdx: userAuthModel.userIdx!,
          );
      context.read<SplashBloc>().add(const SplashChangeLoadStateEvent(
            status: LoadStatus.loadingUserData,
          ));

      return;
    }

    // 자동 로그인 실패
    context.read<AuthenticationBloc>().add(const AuthenticaionSetState(
          status: AuthenticationStatus.unauthenticated,
        ));
  }

  // 기본 사용자 정보 로드
  Future<void> getUserData(BuildContext context) async {
    var user = context.read<UserCubit>().state.user;
    var newUserModel =
        await context.read<HonbabAuthRepository>().getUserData(user!.jwt!);

    if (newUserModel != null) {
      context.read<UserCubit>().setUserData(newUserModel);
      context.read<SplashBloc>().add(const SplashChangeLoadStateEvent(
            status: LoadStatus.loadingUserProfileData,
          ));

      return;
    }
    // 사용자 정보 불러오기 실패
    context.read<AuthenticationBloc>().add(const AuthenticaionSetState(
          status: AuthenticationStatus.unauthenticated,
        ));
  }

  // 사용자 프로필 정보 로드
  Future<void> getUserProfileData(BuildContext context) async {
    var user = context.read<UserCubit>().state.user;
    var userProfileRes = await context
        .read<HonbabAuthRepository>()
        .getUserProfileData(user!.jwt!);

    if (userProfileRes == null ||
        userProfileRes.result == null ||
        userProfileRes.code != 1000) {
      // 사용자 정보 불러오기 실패
      context.read<AuthenticationBloc>().add(const AuthenticaionSetState(
            status: AuthenticationStatus.unauthenticated,
          ));
      return;
    }

    context.read<UserCubit>().setUserProfileData(userProfileRes.result!);

    if (userProfileRes.result?.nickName == null) {
      // 아직 프로필 설정이 끝나지 않았을 때: 처음 로그인 시
      context.read<AuthenticationBloc>().add(const AuthenticaionSetState(
            status: AuthenticationStatus.firstAuthenticated,
          ));
      return;
    }

    context.read<AuthenticationBloc>().add(const AuthenticaionSetState(
          status: AuthenticationStatus.authenticated,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state.status == AuthenticationStatus.init) {
          context.read<AuthenticationBloc>().add(const AuthenticaionSetState(
                status: AuthenticationStatus.loading,
              ));
          context.read<SplashBloc>().add(const SplashChangeLoadStateEvent(
                status: LoadStatus.init,
              ));
        }
        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: Center(
            child: BlocConsumer<SplashBloc, SplashState>(
              listener: (context, state) {
                if (state.status == LoadStatus.loadingAuth) {
                  // 자동 로그인 - jwt 유효성 검사
                  debugPrint('자동 로그인 - jwt 유효성 검사');
                  autoSignin(context);
                }
                if (state.status == LoadStatus.loadingUserData) {
                  // 기본 사용자 정보 로드
                  debugPrint('기본 사용자 정보 로드');
                  getUserData(context);
                }
                if (state.status == LoadStatus.loadingUserProfileData) {
                  // 사용자 프로필 정보 로드
                  debugPrint('사용자 프로필 정보 로드');
                  getUserProfileData(context);
                }
              },
              buildWhen: (previous, current) =>
                  previous.status != current.status,
              builder: (context, state) {
                if (state.status == LoadStatus.init) {
                  context
                      .read<SplashBloc>()
                      .add(const SplashChangeLoadStateEvent(
                        status: LoadStatus.loadingAuth,
                      ));
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.scale(
                      scale: 1.5,
                      child: Image.asset(
                        'assets/images/honbab_splash.png',
                        width: Sizes.size72 * 2,
                        height: Sizes.size72 * 2,
                      ),
                    ),
                    Text(
                      "${state.status.message} 중입니다.",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    Gaps.v24,
                    const CircularProgressIndicator(
                      strokeWidth: Sizes.size1,
                      color: Colors.white,
                    )
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
