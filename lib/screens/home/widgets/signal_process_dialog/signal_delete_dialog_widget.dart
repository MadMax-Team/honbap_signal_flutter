import 'package:flutter/material.dart';
import '../../../../constants/gaps.dart';
import '../../../../constants/sizes.dart';

class SignalDeleteDialog extends StatefulWidget {
  final BuildContext parentContext;
  final String? nickname;
  final int userIdx;
  final Function() deleteTap;

  const SignalDeleteDialog(
      {super.key,
      required this.parentContext,
      required this.userIdx,
      required this.deleteTap,
      this.nickname});

  @override
  State<SignalDeleteDialog> createState() => _SignalDeleteDialog();
}

class _SignalDeleteDialog extends State<SignalDeleteDialog> {
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
            Text(
              '\'${widget.nickname ?? '익명의 유저'}\'님의 시그널을 삭제하시겠습니까?',
              style: const TextStyle(
                fontSize: Sizes.size14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Gaps.v19,
            const Text(
              textAlign: TextAlign.center,
              '시그널을 삭제하시면 상대방에게 알람은 가지 않으며,\n‘나에게 온 시그널’에서 표시되지 않습니다.',
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
                        '아니오',
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
                      widget.deleteTap();
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      alignment: Alignment.center,
                      height: Sizes.size46,
                      width: double.maxFinite,
                      child: const Text(
                        '삭제하기',
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
