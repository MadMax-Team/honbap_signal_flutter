import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';

class InitialProfileConfirmDialog extends StatefulWidget {
  const InitialProfileConfirmDialog({Key? key}) : super(key: key);

  @override
  State<InitialProfileConfirmDialog> createState() =>
      _InitialProfileConfirmDialogState();
}

class _InitialProfileConfirmDialogState
    extends State<InitialProfileConfirmDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xffF2F2F2),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(7.0)),
      ),
      contentPadding: const EdgeInsets.all(0),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Gaps.v16,
            Container(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: Column(
                children: [
                  SizedBox(
                    width: Sizes.size96,
                    height: Sizes.size96,
                    child: SvgPicture.asset(
                      'assets/icons/user_profile_honbob_icon.svg',
                      alignment: Alignment.center,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Gaps.v6,
                  const Text(
                    '프로필 설정이 완료되었습니다!',
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Gaps.v6,
                  const Text(
                    textAlign: TextAlign.center,
                    '프로필 수정은 마이페이지>프로필설정에서 가능합니다',
                    style: TextStyle(
                      fontSize: Sizes.size12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff737373),
                    ),
                  ),
                  Gaps.v25,
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.zero,
                          bottom: Radius.circular(7),
                        ),
                        color: Color(0xffF35928),
                      ),
                      alignment: Alignment.center,
                      height: Sizes.size46,
                      width: double.maxFinite,
                      child: const Text(
                        '혼밥시그널 시작하기',
                        style: TextStyle(
                          fontSize: Sizes.size14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
