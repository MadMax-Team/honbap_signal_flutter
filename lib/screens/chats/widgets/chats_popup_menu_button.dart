import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/screens/chats/chat_room_screen.dart';

class ChatsPopupMenuButton extends StatelessWidget {
  final Function(PopupItems)? onSelected;

  const ChatsPopupMenuButton({
    super.key,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: onSelected,
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
          enabled: false,
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
          enabled: false,
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
          enabled: false,
          child: Text(
            '차단',
            style: TextStyle(
              fontSize: Sizes.size14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
