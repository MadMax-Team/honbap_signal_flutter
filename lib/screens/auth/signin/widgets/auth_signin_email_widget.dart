import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signin/post_user_signin_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signin/post_user_signin_event.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signin/post_user_signin_state.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';

class AuthSigninEmailWidget extends StatefulWidget {
  const AuthSigninEmailWidget({super.key});

  @override
  State<AuthSigninEmailWidget> createState() => _SignupUserInfoEmailState();
}

class _SignupUserInfoEmailState extends State<AuthSigninEmailWidget> {
  String _email = '';
  final _fieldKey = GlobalKey<FormFieldState<String>>();
  final _emailFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocus.addListener(_checkEmailValidate);
  }

  @override
  void dispose() {
    _emailFocus.dispose();
    super.dispose();
  }

  String? _emailValidator(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);

    // Invaled
    if (value != null && !regExp.hasMatch(value)) {
      return '잘못된 이메일 형식입니다';
    }

    // Valid
    context
        .read<SigninUserBloc>()
        .add(SigninEmailChangeEvent(email: value ?? ''));
    return null;
  }

  void _checkEmailValidate() {
    if (_email == '') return;

    if (_fieldKey.currentState != null) {
      _fieldKey.currentState!.validate();
    }
  }

  void _onChanged(String value) {
    _email = value;

    context.read<SigninUserBloc>().add(const SigninEmailChangeEvent(email: ''));
  }

  void _onFieldSubmitted(String value) {
    if (_emailValidator(value) != null) return;

    FocusScope.of(context).nextFocus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninUserBloc, SigninUserState>(
      listener: (context, state) {
        if (state is SigninUserErrorState && state.code == 1001) {
          _emailFocus.requestFocus();
        }
      },
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email',
            style: Theme.of(context).textTheme.labelSmall,
          ),
          SizedBox(
            height: Sizes.size80,
            child: TextFormField(
              key: _fieldKey,
              focusNode: _emailFocus,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              enableSuggestions: false,
              textInputAction: TextInputAction.next,
              style: const TextStyle(fontSize: Sizes.size16),
              decoration: InputDecoration(
                hintText: 'username@example.com',
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
              validator: (value) => _emailValidator(value),
              onEditingComplete: _checkEmailValidate,
              onTapOutside: (_) => _checkEmailValidate(),
              onFieldSubmitted: _onFieldSubmitted,
            ),
          ),
        ],
      ),
    );
  }
}
