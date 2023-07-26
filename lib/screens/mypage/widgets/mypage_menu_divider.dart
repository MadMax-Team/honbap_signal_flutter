import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';

class MyPageMenuDivider extends StatelessWidget {
  const MyPageMenuDivider({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Sizes.size10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.grey.shade400,
            width: double.infinity,
            height: Sizes.size1,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: Sizes.size10,
              left: Sizes.size20,
            ),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.grey.shade400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
