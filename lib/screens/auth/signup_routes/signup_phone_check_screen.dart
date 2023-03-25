import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/auth_screen/auth_screen_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/auth_screen/auth_screen_event.dart';
import 'package:honbap_signal_flutter/bloc/auth/auth_screen/auth_screen_state.dart';
import 'package:honbap_signal_flutter/screens/auth/signup_routes/widgets/auth_button_widget.dart';

class SignupPhoneCheckScreen extends StatefulWidget {
  const SignupPhoneCheckScreen({super.key});

  @override
  State<SignupPhoneCheckScreen> createState() => _SignupPhoneCheckScreenState();
}

class _SignupPhoneCheckScreenState extends State<SignupPhoneCheckScreen> {
  void _onNextBtnTap() {
    context
        .read<AuthScreenBloc>()
        .add(const AuthScreenEvent(screen: AuthScreenEnum.phoneComplete));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('phoneCheckScreen'),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        child: GestureDetector(
          onTap: _onNextBtnTap,
          child: AuthBtnWidget(
            title: "계속하기",
            bgColor: Theme.of(context).primaryColor,
            borderColor: Theme.of(context).primaryColor,
            textColor: Colors.white,
            borderRad: 0,
          ),
        ),
      ),
    );
  }
}
