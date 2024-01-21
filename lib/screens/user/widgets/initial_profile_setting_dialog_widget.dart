import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:honbap_signal_flutter/screens/user/widgets/initial_profile_confirm_dialog_widget.dart';
import 'package:honbap_signal_flutter/screens/user/widgets/initial_profile_text_field_widget.dart';

import '../../../apis/user/post_user_initial_info.dart';
import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';

class InitialProfileDialog extends StatefulWidget {
  const InitialProfileDialog({Key? key}) : super(key: key);

  @override
  State<InitialProfileDialog> createState() => _InitialProfileDialogState();
}

class _InitialProfileDialogState extends State<InitialProfileDialog> {
  final food = ['한식', '중식', '일식', '양식', '직접입력'];

  Map<String, String?> formData = {};

  List<String> favoriteFoodList = <String>[];
  List<String> hateFoodList = <String>[];
  String interest = '';
  String mbti = '';
  String userIntro = '';
  String preferArea = '';

  setTextFieldUser(String text) {
    setState(() {
      userIntro = text;
    });
  }

  setInterest(String text) {
    setState(() {
      interest = text;
    });
  }

  setMBTI(String text) {
    setState(() {
      mbti = text;
    });
  }

  setPreferArea(String text) {
    setState(() {
      preferArea = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(7.0),
        ),
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
                          fontSize: Sizes.size18,
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
                          height: Sizes.size24,
                          width: Sizes.size24,
                          fit: BoxFit.cover,
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
                    const Text(
                      '소개글',
                      style: TextStyle(
                        fontSize: Sizes.size14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    Gaps.v8,
                    ProfileTextField(
                      hintWord: '자신을 소개할 수 있는 글을 작성해주세요.',
                      setter: setTextFieldUser,
                    ),
                    Gaps.v16,
                    const Text(
                      '선호음식',
                      style: TextStyle(
                        fontSize: Sizes.size14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    Gaps.v7,
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
                            for (int i = 0; i < food.length; i++)
                              GestureDetector(
                                onTap: () {
                                  favoriteFoodList.contains(food[i])
                                      ? favoriteFoodList.remove(food[i])
                                      : favoriteFoodList.add(food[i]);
                                  setState(() {});
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 9, 12, 9),
                                  decoration: BoxDecoration(
                                    color: favoriteFoodList.contains(food[i])
                                        ? const Color(0xffF35928)
                                        : Colors.white,
                                    border: Border.all(
                                      color: favoriteFoodList.contains(food[i])
                                          ? const Color(0xffF35928)
                                          : const Color(0xffE1E1E1),
                                      width: Sizes.size1,
                                    ),
                                  ),
                                  child: Text(
                                    food[i],
                                    style: TextStyle(
                                      color: favoriteFoodList.contains(food[i])
                                          ? Colors.white
                                          : const Color(0xff737373),
                                      fontSize: Sizes.size10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    Gaps.v17,
                    const Text(
                      '블호음식',
                      style: TextStyle(
                        fontSize: Sizes.size14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    Gaps.v7,
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
                            for (int i = 0; i < food.length; i++)
                              GestureDetector(
                                onTap: () {
                                  hateFoodList.contains(food[i])
                                      ? hateFoodList.remove(food[i])
                                      : hateFoodList.add(food[i]);
                                  setState(() {});
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 9, 12, 9),
                                  decoration: BoxDecoration(
                                    color: hateFoodList.contains(food[i])
                                        ? const Color(0xffF35928)
                                        : Colors.white,
                                    border: Border.all(
                                      color: hateFoodList.contains(food[i])
                                          ? const Color(0xffF35928)
                                          : const Color(0xffE1E1E1),
                                      width: Sizes.size1,
                                    ),
                                  ),
                                  child: Text(
                                    food[i],
                                    style: TextStyle(
                                      color: hateFoodList.contains(food[i])
                                          ? Colors.white
                                          : const Color(0xff737373),
                                      fontSize: Sizes.size10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    Gaps.v14,
                    const Text(
                      '선호장소',
                      style: TextStyle(
                        fontSize: Sizes.size14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    Gaps.v6,
                    ProfileTextField(
                      hintWord: '직접입력',
                      setter: setPreferArea,
                    ),
                    Gaps.v14,
                    const Text(
                      'MBTI',
                      style: TextStyle(
                        fontSize: Sizes.size14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    Gaps.v5,
                    ProfileTextField(
                      hintWord: '직접입력',
                      setter: setMBTI,
                    ),
                    Gaps.v14,
                    const Text(
                      '관심사',
                      style: TextStyle(
                        fontSize: Sizes.size14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    Gaps.v5,
                    ProfileTextField(
                      hintWord: '직접입력',
                      setter: setInterest,
                    ),
                    Gaps.v24,
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        onTapConfirm();
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.zero,
                            bottom: Radius.circular(7),
                          ),
                          color: Color(0xffFF4B26),
                        ),
                        alignment: Alignment.center,
                        height: 50,
                        width: double.maxFinite,
                        child: const Text(
                          '프로필 설정 완료',
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
      ),
    );
  }

  void onTapConfirm() async {
    formData['interest'] = interest;
    formData['preferArea'] = preferArea;
    formData['mbti'] = mbti;
    formData['userIntroduce'] = userIntro;
    formData['taste'] = favoriteFoodList.toString();
    formData['hateFood'] = hateFoodList.toString();

    if (await getUserProfileResponse(formData: formData)) {
      if (!mounted) return; //위젯이 mount 되지 않은 경우

      Navigator.of(context).pop();
      //post가 성공일 때에만 다음 창 띄우고, 아니면 toast message
      showDialog(
        context: context,
        builder: (_) => const InitialProfileConfirmDialog(),
        barrierDismissible: false,
      );
    } else {
      // setState(() {
      //   Fluttertoast.showToast(msg: "서버와의 통신에 실패했습니다.");
      // });
    }
  }
}
