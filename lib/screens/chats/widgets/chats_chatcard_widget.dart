import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/models/chats/chat_list_model.dart';
import 'package:honbap_signal_flutter/tools/datetime_formatter.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    Key? key,
    required this.chat,
  }) : super(key: key);

  final ChatListModel chat;

  DateTime _strToDT(String sdt) {
    return DateTime.parse(sdt);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: Sizes.size72,
          color: Colors.white,
          padding: const EdgeInsets.only(right: Sizes.size10),
          child: Row(
            children: [
              Container(
                width: Sizes.size48,
                height: Sizes.size48,
                margin: const EdgeInsets.symmetric(horizontal: Sizes.size10),
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                // Image.network로 변경하면 됨
                child: Image.asset(
                  "assets/test/test_image.jpg",
                  fit: BoxFit.fill,
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    Gaps.v8,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          chat.userName ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: Sizes.size14,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          diffDatetime(_strToDT(chat.lastSendedAt!)),
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: Sizes.size10,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    Gaps.v7,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            chat.lastMessage ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: Sizes.size12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                        // if (chat.unreadMessages != 0)
                        //   Container(
                        //     width: Sizes.size16,
                        //     height: Sizes.size16,
                        //     margin: const EdgeInsets.only(left: Sizes.size10),
                        //     alignment: Alignment.center,
                        //     decoration: BoxDecoration(
                        //       shape: BoxShape.circle,
                        //       color: Theme.of(context).primaryColor,
                        //     ),
                        //     child: Text(
                        //       '${chat.unreadMessages}',
                        //       style: const TextStyle(
                        //         fontWeight: FontWeight.w400,
                        //         fontSize: Sizes.size10,
                        //         color: Colors.white,
                        //       ),
                        //     ),
                        //   )
                        // else
                        //   Container(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: Sizes.size3 / Sizes.size2,
          color: Colors.grey.shade200,
        ),
      ],
    );
  }
}
