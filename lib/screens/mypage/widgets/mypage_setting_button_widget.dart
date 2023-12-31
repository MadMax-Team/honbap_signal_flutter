import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';

class MyPageSettingButton extends StatelessWidget {
  const MyPageSettingButton({
    super.key,
    required this.imgLink,
    required this.text,
    this.onTap,
  });

  final String imgLink, text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size44,
          vertical: Sizes.size10,
        ),
        child: Row(
          children: [
            Image.asset(
              imgLink,
              width: Sizes.size24,
              color: onTap != null ? null : Colors.grey.shade400,
            ),
            Gaps.h20,
            Expanded(
              child: Container(
                height: Sizes.size40,
                alignment: Alignment.centerLeft,
                child: Text(
                  text,
                  style: TextStyle(
                    color: onTap != null
                        ? Colors.grey.shade700
                        : Colors.grey.shade400,
                    fontSize: Sizes.size16,
                  ),
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color:
                  onTap != null ? Colors.grey.shade700 : Colors.grey.shade400,
              size: Sizes.size16,
            ),
          ],
        ),
      ),
    );
  }
}
