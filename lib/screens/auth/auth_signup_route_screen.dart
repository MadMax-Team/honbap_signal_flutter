import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/auth_screen/auth_screen_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/auth_screen/auth_screen_state.dart';
import 'package:honbap_signal_flutter/screens/auth/signup_routes/signup_phone_check_screen.dart';
import 'package:honbap_signal_flutter/screens/auth/signup_routes/signup_phone_complete_screen.dart';
import 'package:honbap_signal_flutter/screens/auth/signup_routes/signup_userinfo_screen.dart';

class AuthSignupRouteScreen extends StatefulWidget {
  const AuthSignupRouteScreen({super.key});

  @override
  State<AuthSignupRouteScreen> createState() => _AuthSignupRouteScreenState();
}

class _AuthSignupRouteScreenState extends State<AuthSignupRouteScreen> {
  Widget _screenRouter(AuthScreenEnum screen) {
    switch (screen) {
      case AuthScreenEnum.phoneCheck:
        return const SignupPhoneCheckScreen();
      case AuthScreenEnum.phoneComplete:
        return const SignupPhoneCompleteScreen();
      case AuthScreenEnum.userInfo:
        return const SignupUserInfoScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthScreenBloc, AuthScreenState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text('회원가입'),
        ),
        body: _screenRouter(state.screen),
      ),
    );
  }
}
