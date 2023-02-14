import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';

class SignupDoubleCheckButton extends StatelessWidget {
  const SignupDoubleCheckButton({
    super.key,
    required this.isAvailable,
  });

  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: Sizes.size10),
      decoration: BoxDecoration(
        border: Border.all(
          width: Sizes.size1,
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.circular(Sizes.size5),
        color: isAvailable ? Theme.of(context).primaryColor : Colors.white,
      ),
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 200),
        style: TextStyle(
          color: isAvailable ? Colors.white : Theme.of(context).primaryColor,
          fontSize: Sizes.size14,
          fontWeight: FontWeight.w400,
        ),
        child: const Text(' 중복확인 '),
      ),
    );
  }
}
