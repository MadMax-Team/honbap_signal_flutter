import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/auth_screen/auth_screen_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/auth_screen/auth_screen_event.dart';
import 'package:honbap_signal_flutter/bloc/auth/auth_screen/auth_screen_state.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/screens/auth/widgets/auth_button_widget.dart';

class SignupPhoneCompleteScreen extends StatefulWidget {
  const SignupPhoneCompleteScreen({super.key});

  @override
  State<SignupPhoneCompleteScreen> createState() =>
      _SignupPhoneCompleteScreenState();
}

class _SignupPhoneCompleteScreenState extends State<SignupPhoneCompleteScreen> {
  void _onNextBtnTap() {
    context
        .read<AuthScreenBloc>()
        .add(const AuthScreenEvent(screen: AuthScreenEnum.userInfo));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: Sizes.size72 * 2,
              height: Sizes.size72 * 2,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.asset(
                    'assets/images/honbab_smile.png',
                    width: Sizes.size72 * 2,
                    height: Sizes.size72 * 2,
                  ),
                  Transform.translate(
                    offset: const Offset(
                      -Sizes.size24,
                      Sizes.size16,
                    ),
                    child: Container(
                      width: Sizes.size32,
                      height: Sizes.size32,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff4bde6b),
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gaps.v10,
            Text(
              '핸드폰 인증이 완료되었습니다!',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Gaps.v10,
            Text(
              '이어서 계속 가입과정을 완료해주세요',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        child: GestureDetector(
          onTap: _onNextBtnTap,
          child: AuthBtnWidget(
            title: "계속하기",
            bgColor: Theme.of(context).primaryColor,
            borderColor: Theme.of(context).primaryColor,
            textColor: Colors.white,
            borderRad: 0,
          ),
        ),
      ),
    );
  }
}
