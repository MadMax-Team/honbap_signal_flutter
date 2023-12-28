import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/bloc/chat/chat_list/chat_list_bloc.dart';
import 'package:honbap_signal_flutter/bloc/chat/chat_list/chat_list_event.dart';
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
          Radius.circular(Sizes.size10),
        ),
      ),
      contentPadding: const EdgeInsets.all(0),
      contentTextStyle: TextStyle(
        fontSize: Sizes.size12,
        fontWeight: FontWeight.w400,
        color: Colors.grey.shade700,
      ),
      clipBehavior: Clip.hardEdge,
      content: SizedBox(
        width: MediaQuery.of(context).size.width - Sizes.size20,
        height: Sizes.size72 * 2,
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  '$nickName 님과의\n채팅을 나가시겠습니까?',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: Navigator.of(context).pop,
                    child: Container(
                      alignment: Alignment.center,
                      height: Sizes.size52,
                      color: Colors.grey.shade300,
                      child: const Text(
                        '취소',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _leaveChatRoom(context),
                    child: Container(
                      alignment: Alignment.center,
                      height: Sizes.size52,
                      color: Theme.of(context).primaryColor,
                      child: const Text(
                        '나가기',
                        style: TextStyle(
                          color: Colors.white,
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
      ),
    );
  }
}
