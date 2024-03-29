import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/bloc/chat/chat_room/chat_room_bloc.dart';
import 'package:honbap_signal_flutter/bloc/signal/signal_state_bloc.dart';
import 'package:honbap_signal_flutter/cubit/user_cubit.dart';
import 'package:honbap_signal_flutter/cubit/user_profile_upload_cubit.dart';
import 'package:honbap_signal_flutter/cubit/user_pw_change_cubit.dart';
import 'package:honbap_signal_flutter/repository/honbab/chat/chat_room_repository.dart';
import 'package:honbap_signal_flutter/repository/honbab/user/user_profile_repository.dart';
import 'package:honbap_signal_flutter/screens/chats/chat_room_screen.dart';
import 'package:honbap_signal_flutter/screens/common/user_profile_setting/user_profile_setting_screen.dart';
import 'package:honbap_signal_flutter/screens/mypage/user_account_setting/user_account_setting_screen.dart';
import 'package:honbap_signal_flutter/screens/mypage/user_account_setting/user_password_change/user_password_change_screen.dart';

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

  static Future<void> openChatRoom({
    required String roomId,
    required String nickName,
    required String? profileImg,
    required dynamic context,
    SignalStateBloc? signalStateBloc,
  }) async {
    await Navigator.push(
      context,
      _createRoute(
        RepositoryProvider(
          create: (context) => ChatRoomRepository(),
          child: BlocProvider(
            create: (context) => ChatRoomBloc(
              chatRoomRepository: context.read<ChatRoomRepository>(),
              jwt: context.read<UserCubit>().state.user!.jwt!,
              roomId: roomId,
              applyedIdx: signalStateBloc?.state.signal.oppoUserIdx,
            ),
            child: ChatRoomScreen(
              roomId: roomId,
              nickName: nickName,
              profileImg: profileImg,
              signalStateBloc: signalStateBloc,
            ),
          ),
        ),
      ),
    );
  }

  static void openUserProfile({
    required dynamic context,
  }) {
    Navigator.push(
      context,
      _createRoute(
        RepositoryProvider(
          create: (context) => UserProfileRepository(),
          child: BlocProvider(
            create: (context) => UserProfileUploadCubit(
              userProfile: context.read<UserCubit>().state.user!.userProfile,
              userProfileRepository: context.read<UserProfileRepository>(),
            ),
            child: const UserProfileSettingScreen(),
          ),
        ),
      ),
    );
  }

  static void openUserAccount({
    required dynamic context,
  }) {
    Navigator.push(
      context,
      _createRoute(const UserAccountSettingScreen()),
    );
  }

  static void openUserPasswordChange({
    required dynamic context,
  }) {
    Navigator.push(
      context,
      _createRoute(RepositoryProvider(
        create: (context) => UserProfileRepository(),
        child: BlocProvider(
          create: (context) => UserPWChangeCubit(
            userProfileRepository: context.read<UserProfileRepository>(),
            userModel: context.read<UserCubit>().state.user!,
          ),
          child: const UserPasswordChangeScreen(),
        ),
      )),
    );
  }
}
