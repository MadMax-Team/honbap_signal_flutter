import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/bloc/home/get_signal_apply/home_signal_apply_bloc.dart';
import 'package:honbap_signal_flutter/bloc/home/get_signal_apply/home_signal_apply_event.dart';
import 'package:honbap_signal_flutter/bloc/signal/signal_state_event.dart';
import 'package:honbap_signal_flutter/bloc/signal/signal_state_state.dart';
import 'package:honbap_signal_flutter/repository/honbab/home/home_repository.dart';
import 'package:honbap_signal_flutter/screens/home/widgets/home_dialog/matched_save_dialog_widget.dart';
import 'package:honbap_signal_flutter/screens/home/widgets/home_dialog/signal_off_dialog_widget.dart';
import 'package:honbap_signal_flutter/screens/home/widgets/home_dialog/signal_on_dialog_second_widget.dart';
import 'package:honbap_signal_flutter/screens/home/widgets/home_dialog/signal_on_dialog_widget.dart';
import 'package:honbap_signal_flutter/screens/home/widgets/home_matched_state_widget.dart';
import 'package:honbap_signal_flutter/screens/home/widgets/home_signal_list_box_widget.dart';
import 'package:honbap_signal_flutter/screens/home/widgets/home_signal_send_list_box_widget.dart';
import 'package:honbap_signal_flutter/screens/home/widgets/home_signalbox_widget.dart';
import 'package:honbap_signal_flutter/screens/home/widgets/home_user_dialog/home_user_dialog_widget.dart';
import 'package:honbap_signal_flutter/screens/home/widgets/signal_process_dialog/signal_accept_dialog_widget.dart';
import 'package:honbap_signal_flutter/screens/home/widgets/signal_process_dialog/signal_delete_dialog_widget.dart';
import '../../bloc/home/get_signal_apply/home_signal_apply_state.dart';
import '../../bloc/home/get_signal_applyed/home_signal_applyed_bloc.dart';
import '../../bloc/home/get_signal_applyed/home_signal_applyed_event.dart';
import '../../bloc/home/get_signal_applyed/home_signal_applyed_state.dart';
import '../../bloc/signal/signal_state_bloc.dart';
import '../../bloc/signal/signal_user/signal_user_bloc.dart';
import '../../bloc/signal/signal_user/signal_user_event.dart';
import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../cubit/user_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  OverlayEntry? _overlayEntry;

  void _toggleLoadingOverlay(bool show) {
    if (show) {
      _overlayEntry = _createLoadingOverlay();
      Overlay.of(context)?.insert(_overlayEntry!);
    } else {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  OverlayEntry _createLoadingOverlay() {
    return OverlayEntry(
      builder: (context) => const Stack(
        children: [
          Positioned.fill(
            child: Material(
              color: Color(0xE6FFFFFF),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '시그널 상태를 변경중입니다.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0,
                    ),
                  ),
                  Gaps.v19,
                  Text(
                    '시그널이 on/off 되고 있으니 잠시만 기다려 주세요!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xff737373),
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                    ),
                  ),
                  Gaps.v14,
                  CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return BlocListener<SignalStateBloc, SignalStateState>(
      listener: (context, state) {
        if (state.state == SignalState.changing) {
          _toggleLoadingOverlay(true);
        } else {
          _toggleLoadingOverlay(false);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xffF5F6FA),
        appBar: AppBar(
          title: Image.asset(
            'assets/icons/home_name_logo.png',
            width: 120,
            height: 30,
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v7,
                SizedBox(
                  height: 30,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '시그널 온오프',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: Sizes.size18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      BlocBuilder<SignalStateBloc, SignalStateState>(
                        builder: (context, state) {
                          if (state.state == SignalState.signaling) {
                            return OutlinedButton(
                              onPressed: () {
                                if (context.read<SignalStateBloc>().state.state !=
                                    SignalState.matched) {
                                  showDialog(
                                    context: context,
                                    builder: (_) => SignalSecondDialog(
                                      parentContext: context,
                                      modify: true,
                                    ),
                                    barrierDismissible: false,
                                  );
                                }
                              },
                              style: OutlinedButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 12),
                                side: const BorderSide(
                                  width: 1,
                                  color: Color(0xFFFF4B26),
                                ),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              child: const Text(
                                "시그널 글 수정",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFFFF4B26),
                                ),
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Gaps.v11,
                GestureDetector(
                  onTap: () {
                    if (context.read<SignalStateBloc>().state.state ==
                        SignalState.matched) {
                      print('matched');
                      showDialog(
                      context: context,
                      builder: (_) => MatchedSaveDialog(parentContext: context),
                      barrierDismissible: false,
                      );
                    }
                    else if (context.read<SignalStateBloc>().state.state !=
                        SignalState.loading) {
                      if (context.read<SignalStateBloc>().state.state ==
                          SignalState.signaling) {
                        showDialog(
                          context: context,
                          builder: (_) => SignalOffDialog(parentContext: context),
                          barrierDismissible: false,
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (_) => SignalOnDialog(parentContext: context),
                          barrierDismissible: false,
                        );
                      }
                    }
                  },
                  child: BlocBuilder<SignalStateBloc, SignalStateState>(
                    builder: (context, state) {
                      if (state.state == SignalState.init) {
                        context
                            .read<SignalStateBloc>()
                            .add(SignalStateGetEvent());
                        return const SignalBox(
                          signal: false,
                        );
                      } else if (state.state == SignalState.signaling) {
                        print('onstate');
                        return const SignalBox(
                          signal: true,
                        );
                      } else if (state.state == SignalState.matched) {
                        print('matched');
                        return Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            const SignalBox(signal: false),
                            Container(
                              height: 130,
                              color: Colors.transparent,
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(
                                  '매칭된 상태입니다',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white.withOpacity(0.4),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      else if (state.state == SignalState.loading) {
                        return Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            const SignalBox(signal: false),
                            Container(
                              height: 130,
                              color: Colors.transparent,
                            ),
                          ],
                        );
                      }
                      else {
                        return const SignalBox(
                          signal: false,
                        );
                      }
                    },
                  ),
                ),
                Gaps.v16,
                const Text(
                  ' *시그널을 켜두면 상대방이 나의 프로필을 확인할 수 있습니다.',
                  style: TextStyle(
                    fontSize: Sizes.size9,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff8E8E8E),
                  ),
                ),
                const SizedBox(height: 39),
                const Text(
                  '나의 매칭 상태',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: Sizes.size18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Gaps.v11,
                BlocBuilder<SignalStateBloc, SignalStateState>(
                  builder: (context, state) {
                    if (state.state == SignalState.matched) {
                      return StateCard(
                        matchedInfo: state.signal,
                        onTap: () {
                          final signalUserStateBloc = context.read<SignalUserStateBloc>();
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return BlocProvider.value(
                                value: signalUserStateBloc,
                                child: HomeUserDialog(
                                  parentContext: context,
                                  userIdx: state.signal.oppoUserIdx!,
                                  button1: '매칭 취소',
                                  button2: '쪽지방으로',
                                  leftTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => MatchedSaveDialog(parentContext: context),
                                      barrierDismissible: false,
                                    );
                                  },
                                  rightTap: () {
                                    //TODO: move to 쪽지함
                                  },
                                ),
                              );
                            },
                            barrierDismissible: false,
                          );
                        },
                        url: "url", //TODO: require when get matched info
                      );
                    } else {
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(22, 18, 0, 18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              //그림자
                              color: Color.fromRGBO(173, 173, 173, 0.2),
                              blurRadius: 10.0,
                              spreadRadius: -2,
                              offset: Offset(0, 2),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          '매칭된 상대가 없습니다',
                          style: TextStyle(
                            fontSize: Sizes.size18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 34),
                const Text(
                  '나에게 온 시그널',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: Sizes.size18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Gaps.v11,
                BlocBuilder<HomeSignalApplyedBloc, HomeSignalApplyedState>(
                  builder: (context, state) {
                    if (state.status == HomeSignalApplyedStatus.init) {
                      context
                          .read<HomeSignalApplyedBloc>()
                          .add(HomeSignalApplyedGetEvent(
                            jwt: context.read<UserCubit>().state.user!.jwt!,
                          ));
                      return const Center(
                        child: SizedBox(
                          width: 21,
                          height: 21,
                          child: CircularProgressIndicator(
                            color: Color(0xffFF4B26),
                          ),
                        ),
                      );
                    }
                    if (state.status == HomeSignalApplyedStatus.success) {
                      if (state.signalApply.isEmpty) {
                        return GestureDetector(
                          onTap: () {
                            DefaultTabController.of(context)
                                .animateTo(2); //to SignalListScreen
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(22, 13, 0, 13),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  //그림자
                                  color: Color.fromRGBO(173, 173, 173, 0.2),
                                  blurRadius: 10.0,
                                  spreadRadius: -2,
                                  offset: Offset(0, 2),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(12), //모서리를 둥글게
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.add_circle,
                                  size: 21,
                                  color: Color(0xffff4b26),
                                ),
                                Gaps.h9,
                                Text(
                                  '시그널 찾기',
                                  style: TextStyle(
                                    fontSize: Sizes.size18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics:
                              const NeverScrollableScrollPhysics(), //scrollable off
                          itemCount: state.signalApply.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 47,
                              child: SignalListBox(
                                userIdx: state.signalApply[index].userIdx,
                                name: state.signalApply[index].nickName,
                                imgUri: state.signalApply[index].profileImg,
                                onTap: () {
                                  final signalUserStateBloc = context.read<SignalUserStateBloc>();
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext dialogContext) {
                                      return BlocProvider.value(
                                        value: signalUserStateBloc,
                                        child: HomeUserDialog(
                                            parentContext: context,
                                            userIdx: state.signalApply[index].userIdx,
                                          button1: '닫기',
                                          button2: '수락하기',
                                          rightTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (_) => SignalAcceptDialog(
                                                  parentContext: context,
                                                  userIdx: state.signalApply[index].userIdx,
                                                  nickname: state.signalApply[index].nickName
                                              ),
                                              barrierDismissible: false,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    barrierDismissible: false,
                                  );
                                },
                                acceptTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => SignalAcceptDialog(
                                        parentContext: context,
                                        userIdx: state.signalApply[index].userIdx,
                                        nickname: state.signalApply[index].nickName
                                    ),
                                    barrierDismissible: false,
                                  );
                                },
                                deleteTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => SignalDeleteDialog(
                                        parentContext: context,
                                        userIdx: state.signalApply[index].userIdx,
                                        nickname: state.signalApply[index].nickName,
                                        deleteTap: () {
                                          context.read<HomeSignalApplyedBloc>().add(
                                          HomeSignalApplyedDeleteEvent(
                                          jwt: context
                                              .read<UserCubit>()
                                              .state
                                              .user!
                                              .jwt!,
                                          userIdx: context
                                              .read<UserCubit>()
                                              .state
                                              .user!
                                              .userIdx!,
                                          applyedIdx:
                                          state.signalApply[index].userIdx,
                                          ),
                                        );
                                      }
                                    ),
                                    barrierDismissible: false,
                                  );
                                },
                              ),
                            );
                          },
                        );
                      }
                    }
                    if (state.status == HomeSignalApplyStatus.error) {
                      return Center(
                        child: Text(state.message ?? 'error'),
                      );
                    } else {
                      //else, loading
                      return const Center(
                        child: SizedBox(
                          width: 21,
                          height: 21,
                          child: CircularProgressIndicator(
                            color: Color(0xffFF4B26),
                          ),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 41),
                const Text(
                  '내가 보낸 요청',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: Sizes.size18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Gaps.v11,
                BlocBuilder<HomeSignalApplyBloc, HomeSignalApplyState>(
                  builder: (context, state) {
                    if (state.status == HomeSignalApplyStatus.init) {
                      context
                          .read<HomeSignalApplyBloc>()
                          .add(HomeSignalApplyGetEvent(
                            jwt: context.read<UserCubit>().state.user!.jwt!,
                          ));
                      return const Center(
                        child: SizedBox(
                          width: 21,
                          height: 21,
                          child: CircularProgressIndicator(
                            color: Color(0xffFF4B26),
                          ),
                        ),
                      );
                    }
                    if (state.status == HomeSignalApplyStatus.success) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics:
                            const NeverScrollableScrollPhysics(), //scrollable off
                        itemCount: state.signalApply.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 47,
                            child: SignalSendListBox(
                              applyedIdx: state.signalApply[index].applyedIdx,
                              name: state.signalApply[index].nickName,
                              imgUri: state.signalApply[index].profileImg,
                              onTap: () {
                                final signalUserStateBloc = context.read<SignalUserStateBloc>();
                                showDialog(
                                  context: context,
                                  builder: (BuildContext dialogContext) {
                                    return BlocProvider.value(
                                      value: signalUserStateBloc,
                                      child: HomeUserDialog(
                                        parentContext: context,
                                        userIdx: state.signalApply[index].applyedIdx,
                                        button1: '닫기',
                                        button2: '거절하기',
                                        rightTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (_) => SignalDeleteDialog(
                                                parentContext: context,
                                                userIdx: state.signalApply[index].applyedIdx,
                                                nickname: state.signalApply[index].nickName,
                                                deleteTap: () {
                                                  context.read<HomeSignalApplyBloc>().add(
                                                    HomeSignalApplyDeleteEvent(
                                                      jwt: context
                                                          .read<UserCubit>()
                                                          .state
                                                          .user!
                                                          .jwt!,
                                                      userIdx: context
                                                          .read<UserCubit>()
                                                          .state
                                                          .user!
                                                          .userIdx!,
                                                      applyedIdx:
                                                      state.signalApply[index].applyedIdx,
                                                    ),
                                                  );
                                                }
                                            ),
                                            barrierDismissible: false,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  barrierDismissible: false,
                                );
                              },
                              deleteTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => SignalDeleteDialog(
                                      parentContext: context,
                                      userIdx: state.signalApply[index].applyedIdx,
                                      nickname: state.signalApply[index].nickName,
                                      deleteTap: () {
                                        context.read<HomeSignalApplyBloc>().add(
                                          HomeSignalApplyDeleteEvent(
                                            jwt: context
                                                .read<UserCubit>()
                                                .state
                                                .user!
                                                .jwt!,
                                            userIdx: context
                                                .read<UserCubit>()
                                                .state
                                                .user!
                                                .userIdx!,
                                            applyedIdx:
                                            state.signalApply[index].applyedIdx,
                                          ),
                                        );
                                      }
                                  ),
                                  barrierDismissible: false,
                                );
                              },
                            ),
                          );
                        },
                      );
                    }
                    if (state.status == HomeSignalApplyStatus.error) {
                      return Center(
                        child: Text(state.message ?? 'error'),
                      );
                    } else {
                      //else, loading
                      return const Center(
                        child: SizedBox(
                          width: 21,
                          height: 21,
                          child: CircularProgressIndicator(
                            color: Color(0xffFF4B26),
                          ),
                        ),
                      );
                    }
                  },
                ),
                Gaps.v72,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
