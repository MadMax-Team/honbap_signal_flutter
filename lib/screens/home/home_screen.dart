import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:honbap_signal_flutter/widgets/home_screen/home_matched_state_widget.dart';
import 'package:honbap_signal_flutter/widgets/home_screen/home_signalbox_widget.dart';
import 'package:honbap_signal_flutter/widgets/home_screen/signal_on_dialog_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            color : Colors.black,
          ),
          color: Colors.black,
          onPressed: () {
            print('[home-Appbar] more button clicked');
          },
        )],
      ),
      body: SingleChildScrollView(
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
                      color: Colors.black
                  ),
                ),
                const SizedBox(height: 14),
                InkWell(
                  onTap: () => showDialog(context: context, builder: (_) => SignalOnDialog()),
                  child: const SignalBox(signal: false,),
                ),
                const SizedBox(height: 16),
                const Text(
                  ' *시그널을 켜두면 상대방이 나의 프로필을 확인할 수 있습니다. 시그널은 1시간 후 자동으로 꺼집니다',
                  style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff8E8E8E)
                  ),
                ),
                const SizedBox(height: 39),
                const Text(
                  '나의 매칭 상태',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
