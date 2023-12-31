import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/bloc/chat/chat_list/chat_list_bloc.dart';
import 'package:honbap_signal_flutter/bloc/chat/chat_list/chat_list_event.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';

class ChatsLeaveDialog extends StatelessWidget {
  final ChatListBloc chatListBloc;
  final String nickName;
  final String roomId;

  const ChatsLeaveDialog({
    super.key,
    required this.chatListBloc,
    required this.nickName,
    required this.roomId,
  });

  void _leaveChatRoom(BuildContext context) {
    chatListBloc.add(ChatLeaveEvent(roomId: roomId));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(Sizes.size7),
        ),
      ),
      contentPadding: const EdgeInsets.all(0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Gaps.v20,
          Text(
            nickName,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Gaps.v20,
          Text(
            '채팅방을 나가시겠습니까?',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Gaps.v12,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: Navigator.of(context).pop,
                  child: Container(
                    alignment: Alignment.center,
                    height: Sizes.size44,
                    child: Text(
                      '취소',
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: Sizes.size14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => _leaveChatRoom(context),
                  child: Container(
                    alignment: Alignment.center,
                    height: Sizes.size44,
                    child: Text(
                      '나가기',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: Sizes.size14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
