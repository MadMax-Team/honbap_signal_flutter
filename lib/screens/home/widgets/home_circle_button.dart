import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeCircleButton extends StatelessWidget {
  const HomeCircleButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final onTap;

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
              child: const Center(
                child: Icon(
                  Icons.clear,
                  size: 15,
                  color: Colors.white,
                ),
              ),
              onTap: () async {
                if(onTap != null) {
                  onTap();
                }
              }
          ),
        ),
      ),
    );
  }
}