import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:honbap_signal_flutter/models/signal/signal_state_model.dart';
import 'package:honbap_signal_flutter/screens/home/widgets/home_matched_user_tag_widget.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';

class StateCard extends StatefulWidget {
  const StateCard({
    Key? key,
    required this.matchedInfo,
    this.url,
  }) : super(key: key);

  final SignalStateModel matchedInfo;
  final String? url;

  @override
  State<StateCard> createState() => _StateCardState();
}

class _StateCardState extends State<StateCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(14, 7, 14, 7),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(173, 173, 173, 0.2),
                blurRadius: 10.0,
                spreadRadius: -2,
                offset: Offset(0, 2),
              ),
            ],
            borderRadius: BorderRadius.circular(12), //모서리를 둥글게
          ),
          child: Row(
            children: [
              Container(
                height: Sizes.size48,
                width: Sizes.size48,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(125)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: widget.url != null
                  ? Image.network(
                    widget.url!,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                    'assets/icons/home_signal_list_box_user.png',
                    alignment: Alignment.center,
                    fit: BoxFit.fill,
                    ),
                  )
                  : Image.asset(
                    'assets/icons/home_signal_list_box_user.png',
                    alignment: Alignment.center,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Gaps.h16,
              Text(
                widget.matchedInfo.oppoNickName ?? '익명의 유저',
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontSize: Sizes.size18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ],
          ),
        ),
        Gaps.v9,
        Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: Container(
                height: Sizes.size96,
                padding: const EdgeInsets.fromLTRB(8, 11, 8, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      //그림자
                      color: Color.fromRGBO(173, 173, 173, 0.2),
                      blurRadius: 10.0,
                      spreadRadius: -2,
                      offset: Offset(0, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12), //모서리를 둥글게
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      '약속시간',
                      style: TextStyle(
                          fontSize: Sizes.size12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    Gaps.v4,
                    Expanded(
                      child: Center(
                        child: Text(
                          widget.matchedInfo.sigPromiseTime ?? '시간 정보 없음',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: Sizes.size12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gaps.h10,
            Flexible(
              fit: FlexFit.tight,
              child: Container(
                height: Sizes.size96,
                padding: const EdgeInsets.fromLTRB(0, 11, 0, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      //그림자
                      color: Color.fromRGBO(173, 173, 173, 0.2),
                      blurRadius: 10.0,
                      spreadRadius: -2,
                      offset: Offset(0, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12), //모서리를 둥글게
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      '만날장소',
                      style: TextStyle(
                          fontSize: Sizes.size12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    Gaps.v4,
                    Expanded(
                      child: Center(
                        child: Text(
                          widget.matchedInfo.sigPromiseArea ?? '장소 정보 없음',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: Sizes.size12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gaps.h10,
            Flexible(
              fit: FlexFit.tight,
              child: Container(
                height: Sizes.size96,
                padding: const EdgeInsets.fromLTRB(0, 11, 0, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      //그림자
                      color: Color.fromRGBO(173, 173, 173, 0.2),
                      blurRadius: 10.0,
                      spreadRadius: -2,
                      offset: Offset(0, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12), //모서리를 둥글게
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      '메뉴',
                      style: TextStyle(
                          fontSize: Sizes.size12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    Gaps.v4,
                    Expanded(
                      child: Center(
                        child: Text(
                          widget.matchedInfo.sigPromiseMenu ?? '메뉴 정보 없음',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: Sizes.size12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
