import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_event.dart';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_state.dart';
import 'package:honbap_signal_flutter/bloc/splash/splash_bloc.dart';
import 'package:honbap_signal_flutter/bloc/splash/splash_state.dart';
import 'package:honbap_signal_flutter/repository/honbab/auth/auth_repository.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> autoSignin() async {
      const storage = FlutterSecureStorage();
      String? jwt = await storage.read(key: 'jwt');

      print(jwt);

      if (jwt?.isNotEmpty == true) {
        var res =
            await context.read<HonbabAuthRepository>().autoSignin(jwt: jwt!);
        if (res) {
          // 로그인 성공
          context.read<AuthenticationBloc>().add(const AuthenticaionSetState(
              status: AuthenticationStatus.authenticated));
          return;
        }
      }
      // 로그인 실패
      context.read<AuthenticationBloc>().add(const AuthenticaionSetState(
            status: AuthenticationStatus.unauthenticated,
          ));
    }

    return Scaffold(
      body: Center(
        child: BlocBuilder<SplashBloc, SplashState>(
          builder: (context, state) {
            var authState = context.read<AuthenticationBloc>().state.status;
            if (state.status == LoadStatus.loadingAuth &&
                authState == AuthenticationStatus.init) {
              autoSignin();
            }
            return Text("${state.status.message} 중입니다.");
          },
        ),
      ),
    );
  }
}
