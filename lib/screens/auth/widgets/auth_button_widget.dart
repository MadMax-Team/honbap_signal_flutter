import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';

class AuthBtnWidget extends StatelessWidget {
  const AuthBtnWidget({
    Key? key,
    required this.title,
    required this.bgColor,
    required this.borderColor,
    required this.textColor,
    this.icon,
    this.borderRad = 7,
  }) : super(key: key);

  final String title;
  final Color bgColor, borderColor, textColor;
  final Image? icon;
  final double borderRad;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes.size52,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(borderRad),
        border: Border.all(
          color: borderColor,
          width: Sizes.size1,
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: Sizes.size5),
                child: Container(
                  child: icon,
                ),
              )
            else
              Container(),
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: Sizes.size14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
