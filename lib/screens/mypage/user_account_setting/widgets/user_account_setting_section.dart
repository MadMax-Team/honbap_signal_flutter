import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';

class UserAccountSettingSection extends StatelessWidget {
  final String title;
  final String text;
  final List<Widget> children;

  const UserAccountSettingSection({
    super.key,
    required this.title,
    required this.text,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            width: Sizes.size1,
            color: Colors.grey.shade400,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: Sizes.size32,
          right: Sizes.size20,
          left: Sizes.size20,
          bottom: Sizes.size10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Gaps.v5,
            Text(
              text,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            Gaps.v20,
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) => children[index],
              separatorBuilder: (context, index) => Container(
                height: Sizes.size1,
                color: Colors.grey.shade300,
              ),
              itemCount: children.length,
            ),
          ],
        ),
      ),
    );
  }
}
