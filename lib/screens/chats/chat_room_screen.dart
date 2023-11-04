import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/bloc/chat/chat_room/chat_room_bloc.dart';
import 'package:honbap_signal_flutter/bloc/chat/chat_room/chat_room_event.dart';
import 'package:honbap_signal_flutter/bloc/chat/chat_room/chat_room_state.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/cubit/user_cubit.dart';
import 'package:honbap_signal_flutter/screens/chats/widgets/chats_chatbox_widget.dart';
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
      if (context.read<ChatRoomBloc>().state.status == ChatRoomStatus.loading) {
        return;
      }
      context.read<ChatRoomBloc>().add(ChatRoomGetEvent(
            jwt: context.read<UserCubit>().state.user!.jwt!,
          ));
    }
  }

  void _scrollToBottom() {
    if (context.read<ChatRoomBloc>().state.status != ChatRoomStatus.success) {
      return;
    }
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
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
          IconButton(
            onPressed: _scrollToBottom,
            icon: const Icon(
              Icons.arrow_circle_down_outlined,
              color: Colors.black,
            ),
          ),
          PopupMenuButton(
            onSelected: _onPopupButtonSelected,
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: Sizes.size3 / 2,
                color: Colors.grey.shade300,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            ),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: PopupItems.refresh,
                child: Text(
                  '새로고침',
                  style: TextStyle(
                    fontSize: Sizes.size14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const PopupMenuItem(
                value: PopupItems.delete,
                child: Text(
                  '대화삭제',
                  style: TextStyle(
                    fontSize: Sizes.size14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const PopupMenuItem(
                value: PopupItems.declaration,
                child: Text(
                  '신고',
                  style: TextStyle(
                    fontSize: Sizes.size14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const PopupMenuItem(
                value: PopupItems.block,
                child: Text(
                  '차단',
                  style: TextStyle(
                    fontSize: Sizes.size14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
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
                              isSended: state.chats.reversed
                                      .toList()[index]
                                      .userName !=
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
                  },
                ),
              ),
            ),
            Container(
              height: Sizes.size48,
              margin: const EdgeInsets.fromLTRB(
                Sizes.size10,
                0,
                Sizes.size10,
                Sizes.size24,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Sizes.size24),
                boxShadow: [
                  BoxShadow(
                    blurRadius: Sizes.size5,
                    spreadRadius: Sizes.size1,
                    color: Colors.grey.shade400,
                  ),
                ],
                color: Colors.white,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.add,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Container(
                    width: Sizes.size1,
                    height: Sizes.size28,
                    color: Colors.grey.shade300,
                  ),
                  Expanded(
                    child: Container(
                      margin:
                          const EdgeInsets.symmetric(horizontal: Sizes.size10),
                      child: const Text('input'),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _scrollToBottom();
                    },
                    icon: Icon(
                      Icons.arrow_circle_right,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
