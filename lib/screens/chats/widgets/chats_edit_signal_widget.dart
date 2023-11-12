import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';

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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Gaps.h40,
              const Text('시그널 글 작성'),
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
        ],
      ),
    );
  }
}
