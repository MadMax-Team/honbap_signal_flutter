import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/cubit/user_pw_change_cubit.dart';
import 'package:honbap_signal_flutter/screens/mypage/user_account_setting/user_password_change/widgets/user_password_submit_button.dart';
import 'package:honbap_signal_flutter/screens/mypage/user_account_setting/user_password_change/widgets/user_password_textform.dart';

class UserPasswordChangeScreen extends StatefulWidget {
  const UserPasswordChangeScreen({super.key});

  @override
  State<UserPasswordChangeScreen> createState() =>
      _UserPasswordChangeScreenState();
}

class _UserPasswordChangeScreenState extends State<UserPasswordChangeScreen> {
  final FocusNode _oldPwFocusNode = FocusNode();
  final FocusNode _newPw1FocusNode = FocusNode();
  final FocusNode _newPw2FocusNode = FocusNode();
  String? _newPassword = '';

  String? _newPw1validator(String? value) {
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

  String? _newPw2validator(String? value) {
    if (_newPw1validator(value) != null) {
      return '8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.';
    }
    // Invaled
    if (_newPassword != value) {
      return '비밀번호가 일치하지 않습니다.';
    }

    // Valid
    return null;
  }

  void _onOldPwSubmit(String value) {
    context.read<UserPWChangeCubit>().changeOldPW(value);
  }

  void _onNewPw1Submit(String value) {
    _newPassword = value;
  }

  void _onNewPw2Submit(String value) {
    context.read<UserPWChangeCubit>().changeNewPW(value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '비밀번호 변경',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          elevation: 0,
          centerTitle: false,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
        ),
        body: BlocListener<UserPWChangeCubit, UserPWChangeState>(
          listener: (context, state) {
            if (state.status == UserPWChangeStatus.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('비밀번호를 변경했습니다!'),
                  elevation: 0,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              );
            }

            if (state.status == UserPWChangeStatus.failed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('비밀번호 변경에 실패했습니다'),
                  elevation: 0,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
            child: ListView(
              children: [
                Gaps.v20,
                Text(
                  '현재 비밀번호',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                UserPasswordTextForm(
                  hint: '비밀번호를 입력해주세요.',
                  focusNode: _oldPwFocusNode,
                  onChange: (_) {},
                  validator: (_) => null,
                  onSubmit: _onOldPwSubmit,
                ),
                Gaps.v20,
                Text(
                  '새 비밀번호',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                UserPasswordTextForm(
                  hint: '새 비밀번호를 입력해주세요.',
                  focusNode: _newPw1FocusNode,
                  onChange: _onNewPw1Submit,
                  validator: _newPw1validator,
                  checkValidOnChange: true,
                  onSubmit: _onNewPw1Submit,
                ),
                UserPasswordTextForm(
                  isLast: true,
                  hint: '새 비밀번호를 확인해주세요.',
                  focusNode: _newPw2FocusNode,
                  onChange: (_) {},
                  validator: _newPw2validator,
                  checkValidOnChange: true,
                  onSubmit: _onNewPw2Submit,
                ),
                Text(
                  '영문 대소문자, 숫자, 특수문자를 3가지 이상으로 조합하여 8자 이상 16자 이하로 입력해주세요.',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: Sizes.size12,
                  ),
                ),
                Gaps.v20,
                const UserPasswordSubmitButton(),
                Gaps.v32,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
