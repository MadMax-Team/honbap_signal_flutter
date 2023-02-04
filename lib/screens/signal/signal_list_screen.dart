import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/screens/signal/signal_userprofile_dialog.dart';
import 'package:honbap_signal_flutter/screens/signal/widgets/signal_filtertag_widget.dart';
import 'package:honbap_signal_flutter/screens/signal/widgets/signal_usercard_widget.dart';

class SignalListScreen extends StatefulWidget {
  const SignalListScreen({super.key});

  @override
  State<SignalListScreen> createState() => _SignalListScreenState();
}

class _SignalListScreenState extends State<SignalListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '내 근처 시그널',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Gaps.v10,
          Row(
            children: [
              Expanded(
                child: ShaderMask(
                  shaderCallback: (Rect rect) {
                    return const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.purple,
                        Colors.transparent,
                        Colors.transparent,
                        Colors.purple
                      ],
                      stops: [
                        0.0,
                        0.01,
                        0.99,
                        1.0
                      ], // 10% purple, 80% transparent, 10% purple
                    ).createShader(rect);
                  },
                  blendMode: BlendMode.dstOut,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        Sizes.size14,
                        Sizes.size5,
                        0,
                        Sizes.size5,
                      ),
                      child: Row(
                        children: const [
                          FilterTag(tag: '인생선배'),
                          FilterTag(tag: '푸드파이터'),
                          FilterTag(tag: '이구역토박이'),
                          FilterTag(tag: '김치ㅁㄴㅇㅁㄴㅇ'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.filter_alt_sharp),
              ),
              Gaps.h4,
            ],
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(Sizes.size16),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: Sizes.size96 * 3,
                      mainAxisSpacing: Sizes.size20,
                      crossAxisSpacing: Sizes.size20,
                      childAspectRatio: 4 / 5,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return const SignalUserDialog();
                              },
                            );
                          },
                          child: const SignalUserCard(),
                        );
                      },
                      childCount: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
