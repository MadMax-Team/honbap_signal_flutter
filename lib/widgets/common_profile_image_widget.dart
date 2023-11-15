import 'package:flutter/material.dart';

class CommonProfileImageWidget extends StatelessWidget {
  final String? profileImg;
  final double size;

  const CommonProfileImageWidget({
    super.key,
    this.profileImg,
    this.size = 32,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: profileImg == null
          ? CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              radius: size,
              backgroundImage: Image.asset(
                'assets/images/honbab_smile.png',
              ).image,
            )
          : Image.network(
              profileImg!,
              width: size * 2,
              height: size * 2,
              fit: BoxFit.fill,
            ),
    );
  }
}
