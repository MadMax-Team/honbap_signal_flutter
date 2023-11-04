import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/cubit/user_cubit.dart';
import 'package:honbap_signal_flutter/screens/mypage/match_history/match_history_screen.dart';
import 'package:honbap_signal_flutter/screens/mypage/widgets/mypage_menu_divider.dart';
import 'package:honbap_signal_flutter/screens/mypage/widgets/mypage_setting_button_widget.dart';
import 'package:honbap_signal_flutter/tools/push_new_screen.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  Widget _horizontalDivider() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: Sizes.size40),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: Sizes.size1,
            color: Colors.grey.shade300,
          ),
        ),
      ),
    );
  }

  void _onMatchHistoryTap(BuildContext context) {
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
        title: Text(
          '마이페이지',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: Sizes.size20,
                right: Sizes.size20,
                bottom: Sizes.size20,
              ),
              child: BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () =>
                        PushNewScreen.openUserAccount(context: context),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () =>
                              PushNewScreen.openUserProfile(context: context),
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: state.user?.userProfile?.profileImg ==
                                        null
                                    ? CircleAvatar(
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        radius: Sizes.size32,
                                        backgroundImage: Image.asset(
                                          'assets/images/honbab_smile.png',
                                        ).image,
                                      )
                                    : Image.network(
                                        state.user!.userProfile!.profileImg!,
                                        width: Sizes.size32 * 2,
                                        height: Sizes.size32 * 2,
                                        fit: BoxFit.fill,
                                      ),
                              ),
                              Container(
                                width: Sizes.size24,
                                height: Sizes.size24,
                                padding: const EdgeInsets.all(Sizes.size5),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius:
                                      BorderRadius.circular(Sizes.size20),
                                ),
                                child: const Icon(
                                  FontAwesomeIcons.pen,
                                  color: Colors.white,
                                  size: Sizes.size14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gaps.h20,
                        Expanded(
                          child: Text(
                            state.user?.userProfile?.nickName ?? 'N/A',
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: Sizes.size16 + Sizes.size2,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.grey.shade700,
                          size: Sizes.size16,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Column(
              children: [
                const MyPageMenuDivider(title: '매칭관리'),
                MyPageSettingButton(
                  imgLink: 'assets/icons/icon_match_history.png',
                  text: '매칭전적',
                  onTap: () => _onMatchHistoryTap(context),
                ),
                _horizontalDivider(),
                const MyPageSettingButton(
                  imgLink: 'assets/icons/icon_ban_list.png',
                  text: '차단 목록 관리',
                ),
                const MyPageMenuDivider(title: '설정'),
                const MyPageSettingButton(
                  imgLink: 'assets/icons/icon_notification.png',
                  text: '알림 설정',
                ),
                _horizontalDivider(),
                const MyPageSettingButton(
                  imgLink: 'assets/icons/icon_screen_bright.png',
                  text: '화면 설정',
                ),
                const MyPageMenuDivider(title: '설정'),
                const MyPageSettingButton(
                  imgLink: 'assets/icons/icon_notice.png',
                  text: '공지사항',
                ),
                _horizontalDivider(),
                const MyPageSettingButton(
                  imgLink: 'assets/icons/icon_mail.png',
                  text: '의견보내기',
                ),
                _horizontalDivider(),
                const MyPageSettingButton(
                  imgLink: 'assets/icons/icon_mail.png',
                  text: '개인정보 처리방침',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
