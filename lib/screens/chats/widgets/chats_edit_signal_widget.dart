import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/screens/common/signal_edit_card/signal_edit_card.dart';

class ChatsEditSignalWidget extends StatelessWidget {
  final Function()? onTapClose;

  const ChatsEditSignalWidget({
    super.key,
    this.onTapClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(Sizes.size20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: Sizes.size10,
            spreadRadius: Sizes.size2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Gaps.h40,
              Text(
                '시그널 글 작성',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(
                width: Sizes.size40,
                child: IconButton(
                  onPressed: onTapClose,
                  icon: const Icon(
                    Icons.close_sharp,
                  ),
                ),
              ),
            ],
          ),
          Gaps.v10,
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.size20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('조율 후 약속을 수정해주세요'),
                Gaps.v16,
                SignalEditCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
