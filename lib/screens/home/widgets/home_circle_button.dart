import 'package:flutter/material.dart';

class HomeCircleButton extends StatelessWidget {
  final Function() onTap;

  const HomeCircleButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: 18,
        height: 18,
        decoration: const BoxDecoration(
          color: Color(0xFFFF4B26),
          shape: BoxShape.circle,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: const Center(
              child: Icon(
                Icons.clear,
                size: 15,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
