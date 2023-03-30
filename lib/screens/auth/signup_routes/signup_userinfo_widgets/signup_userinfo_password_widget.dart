import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signup/post_user_signup_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signup/post_user_signup_event.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signup/post_user_signup_state.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';

class SignupUserInfoPassword extends StatefulWidget {
  const SignupUserInfoPassword({super.key});

  @override
  State<SignupUserInfoPassword> createState() => _SignupUserInfoPasswordState();
}

class _SignupUserInfoPasswordState extends State<SignupUserInfoPassword> {
  String _password = '';
  bool _obscureText = true;
  final _passwordKey = GlobalKey<FormFieldState<String>>();
  final _passwordCheckKey = GlobalKey<FormFieldState<String>>();
  final _passwordFocus = FocusNode();
  final _passwordCheckFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _passwordFocus.addListener(_checkPasswordValidate);
    _passwordCheckFocus.addListener(_checkPasswordCheckValidate);
  }

  @override
  void dispose() {
    _passwordFocus.dispose();
    _passwordCheckFocus.dispose();
    super.dispose();
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  /// Password ///
  String? _passwordValidator(String? value) {
    String pattern =
        r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,16}$';
    RegExp regExp = RegExp(pattern);

    // Invaled
    if (value != null && !regExp.hasMatch(value)) {
      return '8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.';
    }

    // Valid
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

  void _onPasswordFieldSubmitted(String value) {
    if (_passwordValidator(value) != null) return;

    FocusScope.of(context).nextFocus();
  }

  /// Password Check ///
  String? _passwordCheckValidator(String? value) {
    // Invaled
    if (value != _password) {
      return '비밀번호가 일치하지 않습니다.';
    }

    // Valid
    context
        .read<SignupUserBloc>()
        .add(SignupPasswordChangedEvent(password: value ?? ''));
    return null;
  }

  void _checkPasswordCheckValidate() {
    if (_password == '') return;

    if (_passwordCheckKey.currentState != null) {
      _passwordCheckKey.currentState!.validate();
    }
  }

  void _onPasswordCheckChanged(String value) {
    context
        .read<SignupUserBloc>()
        .add(const SignupPasswordChangedEvent(password: ''));

    _checkPasswordCheckValidate();
  }

  void _onPasswordCheckFieldSubmitted(String value) {
    if (_passwordCheckValidator(value) != null) return;

    FocusScope.of(context).nextFocus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupUserBloc, SignupUserInfoState>(
      listener: (context, state) {
        if (state is SignupUserInfoErrorState && state.code == 1002) {
          String message = '';
          if (_passwordValidator(_password) == null) {
            _passwordCheckFocus.requestFocus();
            message = '비밀번호를 확인해주세요.';
          } else {
            _passwordFocus.requestFocus();
            message = state.message;
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              elevation: 0,
              backgroundColor: Theme.of(context).primaryColor,
            ),
          );
        }
      },
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '비밀번호를 설정해 주세요',
            style: Theme.of(context).textTheme.labelSmall,
          ),
          SizedBox(
            height: Sizes.size80,
            child: TextFormField(
              key: _passwordKey,
              focusNode: _passwordFocus,
              autocorrect: false,
              enableSuggestions: false,
              obscureText: _obscureText,
              textInputAction: TextInputAction.next,
              style: const TextStyle(fontSize: Sizes.size16),
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: _toggleObscureText,
                  child: Container(
                    width: Sizes.size28,
                    height: Sizes.size28,
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
              onFieldSubmitted: _onPasswordFieldSubmitted,
            ),
          ),
          Text(
            '비밀번호를 확인해 주세요',
            style: Theme.of(context).textTheme.labelSmall,
          ),
          SizedBox(
            height: Sizes.size80,
            child: TextFormField(
              key: _passwordCheckKey,
              focusNode: _passwordCheckFocus,
              autocorrect: false,
              enableSuggestions: false,
              obscureText: _obscureText,
              textInputAction: TextInputAction.next,
              style: const TextStyle(fontSize: Sizes.size16),
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: _toggleObscureText,
                  child: Container(
                    width: Sizes.size28,
                    height: Sizes.size28,
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
              onChanged: _onPasswordCheckChanged,
              validator: (value) => _passwordCheckValidator(value),
              onEditingComplete: _checkPasswordCheckValidate,
              onTapOutside: (_) => _checkPasswordCheckValidate(),
              onFieldSubmitted: _onPasswordCheckFieldSubmitted,
            ),
          ),
        ],
      ),
    );
  }
}
