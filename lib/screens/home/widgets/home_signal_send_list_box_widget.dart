import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';

class SignalSendListBox extends StatefulWidget {
  const SignalSendListBox({
    required this.applyedIdx,
    this.name,
    this.imgUri,
    required this.onTap,
    required this.deleteTap,
    super.key,
  });

  final int applyedIdx;
  final String? name;
  final String? imgUri;
  final Function() onTap;
  final Function() deleteTap;

  @override
  State<SignalSendListBox> createState() => _SignalListBox();
}

class _SignalListBox extends State<SignalSendListBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(173, 173, 173, 0.1),
                    blurRadius: 10.0,
                    spreadRadius: -2,
                    offset: Offset(0.0, 2.0), //(x,y)
                  )
                ]),
            child: SizedBox(
              width: double.infinity,
              child: SvgPicture.asset(
                'assets/icons/home_signal_list_box.svg',
                alignment: Alignment.center,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
              top: 0,
              bottom: 7,
              left: 0,
              right: 17,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Gaps.h11,
                      Container(
                        height: Sizes.size24,
                        width: Sizes.size24,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(125)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: widget.imgUri != null
                              ? Image.network(
                                  widget.imgUri!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset(
                                    'assets/icons/home_signal_list_box_user.png',
                                    alignment: Alignment.center,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Image.asset(
                                  'assets/icons/home_signal_list_box_user.png',
                                  alignment: Alignment.center,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Gaps.h16,
                      Text(
                        widget.name ?? '익명의 유저',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: Sizes.size14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CupertinoButton(
                        onPressed: widget.deleteTap,
                        minSize: 0.0,
                        padding: const EdgeInsets.fromLTRB(7, 2, 6, 3),
                        color: const Color(0xffFF4B26),
                        borderRadius: BorderRadius.circular(4),
                        child: const Text(
                          '요청취소',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: Sizes.size12,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }
}
