import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';

class MyPageSettingButton extends StatelessWidget {
  const MyPageSettingButton({
    super.key,
    required this.imgLink,
    required this.text,
    this.isLast = false,
    this.onTap,
  });

  final String imgLink, text;
  final bool isLast;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Sizes.size40,
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size10),
        child: Row(
          children: [
            Gaps.h7,
            Image.asset(
              imgLink,
              color: Colors.black87,
            ),
            Gaps.h20,
            Expanded(
              child: Container(
                height: Sizes.size40,
                decoration: !isLast
                    ? const BoxDecoration(
                        border: BorderDirectional(
                          bottom: BorderSide(color: Color(0xffE1E1E1)),
                        ),
                      )
                    : const BoxDecoration(),
                alignment: Alignment.centerLeft,
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: Sizes.size14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
