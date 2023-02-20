import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InitialProfileConfirmDialog extends StatefulWidget {
  const InitialProfileConfirmDialog({Key? key}) : super(key: key);

  @override
  State<InitialProfileConfirmDialog> createState() => _InitialProfileConfirmDialogState();
}

class _InitialProfileConfirmDialogState extends State<InitialProfileConfirmDialog> {
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
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: Column(
                children: [
                  SizedBox(
                    width: 96,
                    height: 96,
                    child: SvgPicture.asset(
                      'assets/icons/user_profile_honbob_icon.svg',
                      alignment: Alignment.center,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    '프로필 설정이 완료되었습니다!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    textAlign: TextAlign.center,
                    '프로필 수정은 마이페이지>프로필설정에서 가능합니다',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff737373),
                    ),
                  ),
                  const SizedBox(height: 25),
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
                        borderRadius: BorderRadius.vertical(top: Radius.zero, bottom: Radius.circular(7)),
                        color: Color(0xffF35928),
                      ),
                      alignment: Alignment.center,
                      height: 46,
                      width: double.maxFinite,
                      child: const Text(
                        '혼밥시그널 시작하기',
                        style: TextStyle(
                          fontSize: 14,
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
