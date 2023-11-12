import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';

class ChatsNoticeCardButton extends StatelessWidget {
  final String text;
  final bool isColor;
  final Function()? onTap;

  const ChatsNoticeCardButton({
    super.key,
    required this.text,
    required this.isColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: Sizes.size5),
          decoration: BoxDecoration(
            color:
                isColor ? Theme.of(context).primaryColor : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(Sizes.size5),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
