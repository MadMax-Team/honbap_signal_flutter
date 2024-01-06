import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/bloc/home/get_signal_apply/home_signal_apply_bloc.dart';
import 'package:honbap_signal_flutter/bloc/home/get_signal_apply/home_signal_apply_event.dart';
import 'package:honbap_signal_flutter/bloc/home/get_signal_applyed/home_signal_applyed_bloc.dart';
import 'package:honbap_signal_flutter/bloc/home/get_signal_applyed/home_signal_applyed_event.dart';
import 'package:honbap_signal_flutter/bloc/signal/signal_state_bloc.dart';
import 'package:honbap_signal_flutter/bloc/signal/signal_state_event.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/cubit/fcm_cubit.dart';
import 'package:honbap_signal_flutter/cubit/user_cubit.dart';
import 'package:honbap_signal_flutter/models/signal/signal_state_model.dart';
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
  void initState() {
    super.initState();
    _refreshScreen();
  }

  void _refreshScreen() {
    context.read<SignalStateBloc>().add(SignalStateGetEvent());
    context.read<HomeSignalApplyedBloc>().add(HomeSignalApplyedGetEvent(
          jwt: context.read<UserCubit>().state.user!.jwt!,
        ));
    context.read<HomeSignalApplyBloc>().add(HomeSignalApplyGetEvent(
          jwt: context.read<UserCubit>().state.user!.jwt!,
        ));
  }

  void _updateSignalInfo(SignalStateModel incomeSignal) {
    context.read<SignalStateBloc>().add(SignalStateUpdateEvent(
          incomeSignal: incomeSignal,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FCMCubit, FCMState>(
      listener: (context, state) {
        if (state.data?.code == "10000") {
          _refreshScreen();
        }
        if (state.data?.code == '10001') {
          _refreshScreen();
        }
        if (state.data?.code == '10002') {
          _refreshScreen();
        }
        if (state.data?.code == '11001') {
          _updateSignalInfo(SignalStateModel.fromJson(jsonDecode(
            state.data!.message!,
          )));
        }
      },
      child: DefaultTabController(
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
                    overlayColor:
                        MaterialStatePropertyAll(Colors.grey.shade200),
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
      ),
    );
  }
}
