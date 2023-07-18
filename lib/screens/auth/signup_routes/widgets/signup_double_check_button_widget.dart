import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';

class SignupDoubleCheckButton extends StatelessWidget {
  const SignupDoubleCheckButton({
    super.key,
    required this.isAvailable,
    this.isLoading = true,
  });

  final bool isAvailable;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: Sizes.size80,
      height: Sizes.size24,
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        border: Border.all(
          width: Sizes.size1,
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.circular(Sizes.size5),
        color: isAvailable ? Theme.of(context).primaryColor : Colors.white,
      ),
      child: Center(
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(
            color: isAvailable ? Colors.white : Theme.of(context).primaryColor,
            fontSize: Sizes.size14,
            fontWeight: FontWeight.w400,
          ),
          child: Text(isLoading ? '확인 중' : '중복확인'),
        ),
      ),
    );
  }
}
