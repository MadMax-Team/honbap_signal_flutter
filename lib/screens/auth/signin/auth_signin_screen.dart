import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_event.dart';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_state.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signin/post_user_signin_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signin/post_user_signin_event.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signin/post_user_signin_state.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/screens/auth/signin/widgets/auth_signin_email_widget.dart';
import 'package:honbap_signal_flutter/screens/auth/signin/widgets/auth_signin_password_widget.dart';
import 'package:honbap_signal_flutter/screens/auth/widgets/auth_button_widget.dart';

class AuthSigninScreen extends StatefulWidget {
  const AuthSigninScreen({super.key});

  @override
  State<AuthSigninScreen> createState() => _AuthSigninScreenState();
}

class _AuthSigninScreenState extends State<AuthSigninScreen> {
  final _formKey = GlobalKey<FormState>();

  void _onNextBtnTap() {
    if (context.read<SigninUserBloc>().state is SinginUserLoadingState) {
      return;
    }

    context.read<SigninUserBloc>().add(const SigninButtonTapEvent());
  }

  void _onLoginSuccess({required String jwt}) async {
    // jwt 저장
    const storage = FlutterSecureStorage();
    storage.write(key: 'jwt', value: jwt);

    // splash 화면으로 돌아가기
    context.read<AuthenticationBloc>().add(const AuthenticaionSetState(
          status: AuthenticationStatus.init,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(
            color: Colors.black, // <-- SEE HERE
          ),
        ),
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
                  const AuthSigninEmailWidget(),
                  const AuthSigninPasswordWidget(),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BlocConsumer<SigninUserBloc, SigninUserState>(
          listener: (context, state) {
            if (state is SigninUserErrorState && state.code == 1003) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message ?? '로그인에 실패했습니다.'),
                  elevation: 0,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              );
            }
            if (state is SigninUserSuccessState) {
              _onLoginSuccess(jwt: state.jwt!);
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
                isLoading: state is SinginUserLoadingState,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
