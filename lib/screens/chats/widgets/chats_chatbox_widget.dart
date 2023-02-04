import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/models/chats/chat_room_model.dart';
import 'package:honbap_signal_flutter/tools/datetime_formatter.dart';

class ChatBox extends StatelessWidget {
  const ChatBox({
    Key? key,
    required this.chat,
    required this.index,
    required this.profileImage,
    required this.isSended,
  }) : super(key: key);

  final List<ChatRoomModel> chat;
  final int index;
  final String profileImage;
  final bool isSended;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isSended
                ? Container()
                : (index == 0 ||
                        chat[index].nickname != chat[index - 1].nickname)
                    ? Container(
                        margin: const EdgeInsets.only(right: Sizes.size10),
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        // Image.network로 변경하면 됨
                        child: Image.asset(
                          "assets/test/$profileImage.jpg",
                          width: Sizes.size48 + Sizes.size2,
                          height: Sizes.size48 + Sizes.size2,
                          fit: BoxFit.fill,
                        ),
                      )
                    : Container(
                        width: Sizes.size48 + Sizes.size2,
                      ),
            Flexible(
              child: Column(
                crossAxisAlignment: isSended
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  isSended
                      ? Container()
                      : (index == 0 ||
                              chat[index].nickname != chat[index - 1].nickname)
                          ? Container(
                              margin:
                                  const EdgeInsets.only(bottom: Sizes.size3),
                              child: Text(
                                chat[index].nickname,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: Sizes.size12,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          : Container(),
                  Row(
                    mainAxisAlignment: isSended
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      isSended &&
                              (index == chat.length - 1 ||
                                  diffDatetime(chat[index].sendedAt) !=
                                      diffDatetime(chat[index + 1].sendedAt) ||
                                  chat[index].nickname !=
                                      chat[index + 1].nickname)
                          ? Container(
                              margin: const EdgeInsets.only(right: Sizes.size5),
                              child: Text(
                                diffDatetime(chat[index].sendedAt),
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: Sizes.size10,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            )
                          : Container(),
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.all(Sizes.size7),
                          margin: EdgeInsets.only(
                              left: isSended
                                  ? 0
                                  : (index == 0 ||
                                          chat[index].nickname !=
                                              chat[index - 1].nickname)
                                      ? 0
                                      : Sizes.size10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Sizes.size10),
                            color: isSended
                                ? Theme.of(context).primaryColor
                                : Colors.grey.shade300,
                          ),
                          child: Text(
                            chat[index].message,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: Sizes.size14,
                              color: isSended ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                      isSended
                          ? Container()
                          : (index == chat.length - 1 ||
                                  diffDatetime(chat[index].sendedAt) !=
                                      diffDatetime(chat[index + 1].sendedAt) ||
                                  chat[index].nickname !=
                                      chat[index + 1].nickname)
                              ? Container(
                                  margin:
                                      const EdgeInsets.only(left: Sizes.size5),
                                  child: Text(
                                    diffDatetime(chat[index].sendedAt),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: Sizes.size10,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                )
                              : Container(),
                    ],
                  ),
                  Gaps.v10,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
