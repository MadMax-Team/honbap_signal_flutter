import 'package:flutter/cupertino.dart';

class MatchedUserTag extends StatelessWidget {
  const MatchedUserTag({required this.tag, Key? key}) : super(key: key);

  final String tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(7, 3, 5, 4),
      decoration: BoxDecoration(
          color: const Color(0xffF3F3F3),
          borderRadius: BorderRadius.circular(9.5)),
      child: Text(
        tag,
        style: const TextStyle(
            fontSize: 9, fontWeight: FontWeight.w500, color: Color(0xff5E5E5E)),
      ),
    );
  }
}
