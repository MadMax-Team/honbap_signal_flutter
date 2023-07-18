import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_event.dart';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_state.dart';
import 'package:honbap_signal_flutter/bloc/splash/splash_bloc.dart';
import 'package:honbap_signal_flutter/bloc/splash/splash_state.dart';
import 'package:honbap_signal_flutter/cubit/jwt_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<SplashBloc, SplashState>(
          builder: (context, state) {
            if (state.status == LoadStatus.loadingAuth) {
              var jwt = context.read<JWTCubit>().state;
              if (jwt?.isNotEmpty == true) {
                // 자동 로그인 시도
              } else {
                // 로그인 화면으로 이동
                context
                    .read<AuthenticationBloc>()
                    .add(const AuthenticaionSetState(
                      status: AuthenticationStatus.unauthenticated,
                    ));
              }
            }
            return Text("${state.status.message} 중입니다.");
          },
        ),
      ),
    );
  }
}
