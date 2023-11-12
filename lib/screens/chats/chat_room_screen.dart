import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/bloc/chat/chat_room/chat_room_bloc.dart';
import 'package:honbap_signal_flutter/bloc/chat/chat_room/chat_room_event.dart';
import 'package:honbap_signal_flutter/bloc/chat/chat_room/chat_room_state.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/cubit/user_cubit.dart';
import 'package:honbap_signal_flutter/screens/chats/widgets/chats_chatbox_widget.dart';
import 'package:honbap_signal_flutter/screens/chats/widgets/chats_notice_card_widget.dart';
import 'package:honbap_signal_flutter/screens/chats/widgets/chats_popup_menu_button.dart';
import 'package:honbap_signal_flutter/screens/chats/widgets/chats_sendbox_widget.dart';
import 'package:honbap_signal_flutter/screens/common/user_report_dialog.dart';

enum PopupItems { refresh, delete, declaration, block }

class ChatRoomScreen extends StatefulWidget {
  final String userName, profileImg;

  const ChatRoomScreen({
    super.key,
    required this.userName,
    required this.profileImg,
  });

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final ScrollController _scrollController = ScrollController();

  void _onPopupButtonSelected(PopupItems? value) {
    if (value == PopupItems.declaration) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const UserReportDialog();
        },
      );
    }
    if (value == PopupItems.refresh) {
      _charRefresh();
    }
  }

  void _charRefresh() {
    if (context.read<ChatRoomBloc>().state.status == ChatRoomStatus.loading) {
      return;
    }
    context.read<ChatRoomBloc>().add(ChatRoomGetEvent(
          jwt: context.read<UserCubit>().state.user!.jwt!,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          widget.userName,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.white,
        actions: [
          BlocBuilder<ChatRoomBloc, ChatRoomState>(
            builder: (context, state) {
              return IconButton(
                onPressed: _charRefresh,
                icon: state.status == ChatRoomStatus.loading
                    ? SizedBox(
                        width: Sizes.size20,
                        height: Sizes.size20,
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    : const Icon(
                        Icons.arrow_circle_down_outlined,
                        color: Colors.black,
                      ),
              );
            },
          ),
          ChatsPopupMenuButton(onSelected: _onPopupButtonSelected),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            const ChatsNoticeCardWidget(),
            Flexible(
              child: ShaderMask(
                shaderCallback: (Rect rect) {
                  return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.purple,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.purple
                    ],
                    stops: [
                      0.0,
                      0.01,
                      0.99,
                      1.0
                    ], // 10% purple, 80% transparent, 10% purple
                  ).createShader(rect);
                },
                blendMode: BlendMode.dstOut,
                child: BlocBuilder<ChatRoomBloc, ChatRoomState>(
                  buildWhen: (previous, current) =>
                      previous.chats != current.chats,
                  builder: (context, state) {
                    if (state.status == ChatRoomStatus.init) {
                      context.read<ChatRoomBloc>().add(ChatRoomGetEvent(
                            jwt: context.read<UserCubit>().state.user!.jwt!,
                          ));
                      return Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      );
                    }
                    if (state.status == ChatRoomStatus.loading &&
                        state.chats.isEmpty) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      );
                    }
                    if (state.status == ChatRoomStatus.error) {
                      return Center(
                        child: Text(state.message ?? 'error'),
                      );
                    }
                    return _buildBody(state);
                  },
                ),
              ),
            ),
            const ChatsSendboxWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(ChatRoomState state) {
    return CustomScrollView(
      controller: _scrollController,
      reverse: true,
      slivers: [
        const SliverToBoxAdapter(
          child: Gaps.v10,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ChatBox(
              chat: state.chats.reversed.toList(),
              index: index,
              profileImg: widget.profileImg,
              isSended: state.chats.reversed.toList()[index].userName !=
                  widget.userName,
            ),
            childCount: state.chats.length,
          ),
        ),
        const SliverToBoxAdapter(
          child: Gaps.v10,
        ),
      ],
    );
  }
}
