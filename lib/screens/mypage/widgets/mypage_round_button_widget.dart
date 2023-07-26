import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';

class MyPageRoundButton extends StatelessWidget {
  const MyPageRoundButton({
    super.key,
    required this.isTransparent,
    required this.text,
  });

  final bool isTransparent;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.size3,
        horizontal: Sizes.size10,
      ),
      width: Sizes.size80,
      decoration: BoxDecoration(
        color:
            isTransparent ? Colors.transparent : Theme.of(context).primaryColor,
        border: Border.all(
          width: 1,
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.circular(Sizes.size20),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color:
                isTransparent ? Theme.of(context).primaryColor : Colors.white,
            fontSize: Sizes.size12,
          ),
        ),
      ),
    );
  }
}
