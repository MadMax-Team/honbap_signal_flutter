import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_event.dart';
import 'package:honbap_signal_flutter/bloc/home/get_signal_apply/home_signal_apply_bloc.dart';
import 'package:honbap_signal_flutter/bloc/home/get_signal_apply/home_signal_apply_event.dart';
import 'package:honbap_signal_flutter/screens/home/widgets/home_dialog/signal_on_dialog_widget.dart';
import 'package:honbap_signal_flutter/screens/home/widgets/home_matched_state_widget.dart';
import 'package:honbap_signal_flutter/screens/home/widgets/home_signal_list_box_widget.dart';
import 'package:honbap_signal_flutter/screens/home/widgets/home_signalbox_widget.dart';
import '../../bloc/home/get_signal_apply/home_signal_apply_state.dart';
import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../cubit/user_cubit.dart';
import '../../models/home/home_list_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<HomeListModel> futureHomeListModel;

  @override
  void initState() {
    super.initState();
    futureHomeListModel = fetchHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        title: Image.asset('assets/icons/home_name_logo_txt.png'),
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
              // TODO: for test
              context
                  .read<AuthenticationBloc>()
                  .add(const AuthenticationLogout());
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, //왼쪽 정렬
            children: [
              Gaps.v7,
              const Text(
                '시그널 온오프',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: Sizes.size18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              Gaps.v14,
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => const SignalOnDialog(),
                    barrierDismissible: false
                  );
                },
                child: SignalBox(
                  signal: false,
                  //signal: snapshot.data!.signal!,
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
              // snapshot.data!.matchedInfo != null
              //     ? StateCard(
              //         matchedInfo: snapshot.data!.matchedInfo!,
              //       )
              //     : Container(
              //         width: double.infinity,
              //         padding: const EdgeInsets.fromLTRB(22, 18, 0, 18),
              //         decoration: BoxDecoration(
              //           color: Colors.white,
              //           boxShadow: const [
              //             BoxShadow(
              //               //그림자
              //               color: Color.fromRGBO(173, 173, 173, 0.2),
              //               blurRadius: 10.0,
              //               spreadRadius: -2,
              //               offset: Offset(0, 2),
              //             ),
              //           ],
              //           borderRadius:
              //               BorderRadius.circular(12), //모서리를 둥글게
              //         ),
              //         child: const Text(
              //           '매칭된 상대가 없습니다',
              //           style: TextStyle(
              //               fontSize: Sizes.size18,
              //               fontWeight: FontWeight.w500,
              //               color: Colors.black),
              //         )),
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
                    //print() //jwt 출력해보기 test
                    //나머지 다 띄우기
                    if (state.signalApply.isEmpty){
                      return Container(
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
                            Text(
                              '시그널 찾기',
                              style: TextStyle(
                                  fontSize: Sizes.size18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            )
                          ],
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
                              name:
                              state.signalApply[index].nickName!,
                              imgUri: state.signalApply[index].nickName!,
                            ),//snapshot.data!.signalToMe![index].image!),
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
              // snapshot.data!.signalToMe!.isNotEmpty
              //     ? ListView.builder(
              //         shrinkWrap: true,
              //         physics:
              //             const NeverScrollableScrollPhysics(), //scrollable off
              //         itemCount: snapshot.data!.signalToMe!.length,
              //         itemBuilder: (BuildContext context, int index) {
              //           return SizedBox(
              //             height: 47,
              //             child: SignalListBox(
              //                 name:
              //                     snapshot.data!.signalToMe![index].name!,
              //                 imgUri: snapshot
              //                     .data!.signalToMe![index].image!),
              //           );
              //         },
              //       )
              //     : Container(
              //         width: double.infinity,
              //         padding: const EdgeInsets.fromLTRB(22, 13, 0, 13),
              //         decoration: BoxDecoration(
              //           color: Colors.white,
              //           boxShadow: const [
              //             BoxShadow(
              //               //그림자
              //               color: Color.fromRGBO(173, 173, 173, 0.2),
              //               blurRadius: 10.0,
              //               spreadRadius: -2,
              //               offset: Offset(0, 2),
              //             ),
              //           ],
              //           borderRadius:
              //               BorderRadius.circular(12), //모서리를 둥글게
              //         ),
              //         child: const Row(
              //           children: [
              //             Text(
              //               '시그널 찾기',
              //               style: TextStyle(
              //                   fontSize: Sizes.size18,
              //                   fontWeight: FontWeight.w500,
              //                   color: Colors.black),
              //             )
              //           ],
              //         ),
              //       ),
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
              // ListView.builder(
              //   shrinkWrap: true,
              //   physics:
              //       const NeverScrollableScrollPhysics(), //scrollable off
              //   itemCount: snapshot.data!.signalRequest!.length,
              //   itemBuilder: (BuildContext context, int index) {
              //     return SizedBox(
              //       height: 47,
              //       child: SignalListBox(
              //           name: snapshot.data!.signalRequest![index].name!,
              //           imgUri:
              //               snapshot.data!.signalRequest![index].image!),
              //     );
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }
}
