import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/screens/common/widgets/user_report_dialog_tag_widget.dart';

class UserReportDialog extends StatefulWidget {
  const UserReportDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<UserReportDialog> createState() => _UserReportDialogState();
}

class _UserReportDialogState extends State<UserReportDialog> {
  final ScrollController _scrollController = ScrollController();
  bool isTop = true;
  final List<bool> _selectedOptions = [
    false, // 무리한 연락처 요구
    false, // 무리한 다음 일정 요구
    false, // 술 강요
    false, // 불쾌한 언행과 욕설
    false, // 폭력/협박/갈취
    false, // 기타
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        if (_scrollController.offset == 0) {
          isTop = true;
        } else {
          isTop = false;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _onTagTap(int index) {
    setState(() {
      _selectedOptions[index] = !_selectedOptions[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(Sizes.size10),
          ),
        ),
        contentPadding: const EdgeInsets.all(0),
        contentTextStyle: TextStyle(
          fontSize: Sizes.size12,
          fontWeight: FontWeight.w400,
          color: Colors.grey.shade700,
        ),
        clipBehavior: Clip.hardEdge,
        content: SizedBox(
          width: MediaQuery.of(context).size.width - Sizes.size20,
          height: Sizes.size96 * 5,
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Column(
                children: [
                  Expanded(
                    child: ShaderMask(
                      shaderCallback: (Rect rect) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.transparent,
                            Colors.purple,
                          ],
                          stops: [
                            0.0,
                            0.95,
                            0.98,
                          ], // 10% purple, 80% transparent, 10% purple
                        ).createShader(rect);
                      },
                      blendMode: BlendMode.dstOut,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.size20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Gaps.v52,
                              const Text(
                                '신고대상',
                                style: TextStyle(
                                  fontSize: Sizes.size14,
                                  color: Colors.black,
                                ),
                              ),
                              Gaps.v10,
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(Sizes.size10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: Sizes.size3 / 2,
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(Sizes.size10),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          width: Sizes.size4,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      child: Container(
                                        clipBehavior: Clip.hardEdge,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        // Image.network로 변경하면 됨
                                        child: Image.asset(
                                          "assets/test/test_image.jpg",
                                          width: Sizes.size60,
                                          height: Sizes.size60,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Gaps.h10,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          '난돈이좋아',
                                          style: TextStyle(
                                            fontSize:
                                                Sizes.size16 + Sizes.size2,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Gaps.v10,
                                        Text(
                                          '만남일시: 2022.03.25 19:09:54',
                                          style: TextStyle(
                                            fontSize: Sizes.size10,
                                            color: Colors.grey.shade700,
                                          ),
                                        ),
                                        Gaps.v2,
                                        Text(
                                          '만남위치: 강남역 11번 출구',
                                          style: TextStyle(
                                            fontSize: Sizes.size10,
                                            color: Colors.grey.shade700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Gaps.v10,
                              Text(
                                '어떤 일이 있었나요? 더 좋은 혼밥시그널의 만남을 위해 있었던 일을 아래 칸에 적어주세요. 사진자료를 첨부해 주시면 운영진의 빠른 처리에 도움이 됩니다.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: Sizes.size10,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              Gaps.v32,
                              Wrap(
                                direction: Axis.horizontal,
                                spacing: Sizes.size4,
                                runSpacing: Sizes.size4,
                                children: <Widget>[
                                  UserReportTag(
                                    tag: '무리한 연락처 요구',
                                    onTap: () => _onTagTap(0),
                                    isSelected: _selectedOptions[0],
                                  ),
                                  UserReportTag(
                                    tag: '무리한 다음 일정 요구',
                                    onTap: () => _onTagTap(1),
                                    isSelected: _selectedOptions[1],
                                  ),
                                  UserReportTag(
                                    tag: '술 강요',
                                    onTap: () => _onTagTap(2),
                                    isSelected: _selectedOptions[2],
                                  ),
                                  UserReportTag(
                                    tag: '불쾌한 언행과 욕설',
                                    onTap: () => _onTagTap(3),
                                    isSelected: _selectedOptions[3],
                                  ),
                                  UserReportTag(
                                    tag: '폭력/협박/갈취',
                                    onTap: () => _onTagTap(4),
                                    isSelected: _selectedOptions[4],
                                  ),
                                  UserReportTag(
                                    tag: '기타',
                                    onTap: () => _onTagTap(5),
                                    isSelected: _selectedOptions[5],
                                  ),
                                ],
                              ),
                              Gaps.v32,
                              TextField(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey.shade300,
                                  border: InputBorder.none,
                                  hintText: '기타',
                                ),
                                style: const TextStyle(
                                  fontSize: Sizes.size12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Gaps.v3,
                              Align(
                                alignment: AlignmentDirectional.centerEnd,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.add_circle_rounded,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      Gaps.h3,
                                      Text(
                                        '첨부하기',
                                        style: TextStyle(
                                          fontSize: Sizes.size12,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Gaps.v20,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          width: Sizes.size1,
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              height: Sizes.size44,
                              color: Colors.white,
                              child: Text(
                                '뒤로 돌아가기',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              height: Sizes.size44,
                              color: Theme.of(context).primaryColor,
                              child: const Text(
                                '신고하기',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              if (isTop)
                IgnorePointer(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: Sizes.size52),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: Sizes.size40,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                )
              else
                Container(),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
