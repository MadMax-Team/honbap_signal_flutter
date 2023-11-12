import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/models/signal/signal_info_model.dart';

class SignalEditCard extends StatefulWidget {
  final Function(SignalInfoModel)? onChange;
  final SignalInfoModel? initSignal;

  const SignalEditCard({
    super.key,
    this.onChange,
    this.initSignal,
  });

  @override
  State<SignalEditCard> createState() => _SignalEditCardState();
}

class _SignalEditCardState extends State<SignalEditCard> {
  late SignalInfoModel _currentSignalInfo;

  @override
  void initState() {
    super.initState();
    _currentSignalInfo = widget.initSignal ?? const SignalInfoModel();
  }

  @override
  void didUpdateWidget(covariant SignalEditCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initSignal != widget.initSignal) {
      _currentSignalInfo = widget.initSignal ?? const SignalInfoModel();
    }
  }

  void _onTimeTap() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            use24hFormat: true,
            initialDateTime: _currentSignalInfo.sigPromiseTime != null
                ? DateTime.parse(_currentSignalInfo.sigPromiseTime!)
                : null,
            onDateTimeChanged: (DateTime newDuration) {
              setState(() {
                _currentSignalInfo = _currentSignalInfo.copyWith(
                  sigPromiseTime: newDuration.toString(),
                );
              });
            },
          ),
        ),
      ),
    );
  }

  String _hm(String? dateTimeStr) {
    if (dateTimeStr == null) return '시간을 정해주세요';
    var datetime = DateTime.parse(dateTimeStr);
    return '${datetime.hour} : ${datetime.minute}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade900,
        ),
        borderRadius: BorderRadius.circular(Sizes.size10),
      ),
      padding: const EdgeInsets.all(Sizes.size10),
      child: Column(
        children: [
          GestureDetector(
            onTap: _onTimeTap,
            behavior: HitTestBehavior.translucent,
            child: Row(
              children: [
                const SizedBox(
                  width: Sizes.size60,
                  child: Text('약속시간'),
                ),
                const Icon(
                  Icons.access_time,
                  color: Color(0xff737373),
                  size: Sizes.size20,
                ),
                Gaps.h10,
                Text(_hm(_currentSignalInfo.sigPromiseTime)),
              ],
            ),
          ),
          Gaps.v5,
          const Row(
            children: [
              SizedBox(
                width: Sizes.size60,
                child: Text('만날위치'),
              ),
              Icon(
                Icons.place,
                color: Color(0xff737373),
                size: Sizes.size20,
              ),
              Gaps.h10,
            ],
          ),
          Gaps.v5,
          const Row(
            children: [
              SizedBox(
                width: Sizes.size60,
                child: Text('메뉴'),
              ),
              Icon(
                Icons.restaurant_menu,
                color: Color(0xff737373),
                size: Sizes.size20,
              ),
              Gaps.h10,
            ],
          ),
        ],
      ),
    );
  }
}
