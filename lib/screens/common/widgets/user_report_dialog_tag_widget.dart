import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';

class UserReportTag extends StatelessWidget {
  final String tag;

  const UserReportTag({
    super.key,
    required this.tag,
    required this.isSelected,
    this.onTap,
  });

  final bool isSelected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size7,
          horizontal: Sizes.size10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.size20),
          color: isSelected ? Theme.of(context).primaryColor : Colors.white,
          border: Border.all(
            width: Sizes.size1,
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.grey.shade300,
          ),
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: Sizes.size10,
            fontWeight: FontWeight.w400,
          ),
          child: Text(tag),
        ),
      ),
    );
  }
}
