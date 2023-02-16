import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/screens/home/widgets/home_dialog/signal_on_dialog_third_widget.dart';
import 'package:intl/intl.dart';

class SignalSecondDialog extends StatefulWidget {
  const SignalSecondDialog({Key? key}) : super(key: key);

  @override
  State<SignalSecondDialog> createState() => _SignalSecondDialogState();
}

class _SignalSecondDialogState extends State<SignalSecondDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xffF2F2F2),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(7.0)),
      ),
      contentPadding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.maxFinite,
              alignment: Alignment.centerRight,
              child: IconButton(
                padding: const EdgeInsets.all(0),
                constraints: const BoxConstraints(),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(height: 26),
            Container(
              width: double.maxFinite,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '시그널 글 작성',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    '구체적인 시그널을 작성하여 매칭상대를 빠르게 찾아보세요',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff737373),
                    ),
                  ),
                  const SizedBox(height: 46),
                  Row(
                    children: const [
                      Text(
                        '약속시간',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff737373)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 9),
                  Row(
                    children: const [
                      Text(
                        '만날장소',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff737373)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 9),
                  Row(
                    children: const [
                      Text(
                        '메뉴',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff737373)),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 131),
            Container(
              width: double.maxFinite,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
              child: Text(
                '시그널 생성일자 ${checkTime(context)}',
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 9,
                    color: Color(0xff8E8E8E)),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      showDialog(
                          context: context,
                          builder: (_) => const SignalThirdBox(),
                          barrierDismissible: false);
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 22),
                      alignment: Alignment.center,
                      height: 46,
                      width: double.maxFinite,
                      child: const Text(
                        '건너뛰기',
                        style: TextStyle(
                          fontSize: 14,
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
                      showDialog(
                          context: context,
                          builder: (_) => const SignalThirdBox(),
                          barrierDismissible: false);
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 22),
                      alignment: Alignment.center,
                      height: 46,
                      width: double.maxFinite,
                      child: const Text(
                        '작성완료',
                        style: TextStyle(
                          fontSize: 14,
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

String checkTime(BuildContext context) {
  var now = DateTime.now();
  now = now.toUtc().add(const Duration(hours: 9));
  String formatDate = DateFormat('yyyy.MM.dd  HH:mm').format(now); //format변경
  return formatDate;
}