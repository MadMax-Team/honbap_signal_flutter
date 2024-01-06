import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/cubit/user_cubit.dart';
import 'package:honbap_signal_flutter/screens/mypage/user_account_setting/widgets/user_account_setting_button.dart';
import 'package:honbap_signal_flutter/screens/mypage/user_account_setting/widgets/user_account_setting_section.dart';
import 'package:honbap_signal_flutter/screens/mypage/user_account_setting/widgets/user_logout_dialog.dart';
import 'package:honbap_signal_flutter/tools/push_new_screen.dart';

class UserAccountSettingScreen extends StatelessWidget {
  const UserAccountSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '계정설정',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        elevation: 0,
        centerTitle: false,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          UserAccountSettingSection(
            title: '계정관리',
            text: '서비스에서 사용하는 내 계정 정보를 관리할 수 있습니다.',
            children: [
              UserAccountSettingButton(
                title: '이메일',
                value: context.read<UserCubit>().state.user?.email ?? '',
              ),
              UserAccountSettingButton(
                title: '이름',
                value: context.read<UserCubit>().state.user?.userName ?? '',
              ),
              // UserAccountSettingButton(
              //   title: '휴대폰 번호',
              //   value: context
              //           .read<UserCubit>()
              //           .state
              //           .user
              //           ?.phoneNum
              //           ?.replaceAllMapped(RegExp(r'(\d{3})(\d{3,4})(\d{4})'),
              //               (m) => '${m[1]}-${m[2]}-${m[3]}') ??
              //       '',
              // ),
              UserAccountSettingButton(
                title: '로그아웃',
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return const UserLogoutDialog();
                    },
                  );
                },
              ),
            ],
          ),
          Gaps.v40,
          UserAccountSettingSection(
            title: '개인 정보 보호',
            text: '내 계정을 안전하게 보호하기 위한 정보를 관리할 수 있습니다.',
            children: [
              UserAccountSettingButton(
                title: '비밀번호 변경',
                onTap: () =>
                    PushNewScreen.openUserPasswordChange(context: context),
              ),
              UserAccountSettingButton(
                title: '회원탈퇴',
                onTap: () {},
                enabled: false,
              ),
            ],
          ),
          Gaps.v32,
        ],
      ),
    );
  }
}
