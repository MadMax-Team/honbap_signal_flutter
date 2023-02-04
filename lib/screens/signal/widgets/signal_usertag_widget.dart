import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';

class UserTag extends StatelessWidget {
  final String tag;

  const UserTag({
    Key? key,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.size7,
        horizontal: Sizes.size10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size20),
        color: Colors.grey.shade200,
      ),
      child: Text(
        tag,
        style: const TextStyle(
          fontSize: Sizes.size10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
