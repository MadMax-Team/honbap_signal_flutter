import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/models/chats/chat_list_model.dart';
import 'package:honbap_signal_flutter/tools/datetime_formatter.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    Key? key,
    required this.chat,
  }) : super(key: key);

  final ChatListModel chat;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
          color: Colors.white,
          padding: const EdgeInsets.only(right: 10),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                // Image.network로 변경하면 됨
                child: Image.asset(
                  "assets/test/${chat.profileImage}.jpg",
                  fit: BoxFit.fill,
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          chat.nickname,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          diffDatetime(chat.laseSendedAt),
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            chat.lastMessage,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        chat.unreadMessages != 0
                            ? Container(
                                width: 15,
                                height: 15,
                                margin: const EdgeInsets.only(left: 10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).primaryColor,
                                ),
                                child: Text(
                                  '${chat.unreadMessages}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 1.5,
          color: Colors.grey[200],
        ),
      ],
    );
  }
}
