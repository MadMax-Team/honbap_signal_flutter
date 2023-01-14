import 'package:flutter/material.dart';

class LoginBtnWidget extends StatelessWidget {
  const LoginBtnWidget({
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
      height: 50,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(borderRad),
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Container(
                      child: icon,
                    ),
                  )
                : Container(),
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
