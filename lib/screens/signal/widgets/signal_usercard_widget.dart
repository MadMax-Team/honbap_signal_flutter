import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/screens/signal/widgets/signal_card_usertag_widget.dart';

class SignalUserCard extends StatelessWidget {
  const SignalUserCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Sizes.size16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: Sizes.size5,
            spreadRadius: Sizes.size2,
          ),
        ],
      ),
      child: ShaderMask(
        shaderCallback: (Rect rect) {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.transparent,
              Colors.purple,
            ],
            stops: [
              0.0,
              0.90,
              0.99,
            ], // 10% purple, 80% transparent, 10% purple
          ).createShader(rect);
        },
        blendMode: BlendMode.dstOut,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Gaps.v20,
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                // Image.network로 변경하면 됨
                child: Image.asset(
                  "assets/test/test_image.jpg",
                  width: Sizes.size80,
                  height: Sizes.size80,
                  fit: BoxFit.fill,
                ),
              ),
              Gaps.v7,
              const Text(
                '웅인데웅',
                style: TextStyle(
                  fontSize: Sizes.size14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gaps.v3,
              Text(
                '나와 400m   19분 전',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: Sizes.size9,
                ),
              ),
              Gaps.v5,
              Padding(
                padding: const EdgeInsets.all(Sizes.size7),
                child: SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: Sizes.size4,
                    runSpacing: Sizes.size4,
                    children: const <Widget>[
                      CardUserTag(tag: '양꼬치'),
                      CardUserTag(tag: '삼각지역'),
                      CardUserTag(tag: '반주사랑'),
                      CardUserTag(tag: '이구역토박이'),
                      CardUserTag(tag: '한식'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
