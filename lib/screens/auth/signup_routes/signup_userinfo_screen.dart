import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_event.dart';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_state.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signup/post_user_signup_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signup/post_user_signup_event.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signup/post_user_signup_state.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/screens/auth/signup_routes/signup_userinfo_widgets/signup_userinfo_birth_widget.dart';
import 'package:honbap_signal_flutter/screens/auth/signup_routes/signup_userinfo_widgets/signup_userinfo_email_widget.dart';
import 'package:honbap_signal_flutter/screens/auth/signup_routes/signup_userinfo_widgets/signup_userinfo_nickname_widget.dart';
import 'package:honbap_signal_flutter/screens/auth/signup_routes/signup_userinfo_widgets/signup_userinfo_password_widget.dart';
import 'package:honbap_signal_flutter/screens/auth/signup_routes/signup_userinfo_widgets/signup_userinfo_sex_widget.dart';
import 'package:honbap_signal_flutter/screens/auth/signup_routes/widgets/auth_button_widget.dart';

class SignupUserInfoScreen extends StatefulWidget {
  const SignupUserInfoScreen({super.key});

  @override
  State<SignupUserInfoScreen> createState() => _SignupUserInfoScreenState();
}

class _SignupUserInfoScreenState extends State<SignupUserInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  void _onNextBtnTap() {
    if (context.read<SignupUserBloc>().state is! SignupUserInfoNormalState) {
      return;
    }

    var state =
        context.read<SignupUserBloc>().state as SignupUserInfoNormalState;

    context
        .read<SignupUserBloc>()
        .add(SignupButtonTabEvent(formData: state.formData));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
            child: Form(
              key: _formKey,
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
                  Gaps.v20,
                  Text(
                    '사용하실 닉네임을 설정해 주세요',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Gaps.v10,
                  const SignupUserInfoNickName(),
                  Gaps.v20,
                  Text(
                    '생년월일과 성별을\n선택해 주세요',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Gaps.v20,
                  const Row(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: SignupUserInfoBirth(),
                      ),
                      Gaps.h20,
                      Flexible(
                        fit: FlexFit.tight,
                        child: SignupUserInfoSex(),
                      ),
                    ],
                  ),
                  Gaps.v96,
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BlocConsumer<SignupUserBloc, SignupUserInfoState>(
          listener: (context, state) {
            if (state is SignupUserInfoErrorState &&
                (state.code == 4000 || state.code == 4001)) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('통신에 실패했습니다.\n잠시 후 다시 시도해 주세요.'),
                  elevation: 0,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              );
            }
            if (state is SignupUserInfoLoadedState &&
                !state.resCode.isSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('회원가입에 실패했습니다.\n${state.resCode.message}'),
                  elevation: 0,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              );
            }

            if (state is SignupUserInfoLoadedState &&
                state.resCode.code == 1000) {
              context.read<AuthenticationBloc>().add(AuthenticationLogin(
                    platform: AuthenticationWith.honbab,
                    email: state.formData.email,
                    password: state.formData.password,
                  ));
            }
          },
          builder: (context, state) => BottomAppBar(
            color: Theme.of(context).primaryColor,
            child: GestureDetector(
              onTap: _onNextBtnTap,
              child: AuthBtnWidget(
                title: "계속하기",
                bgColor: Theme.of(context).primaryColor,
                borderColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
                borderRad: 0,
                isLoading: state is SignupUserInfoLoadingState,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
