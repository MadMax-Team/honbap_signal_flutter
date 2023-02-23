import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/apis/mypage/get_mypage_user_myinfo.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/models/mypage/mypage_user_myinfo_model.dart';
import 'package:honbap_signal_flutter/screens/mypage/match_history/match_history_screen.dart';
import 'package:honbap_signal_flutter/screens/mypage/widgets/mypage_menu_button_widget.dart';
import 'package:honbap_signal_flutter/screens/mypage/widgets/mypage_round_button_widget.dart';
import 'package:honbap_signal_flutter/screens/mypage/widgets/mypage_setting_button_widget.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  late Future<MyPageMyInfoModel> _getUserMyInfo;
  final _mannerTmp = 100;

  final _hSeperator = Container(
    color: Colors.grey.shade400,
    width: Sizes.size1,
    height: Sizes.size96,
  );

  @override
  void initState() {
    super.initState();
    _getUserMyInfo = getMyPageMyInfo();
  }

  void _onMatchHistoryTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MatchHistoryScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '마이페이지',
          style: TextStyle(
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w700,
          ),
        ),
        elevation: 0,
        centerTitle: false,
      ),
      body: FutureBuilder<MyPageMyInfoModel>(
        future: _getUserMyInfo,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: Sizes.size20,
                    right: Sizes.size20,
                    bottom: Sizes.size20,
                  ),
                  color: Theme.of(context).primaryColor,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: Sizes.size4,
                                color: Colors.white,
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
                                width: Sizes.size44 * 2,
                                height: Sizes.size44 * 2,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Gaps.v5,
                          Text(
                            '$_mannerTmp도',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: Sizes.size12,
                            ),
                          ),
                        ],
                      ),
                      Gaps.h20,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data!.userName,
                              maxLines: 1,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.size16 + Sizes.size2,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Gaps.v20,
                            Text(
                              snapshot.data!.email,
                              maxLines: 1,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.size12,
                              ),
                            ),
                            Gaps.v3,
                            Text(
                              snapshot.data!.birth
                                  .replaceAll('년', '.')
                                  .replaceAll('월', '.')
                                  .replaceAll('일', ''),
                              maxLines: 1,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.size12,
                              ),
                            ),
                            Gaps.v3,
                            const Text(
                              '주소인데 api에서 받아와야..',
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.size12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Gaps.v3,
                          MyPageRoundButton(
                            isTransparent: false,
                            text: '프로필 설정',
                          ),
                          Gaps.v16,
                          MyPageRoundButton(
                            isTransparent: true,
                            text: '계정관리',
                          ),
                          Gaps.v7,
                          MyPageRoundButton(
                            isTransparent: true,
                            text: '로그아웃',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const MyPageMenuButton(
                      imgLink: 'assets/icons/mypage_manner_temperature.png',
                      text: '매너온도',
                    ),
                    _hSeperator,
                    MyPageMenuButton(
                      imgLink: 'assets/icons/mypage_matching_history.png',
                      text: '매칭전적',
                      onTap: _onMatchHistoryTap,
                    ),
                    _hSeperator,
                    const MyPageMenuButton(
                      imgLink: 'assets/icons/mypage_signal_marker.png',
                      text: '시그널 마커',
                    ),
                    _hSeperator,
                    const MyPageMenuButton(
                      imgLink: 'assets/icons/mypage_badge.png',
                      text: '뱃지',
                    ),
                  ],
                ),
                Container(
                  color: Colors.grey.shade400,
                  width: double.infinity,
                  height: Sizes.size1,
                ),
                Gaps.v32,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '설정',
                        style: TextStyle(
                          fontSize: Sizes.size20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Gaps.v14,
                      Container(
                        padding: const EdgeInsets.all(Sizes.size10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: Sizes.size2,
                            color: const Color(0xffE1E1E1),
                          ),
                          borderRadius: BorderRadius.circular(Sizes.size10),
                        ),
                        child: Column(
                          children: const [
                            MyPageSettingButton(
                              imgLink: 'assets/icons/mypage_banned_list.png',
                              text: '차단 목록 관리',
                            ),
                            MyPageSettingButton(
                              imgLink:
                                  'assets/icons/mypage_notification_setting.png',
                              text: '알림 설정',
                            ),
                            MyPageSettingButton(
                              imgLink: 'assets/icons/mypage_announcement.png',
                              text: '화면 설정 - 색, 다크, 글자크기 조절',
                            ),
                            MyPageSettingButton(
                              imgLink: 'assets/icons/mypage_screen_setting.png',
                              text: '공지사항',
                            ),
                            MyPageSettingButton(
                              imgLink: 'assets/icons/mypage_send_opinion.png',
                              text: '의견보내기',
                              isLast: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return const Text('failed to load user data');
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
