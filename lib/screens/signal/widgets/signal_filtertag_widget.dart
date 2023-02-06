import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';

class FilterTag extends StatelessWidget {
  final String tag;

  const FilterTag({
    Key? key,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: Sizes.size10),
      padding: const EdgeInsets.all(Sizes.size10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size20),
        color: Colors.grey.shade200,
      ),
      child: Text(tag),
    );
  }
}
