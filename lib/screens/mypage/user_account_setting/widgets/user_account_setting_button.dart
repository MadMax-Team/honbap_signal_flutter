import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';

class UserAccountSettingButton extends StatelessWidget {
  final String title;
  final String? value;
  final Function()? onTap;

  const UserAccountSettingButton({
    super.key,
    required this.title,
    this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Sizes.size16),
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title),
                  if (value != null)
                    Text(
                      value!,
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                ],
              ),
            ),
            if (onTap != null)
              const Padding(
                padding: EdgeInsets.only(left: Sizes.size16),
                child: Icon(
                  FontAwesomeIcons.chevronRight,
                  size: Sizes.size12,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
