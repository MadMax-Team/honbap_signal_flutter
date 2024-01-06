import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../../bloc/signal/signal_state_bloc.dart';
import '../../../bloc/signal/signal_state_state.dart';
import '../../../constants/gaps.dart';
import 'home_dialog/signal_off_dialog_widget.dart';
import 'home_dialog/signal_on_dialog_widget.dart';

class SignalBox extends StatefulWidget {
  const SignalBox({Key? key, required this.signal}) : super(key: key);

  final bool signal;

  @override
  State<SignalBox> createState() => _SignalBoxState();
}

class _SignalBoxState extends State<SignalBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(135, 135, 135, 0.2),
                  blurRadius: 10.0,
                  spreadRadius: 0.3,
                  offset: Offset(0.0, 5.0), //(x,y)
                )
              ]),
          child: SizedBox(
            width: double.infinity,
            child: SvgPicture.asset(
              'assets/icons/home_signal_box.svg',
              alignment: Alignment.center,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.signal)
                SvgPicture.asset('assets/icons/home_signal_box_off_trans.svg')
              else
                SvgPicture.asset('assets/icons/home_signal_box_off.svg'),
              Gaps.h11,
              FlutterSwitch(
                width: 105,
                height: 42,
                toggleSize: 35,
                activeColor: Colors.white,
                inactiveColor: Colors.white,
                toggleColor: const Color(0xffF8280B),
                value: widget.signal,
                padding: 3,
                onToggle: (value) {
                  if (context.read<SignalStateBloc>().state.state !=
                      SignalState.matched) {
                    if (context.read<SignalStateBloc>().state.state ==
                        SignalState.signaling) {
                      showDialog(
                        context: context,
                        builder: (_) => SignalOffDialog(parentContext: context),
                        barrierDismissible: false,
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (_) => SignalOnDialog(parentContext: context),
                        barrierDismissible: false,
                      );
                    }
                  }
                },
              ),
              Gaps.h15,
              if (widget.signal)
                SvgPicture.asset('assets/icons/home_signal_box_on.svg')
              else
                SvgPicture.asset('assets/icons/home_signal_box_on_trans.svg')
            ],
          ),
        ),
      ],
    );
  }
}
