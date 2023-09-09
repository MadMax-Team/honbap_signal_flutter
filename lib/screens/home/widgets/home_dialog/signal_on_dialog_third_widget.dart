import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:honbap_signal_flutter/bloc/home/signal_box_dialog/signal_box_dialog_bloc.dart';
import 'package:honbap_signal_flutter/bloc/home/signal_box_dialog/signal_box_dialog_event.dart';

import '../../../../bloc/home/signal_box_dialog/signal_box_dialog_state.dart';
import '../../../../constants/gaps.dart';
import '../../../../constants/sizes.dart';
import '../../../../cubit/user_cubit.dart';

class SignalThirdBox extends StatefulWidget {
  final String? time;
  final String? location;
  final String? favoriteFood;

  final BuildContext parentContext;

  const SignalThirdBox({super.key, this.time, this.location, this.favoriteFood, required this.parentContext});
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
                      fit: BoxFit.fill,
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
                    onTap: () {
                      if (widget.time != null) print('Time: ${widget.time}');
                      if (widget.location != null) print('Location: ${widget.location}');
                      if (widget.favoriteFood != null) print('Favorite Food: ${widget.favoriteFood}');
                      widget.parentContext.read<SignalBoxDialogBloc>().add(SendSignalDataEvent(jwt: context.read<UserCubit>().state.user!.jwt!, sigPromiseTime: widget.time, sigPromiseArea: widget.location, sigPromiseMenu: widget.favoriteFood));
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
