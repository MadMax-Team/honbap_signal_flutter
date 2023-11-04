import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/models/chats/chat_model.dart';
import 'package:honbap_signal_flutter/tools/datetime_formatter.dart';

class ChatBox extends StatelessWidget {
  const ChatBox({
    super.key,
    required this.chat,
    required this.index,
    required this.profileImg,
    required this.isSended,
  });

  final List<ChatModel> chat;
  final int index;
  final String profileImg;
  final bool isSended;

  DateTime _strToDT(String sdt) {
    return DateTime.parse(sdt);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.size10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isSended)
            Container()
          else if (index == chat.length - 1 ||
              chat[index].userName != chat[index + 1].userName)
            Container(
              margin: const EdgeInsets.only(right: Sizes.size10),
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              // Image.network로 변경하면 됨
              child: Image.asset(
                "assets/test/test_image.jpg",
                width: Sizes.size48 + Sizes.size2,
                height: Sizes.size48 + Sizes.size2,
                fit: BoxFit.fill,
              ),
            )
          else
            Container(
              width: Sizes.size48 + Sizes.size2,
            ),
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isSended ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (isSended)
                  Container()
                else if (index == chat.length - 1 ||
                    chat[index].userName != chat[index + 1].userName)
                  Container(
                    margin: const EdgeInsets.only(bottom: Sizes.size3),
                    child: Text(
                      chat[index].userName ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: Sizes.size12,
                        color: Colors.black,
                      ),
                    ),
                  )
                else
                  Container(),
                Row(
                  mainAxisAlignment: isSended
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (isSended &&
                        (index == 0 ||
                            index == chat.length - 1 ||
                            diffDatetime(_strToDT(chat[index].sendAt!)) !=
                                diffDatetime(
                                    _strToDT(chat[index - 1].sendAt!)) ||
                            chat[index].userName != chat[index - 1].userName))
                      Container(
                        margin: const EdgeInsets.only(right: Sizes.size5),
                        child: Text(
                          diffDatetime(_strToDT(chat[index].sendAt!)),
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: Sizes.size10,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      )
                    else
                      Container(),
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.all(Sizes.size7),
                        margin: EdgeInsets.only(
                            left: isSended
                                ? 0
                                : (index == chat.length - 1 ||
                                        chat[index].userName !=
                                            chat[index + 1].userName)
                                    ? 0
                                    : Sizes.size10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizes.size10),
                          color: isSended
                              ? Theme.of(context).primaryColor
                              : Colors.grey.shade300,
                        ),
                        child: Text(
                          chat[index].text ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: Sizes.size14,
                            color: isSended ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    if (isSended)
                      Container()
                    else if (index == 0 ||
                        diffDatetime(_strToDT(chat[index].sendAt!)) !=
                            diffDatetime(_strToDT(chat[index - 1].sendAt!)) ||
                        chat[index].userName != chat[index - 1].userName)
                      Container(
                        margin: const EdgeInsets.only(left: Sizes.size5),
                        child: Text(
                          diffDatetime(_strToDT(chat[index].sendAt!)),
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: Sizes.size10,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      )
                    else
                      Container(),
                  ],
                ),
                Gaps.v10,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
