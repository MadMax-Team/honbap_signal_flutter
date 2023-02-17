import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';

class MyPageMenuButton extends StatelessWidget {
  const MyPageMenuButton({
    super.key,
    required this.imgLink,
    required this.text,
    this.onTap,
  });

  final String imgLink, text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: Sizes.size96,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(imgLink),
                Gaps.v7,
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: Sizes.size14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
