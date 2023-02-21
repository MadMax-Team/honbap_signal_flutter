import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:honbap_signal_flutter/screens/home/widgets/home_dialog/signal_on_dialog_widget.dart';
import 'package:honbap_signal_flutter/screens/home/widgets/home_matched_state_widget.dart';
import 'package:honbap_signal_flutter/screens/home/widgets/home_signal_list_box_widget.dart';
import 'package:honbap_signal_flutter/screens/home/widgets/home_signalbox_widget.dart';

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
        title: SvgPicture.asset('assets/icons/home_name_logo.svg'),
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            color: Colors.black,
            onPressed: () {},
          )
        ],
      ),
      body: FutureBuilder<HomeListModel>(
        future: futureHomeListModel,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, //왼쪽 정렬
                  children: [
                    const SizedBox(height: 7),
                    const Text(
                      '시그널 온오프',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 14),
                    InkWell(
                      onTap: () => showDialog(
                          context: context,
                          builder: (_) => const SignalOnDialog(),
                          barrierDismissible: false),
                      child: SignalBox(
                        signal: snapshot.data!.signal!,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      ' *시그널을 켜두면 상대방이 나의 프로필을 확인할 수 있습니다. 시그널은 1시간 후 자동으로 꺼집니다',
                      style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff8E8E8E)),
                    ),
                    const SizedBox(height: 39),
                    const Text(
                      '나의 매칭 상태',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 11),
                    snapshot.data!.matchedInfo != null
                        ? StateCard(
                            matchedInfo: snapshot.data!.matchedInfo!,
                          )
                        : Container(
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
                                  BorderRadius.circular(12), //모서리를 둥글게
                            ),
                            child: const Text(
                              '매칭된 상대가 없습니다',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            )),
                    const SizedBox(height: 34),
                    const Text(
                      '나에게 온 시그널',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 11),
                    snapshot.data!.signalToMe!.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics:
                                const NeverScrollableScrollPhysics(), //scrollable off
                            itemCount: snapshot.data!.signalToMe!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                height: 47,
                                child: SignalListBox(
                                    name:
                                        snapshot.data!.signalToMe![index].name!,
                                    imgUri: snapshot
                                        .data!.signalToMe![index].image!),
                              );
                            },
                          )
                        : Container(
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
                            child: Row(
                              children: const [
                                Text(
                                  '시그널 찾기',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                )
                              ],
                            ),
                          ),
                    const SizedBox(height: 41),
                    const Text(
                      '내가 보낸 요청',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 11),
                    ListView.builder(
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(), //scrollable off
                      itemCount: snapshot.data!.signalRequest!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 47,
                          child: SignalListBox(
                              name: snapshot.data!.signalRequest![index].name!,
                              imgUri:
                                  snapshot.data!.signalRequest![index].image!),
                        );
                      },
                    )
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: SizedBox(
                height: 30.0,
                width: 30.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Color(0xffFF4B26)),
                  strokeWidth: 5.0,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
