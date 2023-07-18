import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signin/post_user_signin_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signin/post_user_signin_event.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signin/post_user_signin_state.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';

class AuthSigninPasswordWidget extends StatefulWidget {
  const AuthSigninPasswordWidget({super.key});

  @override
  State<AuthSigninPasswordWidget> createState() =>
      _SignupUserInfoPasswordState();
}

class _SignupUserInfoPasswordState extends State<AuthSigninPasswordWidget> {
  String _password = '';
  bool _obscureText = true;
  final _passwordKey = GlobalKey<FormFieldState<String>>();
  final _passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _passwordFocus.addListener(_checkPasswordValidate);
  }

  @override
  void dispose() {
    _passwordFocus.dispose();
    super.dispose();
  }

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
        .read<SigninUserBloc>()
        .add(SigninPasswordChangeEvent(password: value ?? ''));
    return null;
  }

  void _checkPasswordValidate() {
    if (_password == '') return;

    if (_passwordKey.currentState != null) {
      _passwordKey.currentState!.validate();
    }
  }

  void _onChanged(String value) {
    _password = value;

    context
        .read<SigninUserBloc>()
        .add(const SigninPasswordChangeEvent(password: ''));
  }

  void _onFieldSubmitted(String value) {
    if (_passwordValidator(value) != null) return;

    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninUserBloc, SigninUserState>(
      listener: (context, state) {
        if (state is SigninUserErrorState && state.code == 1002) {
          _passwordFocus.requestFocus();
        }
      },
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Password',
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
              onChanged: _onChanged,
              validator: (value) => _passwordValidator(value),
              onEditingComplete: _checkPasswordValidate,
              onTapOutside: (_) => _checkPasswordValidate(),
              onFieldSubmitted: _onFieldSubmitted,
            ),
          ),
        ],
      ),
    );
  }
}
