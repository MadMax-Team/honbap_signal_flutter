import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/bloc/signal/signal_state_bloc.dart';
import 'package:honbap_signal_flutter/bloc/signal/signal_state_event.dart';
import 'package:honbap_signal_flutter/models/signal/signal_info_model.dart';
import '../../../../constants/gaps.dart';
import '../../../../constants/sizes.dart';

class SignalThirdBox extends StatefulWidget {
  final DateTime? time;
  final String? location;
  final String? favoriteFood;

  final BuildContext parentContext;

  const SignalThirdBox(
      {super.key,
      this.time,
      this.location,
      this.favoriteFood,
      required this.parentContext});
  @override
  State<SignalThirdBox> createState() => _SignalThirdBoxState();
}

class _SignalThirdBoxState extends State<SignalThirdBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFFFFFFFF),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(7.0)),
      ),
      contentPadding: const EdgeInsets.all(0),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Gaps.v35,
            Container(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: Column(
                children: [
                  SizedBox(
                    width: Sizes.size96,
                    height: Sizes.size96,
                    child: Image.asset(
                      'assets/icons/home_signal_box_dialog.png',
                      alignment: Alignment.center,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Gaps.v10,
                  const Text(
                    '시그널 on 상태가 되었습니다',
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Gaps.v6,
                  const Text(
                    textAlign: TextAlign.center,
                    '매칭 상대가 나타나지 않으면 1시간 이후 자동으로 Off됩니다',
                    style: TextStyle(
                      fontSize: Sizes.size12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff737373),
                    ),
                  ),
                  Gaps.v25,
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      widget.parentContext
                          .read<SignalStateBloc>()
                          .add(SignalStateOnEvent(
                            signalInfo: SignalInfoModel(
                              sigPromiseTime: widget.time,
                              sigPromiseArea: widget.location,
                              sigPromiseMenu: widget.favoriteFood,
                            ),
                          ));
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.zero, bottom: Radius.circular(7)),
                        color: Color(0xffF35928),
                      ),
                      alignment: Alignment.center,
                      height: Sizes.size46,
                      width: double.maxFinite,
                      child: const Text(
                        '확인',
                        style: TextStyle(
                          fontSize: Sizes.size14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
