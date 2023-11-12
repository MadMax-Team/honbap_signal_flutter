import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_event.dart';
import 'package:honbap_signal_flutter/bloc/home/get_signal_apply/home_signal_apply_bloc.dart';
import 'package:honbap_signal_flutter/bloc/home/get_signal_apply/home_signal_apply_event.dart';
import 'package:honbap_signal_flutter/bloc/home/signal_box_dialog/signal_box_dialog_bloc.dart';
import 'package:honbap_signal_flutter/bloc/home/signal_box_dialog/signal_box_dialog_event.dart';
import 'package:honbap_signal_flutter/bloc/home/signal_box_dialog/signal_box_dialog_state.dart';
import 'package:honbap_signal_flutter/bloc/signal/signal_state_event.dart';
import 'package:honbap_signal_flutter/bloc/signal/signal_state_state.dart';
import 'package:honbap_signal_flutter/models/signal/signal_state_model.dart';
import 'package:honbap_signal_flutter/repository/honbab/home/location_repository.dart';
import 'package:honbap_signal_flutter/screens/auth/signup_routes/signup_userinfo_screen.dart';
import 'package:honbap_signal_flutter/screens/home/widgets/home_dialog/signal_off_dialog_widget.dart';
import 'package:honbap_signal_flutter/screens/home/widgets/home_dialog/signal_on_dialog_second_widget.dart';
import 'package:honbap_signal_flutter/screens/home/widgets/home_dialog/signal_on_dialog_widget.dart';
import 'package:honbap_signal_flutter/screens/home/widgets/home_matched_state_widget.dart';
import 'package:honbap_signal_flutter/screens/home/widgets/home_signal_list_box_widget.dart';
import 'package:honbap_signal_flutter/screens/home/widgets/home_signal_send_list_box_widget.dart';
import 'package:honbap_signal_flutter/screens/home/widgets/home_signalbox_widget.dart';
import 'package:honbap_signal_flutter/screens/routes/route_navigation_widget.dart';
import '../../bloc/home/get_signal_apply/home_signal_apply_state.dart';
import '../../bloc/home/get_signal_applyed/home_signal_applyed_bloc.dart';
import '../../bloc/home/get_signal_applyed/home_signal_applyed_event.dart';
import '../../bloc/home/get_signal_applyed/home_signal_applyed_state.dart';
import '../../bloc/signal/signal_state_bloc.dart';
import '../../bloc/signal/signal_state_state.dart';
import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../cubit/user_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        title: Image.asset(
            'assets/icons/home_name_logo.png',
          width: 120,
          height: 30,
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            color: Colors.black,
            onPressed: () {
              // TODO: something to click more button
            },
          )
        ],
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
                          color: Colors.black),
                    ),
                    BlocBuilder<SignalBoxDialogBloc, SignalBoxDialogState>(
                        builder: (context, state) {
                          if(state.status == SignalBoxDialogStatus.onState) {
                            return OutlinedButton(
                              onPressed: () {
                                if (context.read<SignalStateBloc>().state.state != SignalState.matched) {
                                  showDialog(
                                    context: context,
                                    builder: (_) => SignalSecondDialog(parentContext: context, modify: true),
                                    barrierDismissible: false,
                                  );
                                }
                              },
                              style: OutlinedButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
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
                        }
                    ),
                  ],
                ),
              ),
              Gaps.v11,
              GestureDetector(
                onTap: () {
                  if (context.read<SignalStateBloc>().state.state != SignalState.matched){
                    if (context.read<SignalBoxDialogBloc>().state.status == SignalBoxDialogStatus.onState){
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
                child: BlocBuilder<SignalBoxDialogBloc, SignalBoxDialogState>(
                  buildWhen: (pre, cur) {
                    return pre != cur;
                  },
                  builder: (context, state) {
                    if (state.status == SignalBoxDialogStatus.init) {
                      context.read<SignalBoxDialogBloc>().add(GetSignalStateEvent(
                        jwt: context.read<UserCubit>().state.user!.jwt!,
                        ),
                      );
                      return const SignalBox(
                        signal: false,
                      );
                    }
                    else if (state.status == SignalBoxDialogStatus.onState) {
                      BlocProvider.of<SignalStateBloc>(context).add(SignalStateOnEvent());
                      print('onstate');
                      return const SignalBox(
                        signal: true,
                      );
                    }
                    else {
                      if(state.status == SignalBoxDialogStatus.offState){
                        print('offState');
                        BlocProvider.of<SignalStateBloc>(context).add(SignalStateOffEvent());
                      }
                      else if(state.status == SignalBoxDialogStatus.loading){
                        print('loading');
                      }
                      return const SignalBox(
                        signal: false,
                      );
                    }
                  },
                ),
              ),
              Gaps.v16,
              const Text(
                ' *시그널을 켜두면 상대방이 나의 프로필을 확인할 수 있습니다. 시그널은 1시간 후 자동으로 꺼집니다',
                style: TextStyle(
                    fontSize: Sizes.size9,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff8E8E8E)),
              ),
              const SizedBox(height: 39),
              const Text(
                '나의 매칭 상태',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: Sizes.size18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              Gaps.v11,
              BlocBuilder<SignalStateBloc, SignalStateState>(
                buildWhen: (pre, cur) {
                  return pre != cur;
                },
                //처음 상태 받아오는게 필요함 not yet

                builder: (context, state) {
                  if(state.state == SignalState.matched) {
                    return StateCard(
                      matchedInfo: SignalStateModel( //test
                        oppoNickName: "닉네임",
                        sigPromiseTime: "2027-11-15 18:42:00",
                        sigPromiseArea: "장소",
                        sigPromiseMenu: "dd"
                      ),
                      url: "url",
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
                          borderRadius:
                          BorderRadius.circular(12),
                        ),
                        child: const Text(
                          '매칭된 상대가 없습니다',
                          style: TextStyle(
                              fontSize: Sizes.size18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        )
                    );
                  }
                }
              ),
              const SizedBox(height: 34),
              const Text(
                '나에게 온 시그널',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: Sizes.size18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              Gaps.v11,
              BlocBuilder<HomeSignalApplyedBloc, HomeSignalApplyedState>(
                buildWhen: (pre, cur) => pre.signalApply != cur.signalApply,
                builder: (context, state) {
                  if (state.status == HomeSignalApplyedStatus.init) {
                    context.read<HomeSignalApplyedBloc>().add(HomeSignalApplyedGetEvent(
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
                    if (state.signalApply.isEmpty){
                      return GestureDetector(
                        onTap: () {
                          DefaultTabController.of(context).animateTo(2); //to SignalListScreen
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
                            borderRadius:
                            BorderRadius.circular(12), //모서리를 둥글게
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
                                    color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                    else {
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
                                print('text click');
                              },
                              acceptTap: () {
                                context.read<HomeSignalApplyedBloc>().add(HomeSignalApplyedAcceptEvent(
                                    jwt: context.read<UserCubit>().state.user!.jwt!,
                                    matchedIdx: state.signalApply[index].userIdx,
                                ));
                              },
                              deleteTap: () {
                                context.read<HomeSignalApplyedBloc>().add(HomeSignalApplyedDeleteEvent(
                                  jwt: context.read<UserCubit>().state.user!.jwt!,
                                  userIdx: state.signalApply[index].userIdx,
                                  applyedIdx: context.read<UserCubit>().state.user!.userIdx!,
                                ));
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
                  }
                  else{ //else, loading
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
                    color: Colors.black),
              ),
              Gaps.v11,
              BlocBuilder<HomeSignalApplyBloc, HomeSignalApplyState>(
                buildWhen: (pre, cur) => pre.signalApply != cur.signalApply,
                builder: (context, state) {
                  if (state.status == HomeSignalApplyStatus.init) {
                    context.read<HomeSignalApplyBloc>().add(HomeSignalApplyGetEvent(
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
                                print('text click');
                              },
                              deleteTap: () {
                                context.read<HomeSignalApplyBloc>().add(HomeSignalApplyDeleteEvent(
                                  jwt: context.read<UserCubit>().state.user!.jwt!,
                                  userIdx: context.read<UserCubit>().state.user!.userIdx!,
                                  applyedIdx: state.signalApply[index].applyedIdx,
                                ));
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
                  }
                  else{ //else, loading
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
    );
  }
}
