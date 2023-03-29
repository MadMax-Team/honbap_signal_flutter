import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signup/post_user_signup_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signup/post_user_signup_event.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signup/post_user_signup_state.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';

class SignupUserInfoPassword extends StatefulWidget {
  const SignupUserInfoPassword({super.key});

  @override
  State<SignupUserInfoPassword> createState() => _SignupUserInfoPasswordState();
}

class _SignupUserInfoPasswordState extends State<SignupUserInfoPassword> {
  String _password = '';
  bool _obscureText = true;
  final _passwordKey = GlobalKey<FormState>();
  final _passwordCheckKey = GlobalKey<FormState>();
  final _passwordFocus = FocusNode();
  final _passwordCheckFocus = FocusNode();

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  String? _passwordValidator(String? value) {
    String pattern =
        r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,16}$';
    RegExp regExp = RegExp(pattern);

    // Invaled
    if (value != null && !regExp.hasMatch(value)) {
      return '8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.';
    }

    // Valid
    context
        .read<SignupUserBloc>()
        .add(SignupPasswordChangedEvent(password: value ?? ''));
    return null;
  }

  void _checkPasswordValidate() {
    if (_password == '') return;

    if (_passwordKey.currentState != null) {
      _passwordKey.currentState!.validate();
    }
  }

  void _onPasswordChanged(String value) {
    _password = value;

    context
        .read<SignupUserBloc>()
        .add(const SignupPasswordChangedEvent(password: ''));
  }

  String? _passwordCheckValidator(String? value) {
    var currPassword =
        (context.read<SignupUserBloc>().state as SignupUserInfoNormalState)
            .formData
            .password;

    // Invaled
    if (value != currPassword) {
      return '비밀번호가 일치하지 않습니다.';
    }

    // Valid
    return null;
  }

  void _checkPasswordCheckValidate() {
    if (_password == '') return;

    if (_passwordCheckKey.currentState != null) {
      _passwordCheckKey.currentState!.validate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupUserBloc, SignupUserInfoState>(
      builder: (context, state) => Column(
        children: [
          Form(
            key: _passwordKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '비밀번호를 설정해 주세요',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                TextFormField(
                  focusNode: _passwordFocus,
                  obscureText: _obscureText,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(fontSize: Sizes.size16),
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: _toggleObscureText,
                      child: Container(
                        width: Sizes.size28,
                        alignment: Alignment.center,
                        child: FaIcon(
                          _obscureText
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          color: Colors.grey.shade300,
                          size: Sizes.size20,
                        ),
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  cursorColor: Theme.of(context).primaryColor,
                  onChanged: _onPasswordChanged,
                  validator: (value) => _passwordValidator(value),
                  onEditingComplete: _checkPasswordValidate,
                  onTapOutside: (_) => _checkPasswordValidate(),
                ),
                Gaps.v60,
              ],
            ),
          ),
          Form(
            key: _passwordCheckKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '비밀번호를 확인해 주세요',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                TextFormField(
                  focusNode: _passwordCheckFocus,
                  obscureText: _obscureText,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(fontSize: Sizes.size16),
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: _toggleObscureText,
                      child: Container(
                        width: Sizes.size28,
                        alignment: Alignment.center,
                        child: FaIcon(
                          _obscureText
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          color: Colors.grey.shade300,
                          size: Sizes.size20,
                        ),
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  cursorColor: Theme.of(context).primaryColor,
                  onChanged: (_) => _checkPasswordCheckValidate(),
                  validator: (value) => _passwordCheckValidator(value),
                  onEditingComplete: _checkPasswordCheckValidate,
                  onTapOutside: (_) => _checkPasswordCheckValidate(),
                ),
                Gaps.v60,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
