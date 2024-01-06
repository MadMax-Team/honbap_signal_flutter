import 'package:flutter/material.dart';
import '../../../../constants/gaps.dart';
import '../../../../constants/sizes.dart';

class SignalDeniedDialog extends StatefulWidget {
  const SignalDeniedDialog(
      {super.key});

  @override
  State<SignalDeniedDialog> createState() => _SignalDeniedDialog();
}

class _SignalDeniedDialog extends State<SignalDeniedDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFFFFFFFF),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(7.0)),
      ),
      contentPadding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Gaps.v35,
            const Text(
              '시그널이 on 상태일 때에만 수락이 가능합니다.',
              style: TextStyle(
                fontSize: Sizes.size14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Gaps.v19,
            const Text(
              textAlign: TextAlign.center,
              '매칭을 수락하고 싶으시면 현재 매칭을 취소하거나, 시그널을 켠 뒤 다시 시도해 주세요.',
              style: TextStyle(
                fontSize: Sizes.size12,
                fontWeight: FontWeight.w400,
                color: Color(0xff737373),
              ),
            ),
            Gaps.v17,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      alignment: Alignment.center,
                      height: Sizes.size46,
                      width: double.maxFinite,
                      child: const Text(
                        '취소',
                        style: TextStyle(
                          fontSize: Sizes.size14,
                          color: Color(0xffC4C4C4),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      alignment: Alignment.center,
                      height: Sizes.size46,
                      width: double.maxFinite,
                      child: const Text(
                        '확인',
                        style: TextStyle(
                          fontSize: Sizes.size14,
                          color: Color(0xffF35928),
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
