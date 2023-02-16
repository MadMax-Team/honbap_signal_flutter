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
    const Center(
      child: Text('signal'),
    ),
    const ChatListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
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
              child: TabBar(
                tabs: const [
                  Tab(
                    icon: Icon(
                      Icons.home_outlined,
                      color: Colors.black,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.person_outline,
                      color: Colors.black,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.location_on,
                      color: Colors.black,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.wifi_tethering_outlined,
                      color: Colors.black,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.chat_outlined,
                      color: Colors.black,
                    ),
                  ),
                ],
                labelColor: Theme.of(context).primaryColor,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: Sizes.size3,
                  ),
                  insets:
                      const EdgeInsets.only(bottom: Sizes.size44 + Sizes.size1),
                ),
                unselectedLabelColor: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
