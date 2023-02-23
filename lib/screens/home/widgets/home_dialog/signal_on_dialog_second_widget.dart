import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:honbap_signal_flutter/screens/home/widgets/home_dialog/signal_on_dialog_third_widget.dart';
import 'package:intl/intl.dart';

import '../../../../constants/gaps.dart';
import '../../../../constants/sizes.dart';

class SignalSecondDialog extends StatefulWidget {
  const SignalSecondDialog({Key? key}) : super(key: key);

  @override
  State<SignalSecondDialog> createState() => _SignalSecondDialogState();
}

class _SignalSecondDialogState extends State<SignalSecondDialog> {
  final _valueList = ['직접입력', '프로필 불러오기'];
  var _selectedValue = '직접입력';

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
                icon: SvgPicture.asset(
                  'assets/icons/user_profile_exit_icon.svg',
                  height: Sizes.size24,
                  width: Sizes.size24,
                  fit: BoxFit.fill,
                  alignment: Alignment.center,
                ),
              ),
            ),
            Gaps.v26,
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
                      fontSize: Sizes.size18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Gaps.v6,
                  const Text(
                    '구체적인 시그널을 작성하여 매칭상대를 빠르게 찾아보세요',
                    style: TextStyle(
                      fontSize: Sizes.size12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff737373),
                    ),
                  ),
                  Gaps.v46,
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            '약속시간',
                            style: TextStyle(
                                fontSize: Sizes.size16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff737373)),
                          ),
                          Gaps.v18,
                          Text(
                            '만날장소',
                            style: TextStyle(
                                fontSize: Sizes.size16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff737373)),
                          ),
                          Gaps.v18,
                          Text(
                            '메뉴',
                            style: TextStyle(
                                fontSize: Sizes.size16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff737373)),
                          ),
                        ],
                      ),
                      Gaps.h6,
                      Column(
                        children: const [
                          Icon(
                            Icons.schedule,
                            color: Color(0xff737373),
                            size: Sizes.size20,
                          ),
                          Gaps.v18,
                          Icon(
                            Icons.place,
                            color: Color(0xff737373),
                            size: Sizes.size20,
                          ),
                          Gaps.v18,
                          Icon(
                            Icons.restaurant,
                            color: Color(0xff737373),
                            size: Sizes.size20,
                          ),
                        ],
                      ),
                      Gaps.h15,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getCalculateTime(context),
                            style: const TextStyle(
                                fontSize: Sizes.size16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          Gaps.v18,
                          const Text(
                            '압구정역',
                            style: TextStyle(
                                fontSize: Sizes.size16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          Gaps.v18,
                          DropdownButton(
                            isDense : true,
                            elevation: 0, //remove floating shadow
                            value: _selectedValue,
                            items: _valueList.map(
                              (value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(
                                    value,
                                  ),
                                );
                              },
                            ).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedValue = value!;
                              });
                            },
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: Sizes.size16,
                              color: Color(0xff737373),
                            ),
                            icon: SvgPicture.asset(
                              'assets/icons/home_dropdown_more.svg',
                              alignment: Alignment.center,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
                    fontSize: Sizes.size9,
                    color: Color(0xff8E8E8E)),
              ),
            ),
            Gaps.v20,
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
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 22),
                      alignment: Alignment.center,
                      height: Sizes.size46,
                      width: double.maxFinite,
                      child: const Text(
                        '건너뛰기',
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
                      showDialog(
                          context: context,
                          builder: (_) => SignalThirdBox(),
                          barrierDismissible: false);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 22),
                      alignment: Alignment.center,
                      height: Sizes.size46,
                      width: double.maxFinite,
                      child: const Text(
                        '작성완료',
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

String checkTime(BuildContext context) {
  var now = DateTime.now();
  now = now.toUtc().add(const Duration(hours: 9));
  String formatDate = DateFormat('yyyy.MM.dd  HH:mm').format(now); //format변경
  return formatDate;
}

String getCalculateTime(BuildContext context) {
  var now = DateTime.now();
  now = now.toUtc().add(const Duration(hours: 9));
  int hourData = int.parse(DateFormat('HH').format(now)) + 1;
  String formatDate;
  if (hourData < 12) {
    formatDate = '오전  ${hourData.toString()} : 00';
  } else {
    formatDate = '오후  ${(hourData - 12).toString()} : 00';
  }
  return formatDate;
}
