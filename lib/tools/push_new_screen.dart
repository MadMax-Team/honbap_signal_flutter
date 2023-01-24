import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/screens/chats/chat_room_screen.dart';

class PushNewScreen {
  static Route _createRoute(Widget widget) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static void openChatRoom({
    required String nickname,
    required String profileImage,
    required dynamic context,
  }) {
    Navigator.push(
      context,
      _createRoute(
        ChatRoomScreen(
          nickname: nickname,
          profileImage: profileImage,
        ),
      ),
    );
  }
}
