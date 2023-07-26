import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signup/post_user_signup_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signup/post_user_signup_event.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signup/post_user_signup_state.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/screens/auth/signup_routes/widgets/signup_double_check_button_widget.dart';

class SignupUserInfoUserName extends StatefulWidget {
  const SignupUserInfoUserName({super.key});

  @override
  State<SignupUserInfoUserName> createState() => _SignupUserInfoUserNameState();
}

class _SignupUserInfoUserNameState extends State<SignupUserInfoUserName> {
  String _nickname = '';
  bool _nicknameChecked = false;
  bool _isChecking = false;
  final _fieldKey = GlobalKey<FormFieldState<String>>();
  final _userNameFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _userNameFocus.addListener(_checkNicknameValidate);
  }

  @override
  void dispose() {
    _userNameFocus.dispose();
    super.dispose();
  }

  String? _nicknameValidator(String? value) {
    // Invaled
    if (value != null && value.isEmpty) {
      return '사용할 수 없는 닉네임입니다';
    }

    // Check if nickname is available
    if (!_nicknameChecked) return "중복확인 해주세요";

    // Valid
    context
        .read<SignupUserBloc>()
        .add(SignupUserNameChangedEvent(userName: value ?? ''));
    return null;
  }

  void _nicknameCheck() async {
    FocusScope.of(context).unfocus();
    if (_nicknameChecked || _nickname == '') return;

    // TODO: 닉네임 중복확인 로직 추가
    if (_isChecking) return;
    setState(() {
      _isChecking = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _isChecking = false;
    });

    // Valid
    setState(() {
      _nicknameChecked = true;
    });
    _checkNicknameValidate();
  }

  void _checkNicknameValidate() {
    if (_nickname == '') return;

    if (_fieldKey.currentState != null) {
      _fieldKey.currentState!.validate();
    }
  }

  void _onChanged(String value) {
    _nickname = value;

    context
        .read<SignupUserBloc>()
        .add(const SignupUserNameChangedEvent(userName: ''));
    setState(() {
      _nicknameChecked = false;
    });
  }

  void _onFieldSubmitted(String value) {
    if (_nicknameValidator(value) != null) return;

    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupUserBloc, SignupUserInfoState>(
      listener: (context, state) {
        if (state is SignupUserInfoErrorState && state.code == 1003) {
          _userNameFocus.requestFocus();
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
            '닉네임은 3개월마다 변경이 가능합니다!',
            style: Theme.of(context).textTheme.labelSmall,
          ),
          SizedBox(
            height: Sizes.size80,
            child: TextFormField(
              key: _fieldKey,
              focusNode: _userNameFocus,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              enableSuggestions: false,
              style: const TextStyle(fontSize: Sizes.size16),
              decoration: InputDecoration(
                suffix: GestureDetector(
                  onTap: _nicknameCheck,
                  child: SignupDoubleCheckButton(
                    isAvailable: _nicknameChecked,
                    isLoading: _isChecking,
                  ),
                ),
                hintText: '닉네임을 입력해주세요',
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
              validator: (value) => _nicknameValidator(value),
              onEditingComplete: _checkNicknameValidate,
              onTapOutside: (_) => _checkNicknameValidate(),
              onFieldSubmitted: _onFieldSubmitted,
            ),
          ),
        ],
      ),
    );
  }
}
