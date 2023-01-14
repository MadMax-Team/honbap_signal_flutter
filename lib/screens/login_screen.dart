import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/widgets/login_screen/login_button_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(20),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "함께 밥 먹을 친구를",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            const Text(
              "찾아볼까요?",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            Flexible(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.grey.shade400,
                    height: 150,
                    child: const Center(
                      child: Text('이미지'),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  LoginBtnWidget(
                    title: "회원가입 하기",
                    bgColor: Theme.of(context).primaryColor,
                    borderColor: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  LoginBtnWidget(
                    title: "로그인 하기",
                    bgColor: Colors.white,
                    borderColor: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                          height: 2,
                          color: const Color(0xffe6e6e6),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          '간편로그인',
                          style: TextStyle(
                            color: Color(0xFFB8B8B8),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          height: 2,
                          color: const Color(0xffe6e6e6),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  LoginBtnWidget(
                    title: "카카오로 로그인",
                    bgColor: const Color(0xffffe500),
                    borderColor: const Color(0xffffe500),
                    textColor: const Color(0xff402326),
                    icon: Image.asset(
                      'assets/images/kakaotalk_logo.png',
                      width: 23,
                      height: 23,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    '회원가입 시 혼밥시그널의 서비스 이용 약관과 개인정보 보호정책에 동의하게 됩니다.',
                    style: TextStyle(
                      color: Color(0xFFB8B8B8),
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
