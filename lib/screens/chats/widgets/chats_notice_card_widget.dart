import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/screens/chats/widgets/chats_notice_card_button.dart';

class ChatsNoticeCardWidget extends StatefulWidget {
  final Function()? onOpenTap;

  const ChatsNoticeCardWidget({
    super.key,
    this.onOpenTap,
  });

  @override
  State<ChatsNoticeCardWidget> createState() => _ChatsNoticeCardWidgetState();
}

class _ChatsNoticeCardWidgetState extends State<ChatsNoticeCardWidget> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isOpen = true;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: Sizes.size20,
          vertical: Sizes.size5,
        ),
        padding: const EdgeInsets.all(Sizes.size10),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(Sizes.size10),
          border: Border.all(color: Colors.grey.shade400),
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '매칭이 성사되었습니다! 시간이나 메뉴, 장소 등을 조율해 보세요.',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                if (!isOpen)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size5,
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: Sizes.size16,
                      color: Colors.grey.shade500,
                    ),
                  ),
              ],
            ),
            if (isOpen)
              Padding(
                padding: const EdgeInsets.only(top: Sizes.size10),
                child: Row(
                  children: [
                    ChatsNoticeCardButton(
                      text: '접어놓기',
                      isColor: false,
                      onTap: () {
                        setState(() {
                          isOpen = false;
                        });
                      },
                    ),
                    Gaps.h10,
                    ChatsNoticeCardButton(
                      text: '시그널 정보 입력',
                      isColor: true,
                      onTap: widget.onOpenTap,
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
