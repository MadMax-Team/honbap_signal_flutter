import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/screens/chats/chat_list_screen.dart';
import 'package:honbap_signal_flutter/screens/home/home_screen.dart';
import 'package:honbap_signal_flutter/screens/mypage/mypage_screen.dart';
import 'package:honbap_signal_flutter/screens/signal/signal_list_screen.dart';

class RouteNavigationWidget extends StatefulWidget {
  const RouteNavigationWidget({super.key});

  @override
  State<RouteNavigationWidget> createState() => _RouteNavigationWidgetState();
}

class _RouteNavigationWidgetState extends State<RouteNavigationWidget> {
  List<Widget> screens = [
    const HomeScreen(),
    const MyPageScreen(),
    const SignalListScreen(),
    const ChatListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Stack(
        children: [
          const SizedBox(
            width: double.infinity,
            height: double.infinity,
          ),
          Scaffold(
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: screens,
            ),
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
                child: TabBar(
                  tabs: [
                    Tab(
                      icon: Image.asset(
                        'assets/icons/route_home.png',
                        width: Sizes.size28,
                        height: Sizes.size28,
                      ),
                    ),
                    Tab(
                      icon: Image.asset(
                        'assets/icons/route_mypage.png',
                        width: Sizes.size28,
                        height: Sizes.size28,
                      ),
                    ),
                    Tab(
                      icon: Image.asset(
                        'assets/icons/route_signal.png',
                        width: Sizes.size28,
                        height: Sizes.size28,
                      ),
                    ),
                    Tab(
                      icon: Image.asset(
                        'assets/icons/route_chats.png',
                        width: Sizes.size28,
                        height: Sizes.size28,
                      ),
                    ),
                  ],
                  labelColor: Theme.of(context).primaryColor,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: Sizes.size3,
                    ),
                    insets: const EdgeInsets.only(
                        bottom: Sizes.size44 + Sizes.size1),
                  ),
                  unselectedLabelColor: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
