import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/models/signal/signal_list_model.dart';
import 'package:honbap_signal_flutter/screens/signal/widgets/signal_dialog_usertag_widget.dart';
import 'package:honbap_signal_flutter/widgets/common_profile_image_widget.dart';

class SignalUserDialog extends StatefulWidget {
  const SignalUserDialog({
    super.key,
    required this.signal,
  });

  final SignalListModel signal;

  @override
  State<SignalUserDialog> createState() => _SignalUserDialogState();
}

class _SignalUserDialogState extends State<SignalUserDialog> {
  final ScrollController _scrollController = ScrollController();
  bool isTop = true;

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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
                          children: [
                            Gaps.v32,
                            CommonProfileImageWidget(
                              profileImg: widget.signal.profileImg,
                              size: Sizes.size44,
                            ),
                            Gaps.v16,
                            Text(
                              widget.signal.userName ?? '',
                              style: const TextStyle(
                                fontSize: Sizes.size14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            Gaps.v16,
                            Text(
                              widget.signal.userIntroduce ?? '',
                              textAlign: TextAlign.center,
                            ),
                            if (widget.signal.checkSigWrite != 0)
                              Container(
                                margin:
                                    const EdgeInsets.only(top: Sizes.size32),
                                padding: const EdgeInsets.all(Sizes.size12),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: Sizes.size1,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(Sizes.size7),
                                ),
                                child: Column(
                                  children: [
                                    InfoRow(
                                      title: '만남위치',
                                      icon: Icons.location_on_outlined,
                                      info: widget.signal.sigPromiseArea ?? '',
                                    ),
                                    InfoRow(
                                      title: '약속시간',
                                      icon: Icons.access_time_rounded,
                                      info: widget.signal.sigPromiseTime ?? '',
                                    ),
                                    InfoRow(
                                      title: '메뉴',
                                      icon: Icons.restaurant_menu_rounded,
                                      info: widget.signal.sigPromiseMenu ?? '',
                                    ),
                                  ],
                                ),
                              )
                            else
                              Container(),
                            Gaps.v32,
                            SizedBox(
                              width: double.infinity,
                              child: Wrap(
                                direction: Axis.horizontal,
                                spacing: Sizes.size4,
                                runSpacing: Sizes.size4,
                                children: [
                                  for (var tag
                                      in widget.signal.interest?.split(',') ??
                                          [])
                                    DialogUserTag(tag: tag),
                                ],
                              ),
                            ),
                            Gaps.v32,
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      '불호음식: ${widget.signal.hateFood ?? '없음'}'),
                                  Gaps.v3,
                                  Text('선호음식: ${widget.signal.taste ?? '없음'}'),
                                  Gaps.v3,
                                  Text(
                                      '선호장소: ${widget.signal.preferArea ?? '없음'}'),
                                  Gaps.v3,
                                  Text('MBTI: ${widget.signal.mbti ?? '비밀'}'),
                                ],
                              ),
                            ),
                            Gaps.v20,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: Navigator.of(context).pop,
                        child: Container(
                          alignment: Alignment.center,
                          height: Sizes.size52,
                          color: Colors.grey.shade300,
                          child: const Text(
                            '닫기',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          print('request signal');
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: Sizes.size52,
                          color: Theme.of(context).primaryColor,
                          child: const Text(
                            '시그널 요청 보내기',
                            style: TextStyle(
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
                onPressed: Navigator.of(context).pop,
                icon: Icon(
                  Icons.close,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String title, info;
  final IconData icon;

  const InfoRow({
    Key? key,
    required this.title,
    required this.info,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: Sizes.size60,
          height: Sizes.size24,
          alignment: Alignment.centerLeft,
          decoration: const BoxDecoration(),
          clipBehavior: Clip.hardEdge,
          child: Text(
            '$title ',
            style: TextStyle(
              fontSize: Sizes.size14,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        Gaps.h3,
        Icon(
          icon,
          size: Sizes.size20,
          color: Colors.grey.shade600,
        ),
        Gaps.h7,
        Expanded(
          child: Text(
            ' $info',
            style: TextStyle(
              fontSize: Sizes.size14,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      ],
    );
  }
}
