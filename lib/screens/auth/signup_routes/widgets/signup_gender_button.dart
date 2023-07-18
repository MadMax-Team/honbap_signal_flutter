import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';

class SignupGenderButton extends StatelessWidget {
  const SignupGenderButton({
    super.key,
    required this.text,
    required this.isSelected,
  });

  final String text;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: Sizes.size28,
      decoration: BoxDecoration(
        border: Border.all(
          width: Sizes.size1,
          color: isSelected
              ? Theme.of(context).primaryColor
              : Colors.grey.shade400,
        ),
      ),
      child: Center(
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.grey.shade400,
            fontSize: Sizes.size12,
          ),
          child: Text(text),
        ),
      ),
    );
  }
}
