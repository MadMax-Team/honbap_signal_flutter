import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:honbap_signal_flutter/screens/home/widgets/home_dialog/signal_on_dialog_third_widget.dart';
import 'package:intl/intl.dart';

import '../../../../constants/gaps.dart';
import '../../../../constants/sizes.dart';

class SignalSecondDialog extends StatefulWidget {
  final BuildContext parentContext;
  final bool modify;
  const SignalSecondDialog({super.key, required this.parentContext, required this.modify});

  @override
  State<SignalSecondDialog> createState() => _SignalSecondDialogState();
}

class _SignalSecondDialogState extends State<SignalSecondDialog> {
  late String time;
  late String location;

  final TextEditingController _controller = TextEditingController();

  final _valueList = ['상관없음', '돈까스/회/일식', '고기/구이', '찜/탕/찌개', '마라탕', '샐러드', '양식', '패스트푸드', '중식', '분식', '아시안', '백반/죽/국수', '도시락', '카페/디저트', '기타'];
  var _selectedValue = '상관없음';

  @override
  void initState() {
    super.initState();
    DateTime dateTime = DateTime.now();
    dateTime = dateTime.toUtc().add(const Duration(hours: 9));
    time = getCalculateFutureTime(context, TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));
    //API with Repository

    if(widget.modify) {
      setState(() { //temp setting
        time = "time";
        _selectedValue = '상관없음';
        _controller.text = "ㅇㅇ";
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        time = getCalculateTime(context, pickedTime);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      //contentPadding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
      child: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 20,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Gaps.v16,
                    Container(
                      width: double.maxFinite,
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.only(right: 3.0),
                      child: IconButton(
                        padding: const EdgeInsets.all(0),
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                    Gaps.v18,
                    Container(
                      width: double.maxFinite,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
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
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '약속시간',
                                        style: TextStyle(
                                            fontSize: Sizes.size16,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff737373)),
                                      ),
                                      Gaps.h16,
                                      Icon(
                                        Icons.access_time,
                                        color: Color(0xff737373),
                                        size: Sizes.size20,
                                      ),
                                    ],
                                  ),
                                  Gaps.v20,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '만날위치',
                                        style: TextStyle(
                                            fontSize: Sizes.size16,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff737373)),
                                      ),
                                      Gaps.h16,
                                      Icon(
                                        Icons.place,
                                        color: Color(0xff737373),
                                        size: Sizes.size20,
                                      ),
                                    ],
                                  ),
                                  Gaps.v20,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '메뉴',
                                        style: TextStyle(
                                            fontSize: Sizes.size16,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff737373)),
                                      ),
                                      Gaps.h16,
                                      Icon(
                                        Icons.restaurant_menu,
                                        color: Color(0xff737373),
                                        size: Sizes.size20,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Gaps.h15,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _selectTime(context);
                                      },
                                      child: Text(
                                        time,
                                        style: const TextStyle(
                                          fontSize: Sizes.size16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Gaps.v4,
                                    Container(
                                      height: 1,
                                      color: const Color(0xffe1e1e1),
                                    ),
                                    Gaps.v16,
                                    TextField(
                                      controller: _controller,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '근처 역이나 원하는 장소',
                                        hintStyle: TextStyle(
                                          color: Color(0xffe1e1e1),
                                          fontSize: Sizes.size16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        contentPadding: EdgeInsets.zero,
                                        isDense: true,
                                      ),
                                      style: const TextStyle(
                                        color: Color(0xff737373),
                                        fontSize: Sizes.size16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Gaps.v4,
                                    Container(
                                      height: 1,
                                      color: const Color(0xffe1e1e1),
                                    ),
                                    Gaps.v16,
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
                                    Gaps.v4,
                                    Container(
                                      height: 1,
                                      color: const Color(0xffe1e1e1),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Gaps.v16,
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
                    const SizedBox(height: 61),
                    Container(
                      width: double.maxFinite,
                      margin: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                      padding: const EdgeInsets.fromLTRB(16.0, 18.0, 16.0, 20.0),
                      decoration: BoxDecoration(
                        color: const Color(0xfff5f5f5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                size: 20.0,
                                color: Color(0xffc4c4c4),
                              ),
                              Gaps.h6,
                              Text(
                                '유의사항',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: Sizes.size14,
                                  color: Color(0xffc4c4c4),
                                ),
                              ),
                            ],
                          ),
                          Gaps.v8,
                          Text(
                            '• 해당 내용은 매칭 후 상대방과 쪽지를 통해 조율가능합니다.\n• 홈>시그널글수정을 통해 수정가능합니다.',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: Sizes.size14,
                              color: Color(0xffc4c4c4),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                        showDialog(
                            context: context,
                            builder: (_) => SignalThirdBox(parentContext: widget.parentContext),
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
                            builder: (_) => SignalThirdBox(time: time, location: _controller.text, favoriteFood: _selectedValue, parentContext: widget.parentContext),
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
              ),
            ],
          ),
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

String getCalculateFutureTime(BuildContext context, TimeOfDay now) {
  int hourData = now.hour + 1;
  String formatDate;
  if (hourData < 12) {
    formatDate = '오전  ${hourData.toString()} : 00';
  } else {
    if (hourData == 12) {
      formatDate = '오후  ${(hourData).toString()} : 00';
    }
    else {
      formatDate = '오후  ${(hourData - 12).toString()} : 00';
    }
  }
  return formatDate;
}

String getCalculateTime(BuildContext context, TimeOfDay now) {
  int hourData = now.hour;
  int minuteData = now.minute;
  String formatDate;
  if (hourData < 12) {
    formatDate = '오전  ${hourData.toString()} : ${minuteData.toString()}';
  } else {
    if (hourData == 12) {
      formatDate = '오후  ${(hourData).toString()} : ${minuteData.toString()}';
    }
    else {
      formatDate = '오후  ${(hourData - 12).toString()} : ${minuteData.toString()}';
    }
  }
  return formatDate;
}
