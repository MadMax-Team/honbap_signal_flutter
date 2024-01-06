import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';

class AfterMealDialog extends StatefulWidget {
  const AfterMealDialog({
    Key? key,
    //required this.matchedInfo,
  }) : super(key: key);

  //final MatchedInfo matchedInfo;

  @override
  State<AfterMealDialog> createState() => _AfterMealDialogState();
}

class _AfterMealDialogState extends State<AfterMealDialog> {
  final review = [
    '식사 매너가 좋았습니다',
    '메뉴 선정이 탁월하였습니다',
    '대화 매너가 좋았습니다',
    '즐거운 시간이었습니다'
  ];
  List<String> reviewList = <String>[];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xffF2F2F2),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(7.0),
        ),
      ),
      contentPadding: const EdgeInsets.fromLTRB(0, 9, 0, 0),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
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
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 8, 13, 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: Sizes.size72,
                            width: Sizes.size72,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(125),
                              border: Border.all(
                                width: Sizes.size3,
                                color: const Color(0xffF35928),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25.0),
                              child: Image.network(
                                //widget.matchedInfo.image!,
                                'link',
                                fit: BoxFit.fill,
                                errorBuilder: ((context, error, stackTrace) =>
                                    SvgPicture.asset(
                                      'assets/icons/icon_honbab1.svg',
                                      alignment: Alignment.center,
                                      fit: BoxFit.fill,
                                    )),
                              ),
                            ),
                          ),
                          Gaps.h14,
                          const Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    //matched
                                    '마이닉네임',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: Sizes.size18,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Gaps.h6,
                                  Text(
                                    '님과',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: Sizes.size14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '만남은 어떠셨나요?',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: Sizes.size14,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    RatingBar(
                      initialRating: 4,
                      minRating: 0.5,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      glowColor: Colors.white,
                      itemCount: 5,
                      itemSize: Sizes.size24,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 2.5),
                      ratingWidget: RatingWidget(
                        full: SvgPicture.asset(
                          'assets/icons/rating_star_icon_full.svg',
                          alignment: Alignment.center,
                          fit: BoxFit.fill,
                        ),
                        half: SvgPicture.asset(
                          'assets/icons/rating_star_icon_empty.svg',
                          alignment: Alignment.center,
                          fit: BoxFit.fill,
                        ),
                        empty: SvgPicture.asset(
                          'assets/icons/rating_star_icon_empty.svg',
                          alignment: Alignment.center,
                          fit: BoxFit.fill,
                        ),
                      ),
                      onRatingUpdate: (rating) {
                        // print(rating);
                      },
                    ),
                    Gaps.v8,
                    const Text(
                      '더 좋은 혼밥시그널의 만남을 위해 피드백을 남겨주세요',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: Sizes.size9,
                        color: Color(0xff737373),
                      ),
                    ),
                    const SizedBox(height: 61),
                    Container(
                      alignment: Alignment.center,
                      width: double.maxFinite,
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Wrap(
                          direction: Axis.horizontal,
                          spacing: 6,
                          runSpacing: 7,
                          children: [
                            for (int i = 0; i < review.length; i++)
                              GestureDetector(
                                onTap: () {
                                  reviewList.contains(review[i])
                                      ? reviewList.remove(review[i])
                                      : reviewList.add(review[i]);
                                  // print(reviewList);
                                  setState(() {});
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(11, 7, 11, 9),
                                  decoration: BoxDecoration(
                                    color: reviewList.contains(review[i])
                                        ? const Color(0xffF35928)
                                        : const Color(0xffF2F2F2),
                                    border: Border.all(
                                      color: reviewList.contains(review[i])
                                          ? const Color(0xffF35928)
                                          : const Color(0xffE1E1E1),
                                      width: Sizes.size1,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(14),
                                    ),
                                  ),
                                  child: Text(
                                    review[i],
                                    style: TextStyle(
                                      color: reviewList.contains(review[i])
                                          ? Colors.white
                                          : Colors.black,
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
                    const SizedBox(height: 39),
                    Container(
                      padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                      child: const TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          hintText: '기타 남기고 싶은 피드백이 있다면 적어주세요',
                          isDense: true,
                          contentPadding: EdgeInsets.fromLTRB(11, 8, 11, 8),
                          filled: true,
                          fillColor: Color(0xffDBDBDB),
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: Sizes.size12,
                            color: Color(0xff737373),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: Sizes.size12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(7, 0, 7, 17),
                      width: double.maxFinite,
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // print('click 신고');
                        },
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: const EdgeInsets.all(5),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          '신고하기',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: Sizes.size10,
                            color: Color(0xff737373),
                          ),
                        ),
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
                          '보내기',
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
}
