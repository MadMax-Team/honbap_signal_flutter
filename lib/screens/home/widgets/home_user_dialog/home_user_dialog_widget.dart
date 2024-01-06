import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/bloc/signal/signal_user/signal_user_bloc.dart';
import 'package:honbap_signal_flutter/bloc/signal/signal_user/signal_user_event.dart';
import 'package:honbap_signal_flutter/bloc/signal/signal_user/signal_user_state.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/models/signal/signal_list_model.dart';
import 'package:honbap_signal_flutter/screens/signal/widgets/signal_dialog_usertag_widget.dart';
import 'package:honbap_signal_flutter/widgets/common_profile_image_widget.dart';
import 'package:honbap_signal_flutter/widgets/common_signal_card_widget.dart';

import '../../../../models/signal/signal_info_model.dart';

class HomeUserDialog extends StatefulWidget {
  final BuildContext parentContext;
  final int userIdx;
  final String button1;
  final String button2;
  final leftTap;
  final rightTap;


  const HomeUserDialog({
    super.key,
    required this.parentContext,
    required this.userIdx,
    required this.button1,
    required this.button2,
    this.leftTap,
    this.rightTap,
  });

  @override
  State<HomeUserDialog> createState() => _HomeUserDialog();
}

class _HomeUserDialog extends State<HomeUserDialog> {
  final ScrollController _scrollController = ScrollController();
  bool isTop = true;
  late SignalListModel userProfile;

  @override
  void initState() {
    super.initState();
    context.read<SignalUserStateBloc>().add(SignalUserStateGetEvent(widget.userIdx));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.position.maxScrollExtent <= 0) {
        /// 스크롤이 없는 경우
        setState(() {
          isTop = false;
        });
      } else {
        /// 스크롤이 있는 경우
        _scrollController.addListener(() {
          setState(() {
            isTop = _scrollController.offset == 0;
          });
        });
      }
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
        child: BlocBuilder<SignalUserStateBloc, SignalUserStateState>(
          builder: (context, state) {
            /// 이후 수정 예정 - 현재는 켤 때마다 재 loading
            // if(state.state == SignalUserState.init) {
            //   context.read<SignalUserStateBloc>().add(SignalUserStateGetEvent(widget.userIdx));
            // }
            if(state.state == SignalUserState.loading) {
              return Stack(
                alignment: AlignmentDirectional.center,
                children: [
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
                  const CircularProgressIndicator(),
                ],
              );
            } else {
              return Stack(
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
                                    profileImg: (state.userProfile.profileImg != null && state.userProfile.profileImg != "")
                                        ? state.userProfile.profileImg
                                        : null,
                                    size: Sizes.size44,
                                  ),
                                  Gaps.v16,
                                  Text(
                                    state.userProfile.nickName ?? '',
                                    style: const TextStyle(
                                      fontSize: Sizes.size14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Gaps.v16,
                                  Text(
                                    state.userProfile.userIntroduce ?? '소개 없음',
                                    textAlign: TextAlign.center,
                                  ),
                                  /// signal information
                                  // if (state.userProfile.checkSigWrite != 0)
                                  //   Padding(
                                  //     padding: const EdgeInsets.only(
                                  //       top: Sizes.size20,
                                  //     ),
                                  //     child: CommonSignalCardWidget(
                                  //       initSignal: SignalInfoModel(
                                  //         sigPromiseArea:
                                  //         state.userProfile.sigPromiseArea,
                                  //         sigPromiseTime:
                                  //         state.userProfile.sigPromiseTime,
                                  //         sigPromiseMenu:
                                  //         state.userProfile.sigPromiseMenu,
                                  //       ),
                                  //       primaryColor: Theme.of(context).primaryColor,
                                  //     ),
                                  //   )
                                  // else
                                  //   Container(),
                                  if (state.userProfile.interest?.isNotEmpty == true)
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(top: Sizes.size32),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Wrap(
                                          direction: Axis.horizontal,
                                          spacing: Sizes.size4,
                                          runSpacing: Sizes.size4,
                                          children: [
                                            for (var tag in state.userProfile.interest
                                                ?.split(',') ??
                                                [])
                                              DialogUserTag(tag: tag),
                                          ],
                                        ),
                                      ),
                                    ),
                                  Gaps.v32,
                                  SizedBox(
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            '불호음식: ${state.userProfile.hateFood ?? '없음'}'),
                                        Gaps.v3,
                                        Text('선호음식: ${state.userProfile.taste ?? '없음'}'),
                                        Gaps.v3,
                                        Text(
                                            '선호장소: ${state.userProfile.preferArea ?? '없음'}'),
                                        Gaps.v3,
                                        Text('MBTI: ${state.userProfile.mbti ?? '비밀'}'),
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
                              onTap: () {
                                Navigator.of(context).pop();
                                if(widget.leftTap != null) {
                                  widget.leftTap();
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: Sizes.size52,
                                color: Colors.grey.shade300,
                                child: Text(
                                  widget.button1,
                                  style: const TextStyle(
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
                                Navigator.of(context).pop();
                                if(widget.rightTap != null) {
                                  widget.rightTap();
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: Sizes.size52,
                                color: Theme.of(context).primaryColor,
                                child: Text(
                                  widget.button2,
                                  style: const TextStyle(
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
              );
            }
          }
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
