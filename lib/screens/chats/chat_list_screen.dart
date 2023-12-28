import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/bloc/chat/chat_list/chat_list_bloc.dart';
import 'package:honbap_signal_flutter/bloc/chat/chat_list/chat_list_event.dart';
import 'package:honbap_signal_flutter/bloc/chat/chat_list/chat_list_state.dart';
import 'package:honbap_signal_flutter/bloc/signal/signal_state_bloc.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/screens/chats/widgets/chats_chatcard_widget.dart';
import 'package:honbap_signal_flutter/screens/chats/widgets/chats_leave_dialog.dart';
import 'package:honbap_signal_flutter/tools/push_new_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '쪽지함',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.white,
      ),
      body: BlocBuilder<ChatListBloc, ChatListState>(
        buildWhen: (previous, current) =>
            previous.chatrooms != current.chatrooms,
        builder: (context, state) {
          if (state.status == ChatListStatus.init) {
            context.read<ChatListBloc>().add(ChatListGetEvent());
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          }
          if (state.status == ChatListStatus.loading &&
              state.chatrooms.isEmpty) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          }
          if (state.status == ChatListStatus.error) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.message ?? 'error'),
                  Gaps.v20,
                  TextButton(
                    onPressed: () {
                      context.read<ChatListBloc>().add(ChatListGetEvent());
                    },
                    child: const Text('다시 시도하기'),
                  ),
                ],
              ),
            );
          }
          return SmartRefresher(
            controller: _refreshController,
            onRefresh: () {
              context.read<ChatListBloc>().add(ChatListGetEvent());
              _refreshController.refreshCompleted();
            },
            onLoading: () {
              _refreshController.loadComplete();
            },
            child: CustomScrollView(
              slivers: [
                for (var chat in state.chatrooms)
                  SliverToBoxAdapter(
                    child: GestureDetector(
                      onTap: () => PushNewScreen.openChatRoom(
                        roomId: chat.roomId!,
                        nickName: chat.nickName!,
                        profileImg: chat.profileImg!,
                        context: context,
                        signalStateBloc: context.read<SignalStateBloc>(),
                      ),
                      onLongPress: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context_) {
                            return ChatsLeaveDialog(
                              chatListBloc: context.read<ChatListBloc>(),
                              roomId: chat.roomId!,
                              nickName: chat.nickName!,
                            );
                          },
                        );
                      },
                      child: ChatCard(chat: chat),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
