import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signup/post_user_signup_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signup/post_user_signup_state.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/screens/auth/signup_routes/signup_userinfo_widgets/signup_userinfo_email_widget.dart';
import 'package:honbap_signal_flutter/screens/auth/signup_routes/signup_userinfo_widgets/signup_userinfo_password_widget.dart';
import 'package:honbap_signal_flutter/screens/auth/signup_routes/widgets/auth_button_widget.dart';

class SignupUserInfoScreen extends StatefulWidget {
  const SignupUserInfoScreen({super.key});

  @override
  State<SignupUserInfoScreen> createState() => _SignupUserInfoScreenState();
}

class _SignupUserInfoScreenState extends State<SignupUserInfoScreen> {
  @override
  void initState() {
    super.initState();
  }

  void _onNextBtnTap() {
    SignupUserInfoNormalState state =
        context.read<SignupUserBloc>().state as SignupUserInfoNormalState;

    print(state.formData.toString());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v20,
                Text(
                  '계정 정보를 입력해 주세요',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Gaps.v36,
                const SignupUserInfoEmail(),
                const SignupUserInfoPassword(),
              ],
            ),
          ),
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
      ),
    );
  }
}
