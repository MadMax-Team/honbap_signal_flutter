import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/screens/chats/chat_list_screen.dart';

class RouteNavigationWidget extends StatefulWidget {
  const RouteNavigationWidget({super.key});

  @override
  State<RouteNavigationWidget> createState() => _RouteNavigationWidgetState();
}

class _RouteNavigationWidgetState extends State<RouteNavigationWidget> {
  int _currentIdx = 0;
  List<Widget> screens = [
    const Center(
      child: Text('home'),
    ),
    const Center(
      child: Text('info'),
    ),
    const Center(
      child: Text('location'),
    ),
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
            body: TabBarView(children: screens),
            bottomNavigationBar: SafeArea(
              child: TabBar(
                onTap: (value) => setState(() {
                  _currentIdx = value;
                }),
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
                    width: 3,
                  ),
                  insets: const EdgeInsets.only(bottom: 44),
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
