import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signup/post_user_signup_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signup/post_user_signup_event.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signup/post_user_signup_state.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';

class SignupUserInfoEmail extends StatefulWidget {
  const SignupUserInfoEmail({super.key});

  @override
  State<SignupUserInfoEmail> createState() => _SignupUserInfoEmailState();
}

class _SignupUserInfoEmailState extends State<SignupUserInfoEmail> {
  String _email = '';
  bool _emailChecked = false;
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
      setState(() {
        _emailChecked = false;
      });
      return '잘못된 이메일 형식입니다';
    }

    // Valid
    context
        .read<SignupUserBloc>()
        .add(SignupEmailChangedEvent(email: value ?? ''));
    setState(() {
      _emailChecked = true;
    });
    return null;
  }

  void _checkEmailValidate() {
    if (_email == '') return;

    if (!_emailChecked && _fieldKey.currentState != null) {
      _fieldKey.currentState!.validate();
    }
  }

  void _onChanged(String value) {
    _email = value;

    context
        .read<SignupUserBloc>()
        .add(const SignupEmailChangedEvent(email: ''));
    setState(() {
      _emailChecked = false;
    });
  }

  void _onFieldSubmitted(String value) {
    if (_emailValidator(value) != null) return;

    FocusScope.of(context).nextFocus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupUserBloc, SignupUserInfoState>(
      listener: (context, state) {
        if (state is SignupUserInfoErrorState && state.code == 1001) {
          _emailFocus.requestFocus();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
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
            '사용하실 이메일 아이디를 입력해 주세요',
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
                suffixIcon: Icon(
                  Icons.check_circle_rounded,
                  color: _emailChecked
                      ? Theme.of(context).primaryColor
                      : Colors.grey.shade300,
                ),
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
