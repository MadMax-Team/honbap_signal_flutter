import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/screens/auth/signup_screen.dart';
import 'package:honbap_signal_flutter/screens/auth/widgets/auth_button_widget.dart';

class SignupPhoneAuthComplete extends StatelessWidget {
  const SignupPhoneAuthComplete({
    super.key,
    required this.phoneNum,
  });

  final String phoneNum;

  void _onContinueTap(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SignupScreen(
          phoneNum: phoneNum,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.black, // <-- SEE HERE
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Gaps.v64,
            Gaps.v64,
            SizedBox(
              width: Sizes.size72 * 2,
              height: Sizes.size72 * 2,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  SvgPicture.asset(
                    'assets/icons/icon_honbab1.svg',
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
              '????????? ????????? ?????????????????????!',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Gaps.v10,
            Text(
              '????????? ?????? ??????????????? ??????????????????',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () => _onContinueTap(context),
        child: AuthBtnWidget(
          title: "????????????",
          bgColor: Theme.of(context).primaryColor,
          borderColor: Theme.of(context).primaryColor,
          textColor: Colors.white,
          borderRad: 0,
        ),
      ),
    );
  }
}
