import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/models/signal/signal_list_model.dart';
import 'package:honbap_signal_flutter/screens/signal/widgets/signal_card_usertag_widget.dart';
import 'package:honbap_signal_flutter/widgets/common_profile_image_widget.dart';

class SignalUserCard extends StatelessWidget {
  const SignalUserCard({
    super.key,
    required this.signal,
  });

  final SignalListModel signal;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: signal.checkSigWrite == 0
            ? Colors.white
            : Theme.of(context).primaryColor,
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
              CommonProfileImageWidget(
                profileImg: signal.profileImg,
                size: Sizes.size44,
              ),
              Gaps.v7,
              Text(
                signal.nickName ?? '',
                style: TextStyle(
                  fontSize: Sizes.size14,
                  fontWeight: FontWeight.w600,
                  color:
                      signal.checkSigWrite == 0 ? Colors.black : Colors.white,
                ),
              ),
              Gaps.v3,
              Text(
                '나와 ${signal.distance?.toStringAsFixed(1)}km',
                style: TextStyle(
                  color: signal.checkSigWrite == 0
                      ? Colors.grey.shade600
                      : Colors.white,
                  fontSize: Sizes.size9,
                ),
              ),
              Gaps.v5,
              Padding(
                padding: const EdgeInsets.all(Sizes.size10),
                child: SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: Sizes.size4,
                    runSpacing: Sizes.size4,
                    children: [
                      for (var tag in signal.interest?.split(',') ?? [])
                        CardUserTag(tag: tag),
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
