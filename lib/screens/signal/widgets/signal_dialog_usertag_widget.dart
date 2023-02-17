import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';

class DialogUserTag extends StatelessWidget {
  final String tag;

  const DialogUserTag({
    super.key,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.size7,
        horizontal: Sizes.size10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size20),
        color: Colors.white,
        border: Border.all(
          width: Sizes.size3 / Sizes.size2,
          color: Colors.grey.shade300,
        ),
      ),
      child: Text(
        tag,
        style: const TextStyle(
          color: Colors.black,
          fontSize: Sizes.size12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
