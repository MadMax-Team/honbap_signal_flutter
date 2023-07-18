import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/auth_screen/auth_screen_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/auth_screen/auth_screen_event.dart';
import 'package:honbap_signal_flutter/bloc/auth/auth_screen/auth_screen_state.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_app_send_veri/post_app_send_veri_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_app_send_veri/post_app_send_veri_event.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_app_send_veri/post_app_send_veri_state.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signup/post_user_signup_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signup/post_user_signup_event.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/screens/auth/signup_routes/widgets/auth_button_widget.dart';
import 'package:honbap_signal_flutter/tools/phone_format_updater.dart';

class SignupPhoneCheckScreen extends StatefulWidget {
  const SignupPhoneCheckScreen({super.key});

  @override
  State<SignupPhoneCheckScreen> createState() => _SignupPhoneCheckScreenState();
}

class _SignupPhoneCheckScreenState extends State<SignupPhoneCheckScreen> {
  String _phoneNum = "", _authNum = "";

  final _phoneNumFormKey = GlobalKey<FormState>();
  final _authNumFormKey = GlobalKey<FormState>();

  final _phoneNumFocusNode = FocusNode();
  final _authNumNode = FocusNode();

  String? _phoneNumValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "핸드폰 번호를 입력해주세요";
    }
    _phoneNum = value;
    return null;
  }

  String? _verifyCodeValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "인증번호를 입력해주세요";
    }
    _authNum = value;
    return null;
  }

  void _submitHandler(SignupPhoneState state) {
    // 이미 처리중이면 실행 금지
    if (state is SignupPhoneSendLoadingState ||
        state is SignupPhoneVerifyLoadingState) return;

    // 올바르지 못한 핸드폰 번호인 경우
    if (!(_phoneNumFormKey.currentState?.validate() ?? false)) {
      _phoneNumFocusNode.requestFocus();
      return;
    }

    // 아래의 상태일 경우에만 verify code send 이벤트 발생
    if (state is SignupPhoneInitState || state is SignupPhoneSendErrorState) {
      context
          .read<SignupPhoneBloc>()
          .add(SignupPhoneSendTabEvent(phoneNumber: _phoneNum));
      return;
    }

    // 올바르지 못한 인증 번호인 경우
    if (!(_authNumFormKey.currentState?.validate() ?? false)) {
      _authNumNode.requestFocus();
      return;
    }

    // 아래의 상태일 경우에만 verify 이벤트 발생
    if (state is SignupPhoneSendedState ||
        state is SignupPhoneVerifyErrorState) {
      context.read<SignupPhoneBloc>().add(SignupPhoneVerifyTabEvent(
            phoneNumber: _phoneNum,
            verifyCode: _authNum,
          ));
      return;
    }
  }

  void _toNextPage() {
    // 핸드폰 번호 업데이트
    context
        .read<SignupUserBloc>()
        .add(SignupPhoneNumChangedEvent(phoneNum: _phoneNum));

    // 다음 화면으로 이동
    context
        .read<AuthScreenBloc>()
        .add(const AuthScreenEvent(screen: AuthScreenEnum.phoneComplete));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
          child: Column(
            children: [
              Gaps.v20,
              BlocBuilder<SignupPhoneBloc, SignupPhoneState>(
                builder: (context, state) => Form(
                  key: _phoneNumFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '핸드폰 번호를 입력해주세요',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        '입력해 주시는 번호로 인증 번호가 발송됩니다',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Gaps.v20,
                      TextFormField(
                        enabled: (state is SignupPhoneInitState ||
                            state is SignupPhoneSendErrorState),
                        focusNode: _phoneNumFocusNode,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: '000-0000-0000',
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          PhoneFormatUpdater(),
                        ],
                        // enabled: !isPhoneSubmit,
                        onTap: _phoneNumFocusNode.requestFocus,
                        validator: _phoneNumValidator,
                        onFieldSubmitted: (value) => _submitHandler(state),
                      ),
                      Gaps.v60,
                    ],
                  ),
                ),
              ),
              BlocBuilder<SignupPhoneBloc, SignupPhoneState>(
                builder: (context, state) {
                  if (state is SignupPhoneSendedState ||
                      state is SignupPhoneVerifyLoadingState ||
                      state is SignupPhoneVerifyErrorState ||
                      state is SignupPhoneVerifiedState) {
                    return Form(
                      key: _authNumFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '문자 메세지로 도착한',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            '인증번호를 입력해 주세요',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Gaps.v10,
                          TextFormField(
                            enabled: (state is SignupPhoneSendedState ||
                                state is SignupPhoneVerifyErrorState),
                            focusNode: _authNumNode,
                            keyboardType: TextInputType.number,
                            onTap: _authNumNode.requestFocus,
                            validator: _verifyCodeValidator,
                            onFieldSubmitted: (value) => _submitHandler(state),
                          ),
                        ],
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).primaryColor,
          child: BlocConsumer<SignupPhoneBloc, SignupPhoneState>(
            listener: (context, state) {
              if (state is SignupPhoneVerifiedState) _toNextPage();
              if (state is SignupPhoneSendedState) _authNumNode.requestFocus();
              if (state is SignupPhoneSendErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    elevation: 0,
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                );
              }
              if (state is SignupPhoneVerifyErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    elevation: 0,
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                );
              }
            },
            builder: (context, state) => GestureDetector(
              onTap: () => _submitHandler(state),
              child: AuthBtnWidget(
                title: "계속하기",
                bgColor: Theme.of(context).primaryColor,
                borderColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
                borderRad: 0,
                isLoading: state is SignupPhoneSendLoadingState ||
                    state is SignupPhoneVerifyLoadingState,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
