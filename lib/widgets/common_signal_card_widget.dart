import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/models/signal/signal_info_model.dart';

class CommonSignalCardWidget extends StatefulWidget {
  final Function(SignalInfoModel)? onChange;
  final SignalInfoModel? initSignal;
  final bool isBorder;
  final bool isEditable;
  final Color primaryColor;

  const CommonSignalCardWidget({
    super.key,
    this.onChange,
    this.initSignal,
    this.isBorder = true,
    this.isEditable = false,
    this.primaryColor = const Color(0xFF212121),
  });

  @override
  State<CommonSignalCardWidget> createState() => _CommonSignalCardWidgetState();
}

class _CommonSignalCardWidgetState extends State<CommonSignalCardWidget> {
  late SignalInfoModel _currentSignalInfo;

  @override
  void initState() {
    super.initState();
    _currentSignalInfo = widget.initSignal ?? const SignalInfoModel();
  }

  @override
  void didUpdateWidget(covariant CommonSignalCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initSignal != widget.initSignal) {
      _currentSignalInfo = widget.initSignal ?? const SignalInfoModel();
    }
  }

  void _onDateTimeChange(DateTime datetime) {
    setState(() {
      _currentSignalInfo = _currentSignalInfo.copyWith(
        sigPromiseTime: datetime,
      );
    });

    if (widget.onChange != null) {
      widget.onChange!(_currentSignalInfo);
    }
  }

  void _onLocationChange(String location) {
    setState(() {
      _currentSignalInfo = _currentSignalInfo.copyWith(
        sigPromiseArea: location,
      );
    });

    if (widget.onChange != null) {
      widget.onChange!(_currentSignalInfo);
    }
  }

  void _onMenuChange(String menu) {
    setState(() {
      _currentSignalInfo = _currentSignalInfo.copyWith(
        sigPromiseMenu: menu,
      );
    });

    if (widget.onChange != null) {
      widget.onChange!(_currentSignalInfo);
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
            initialDateTime: _currentSignalInfo.sigPromiseTime,
            onDateTimeChanged: _onDateTimeChange,
          ),
        ),
      ),
    );
  }

  String _hm(DateTime? dateTime) {
    if (dateTime == null) return '시간을 정해주세요';
    return '${dateTime.hour.toString().padLeft(2, "0")} : ${dateTime.minute.toString().padLeft(2, "0")}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: widget.isBorder
            ? Border.all(
                color: widget.primaryColor,
              )
            : null,
        borderRadius: BorderRadius.circular(Sizes.size10),
      ),
      padding: widget.isBorder
          ? const EdgeInsets.symmetric(
              horizontal: Sizes.size20,
              vertical: Sizes.size10,
            )
          : null,
      child: Column(
        children: [
          GestureDetector(
            onTap: widget.isEditable ? _onTimeTap : null,
            behavior: HitTestBehavior.translucent,
            child: Row(
              children: [
                SizedBox(
                  width: Sizes.size60,
                  child: Text(
                    '약속시간',
                    style: TextStyle(
                      color: widget.primaryColor,
                    ),
                  ),
                ),
                const Icon(
                  Icons.access_time,
                  color: Color(0xff737373),
                  size: Sizes.size20,
                ),
                Gaps.h10,
                SizedBox(
                  height: Sizes.size32,
                  child: Center(
                    child: Text(_hm(_currentSignalInfo.sigPromiseTime)),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: Sizes.size60,
                child: Text(
                  '만날위치',
                  style: TextStyle(
                    color: widget.primaryColor,
                  ),
                ),
              ),
              const Icon(
                Icons.place,
                color: Color(0xff737373),
                size: Sizes.size20,
              ),
              Gaps.h10,
              Flexible(
                child: SizedBox(
                  height: Sizes.size32,
                  child: TextFormField(
                    initialValue: _currentSignalInfo.sigPromiseArea,
                    onChanged: _onLocationChange,
                    enabled: widget.isEditable,
                    decoration: const InputDecoration(
                      hintText: '장소를 정해주세요',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      fontSize: Sizes.size14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: Sizes.size60,
                child: Text(
                  '메뉴',
                  style: TextStyle(
                    color: widget.primaryColor,
                  ),
                ),
              ),
              const Icon(
                Icons.restaurant_menu,
                color: Color(0xff737373),
                size: Sizes.size20,
              ),
              Gaps.h10,
              Flexible(
                child: SizedBox(
                  height: Sizes.size32,
                  child: TextFormField(
                    initialValue: _currentSignalInfo.sigPromiseMenu,
                    onChanged: _onMenuChange,
                    enabled: widget.isEditable,
                    decoration: const InputDecoration(
                      hintText: '메뉴를 정해주세요',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      fontSize: Sizes.size14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
