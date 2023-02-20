import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:honbap_signal_flutter/screens/user/widgets/initial_profile_text_field_widget.dart';

class InitialProfileDialog extends StatefulWidget {
  const InitialProfileDialog({Key? key}) : super(key: key);

  @override
  State<InitialProfileDialog> createState() => _InitialProfileDialogState();
}

class _InitialProfileDialogState extends State<InitialProfileDialog> {
  final food = ['한식', '중식', '일식', '양식', '직접입력'];
  List<String> favoriteFoodList = <String>[];
  List<String> hateFoodList = <String>[];


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(7.0)),
      ),
      contentPadding: const EdgeInsets.fromLTRB(0, 18, 0, 0),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.fromLTRB(27, 0, 14, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        '프로필 설정',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        padding: const EdgeInsets.all(0),
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: SvgPicture.asset(
                          'assets/icons/user_profile_exit_icon.svg',
                          height: 24,
                          width: 24,
                          fit: BoxFit.fill,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 23),
              Container(
                width: double.maxFinite,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.fromLTRB(27, 0, 26, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '소개글',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    ProfileTextField(hintWord: '자신을 소개할 수 있는 글을 작성해주세요.'),
                    SizedBox(height: 16),
                    Text(
                      '선호음식',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 7),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: double.maxFinite,
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Wrap(
                          direction: Axis.horizontal,
                          spacing: 6,
                          runSpacing: 7,
                          children: [
                            for (int i = 0;
                            i < food.length;
                            i++)
                              GestureDetector(
                                onTap: () {
                                  favoriteFoodList.contains(food[i]) ? favoriteFoodList.remove(food[i]) : favoriteFoodList.add(food[i]);
                                  print(favoriteFoodList);
                                  setState(() {});
                                },
                                child: Container(
                                  padding: const EdgeInsets.fromLTRB(12, 9, 12, 9),
                                  decoration: BoxDecoration(
                                    color: favoriteFoodList.contains(food[i]) ? Color(0xffF35928) : Colors.white,
                                    border: Border.all(
                                      color: favoriteFoodList.contains(food[i]) ? Color(0xffF35928) : Color(0xffE1E1E1),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    food[i],
                                    style: TextStyle(
                                      color: favoriteFoodList.contains(food[i]) ? Colors.white : Color(0xff737373),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 17),
                    Text(
                      '블호음식',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 7),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: double.maxFinite,
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Wrap(
                          direction: Axis.horizontal,
                          spacing: 6,
                          runSpacing: 7,
                          children: [
                            for (int i = 0;
                            i < food.length;
                            i++)
                              GestureDetector(
                                onTap: () {
                                  favoriteFoodList.contains(food[i]) ? favoriteFoodList.remove(food[i]) : favoriteFoodList.add(food[i]);
                                  print(favoriteFoodList);
                                  setState(() {});
                                },
                                child: Container(
                                  padding: const EdgeInsets.fromLTRB(12, 9, 12, 9),
                                  decoration: BoxDecoration(
                                    color: favoriteFoodList.contains(food[i]) ? Color(0xffF35928) : Colors.white,
                                    border: Border.all(
                                      color: favoriteFoodList.contains(food[i]) ? Color(0xffF35928) : Color(0xffE1E1E1),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    food[i],
                                    style: TextStyle(
                                      color: favoriteFoodList.contains(food[i]) ? Colors.white : Color(0xff737373),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 14),
                    Text(
                      '선호장소',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 6),
                    ProfileTextField(hintWord: '직접입력'),
                    SizedBox(height: 14),
                    Text(
                      'MBTI',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 5),
                    ProfileTextField(hintWord: '직접입력'),
                    SizedBox(height: 14),
                    Text(
                      '관심사',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 5),
                    ProfileTextField(hintWord: '직접입력'),
                    SizedBox(height: 24),
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
                          color: Color(0xffFF4B26),
                        ),
                        alignment: Alignment.center,
                        height: 50,
                        width: double.maxFinite,
                        child: const Text(
                          '프로필 설정 완료',
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
      ),
    );
  }
}
