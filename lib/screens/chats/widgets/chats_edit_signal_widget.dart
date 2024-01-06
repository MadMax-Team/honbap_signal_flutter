import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/bloc/chat/chat_room/chat_room_bloc.dart';
import 'package:honbap_signal_flutter/bloc/chat/chat_room/chat_room_event.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/models/signal/signal_info_model.dart';
import 'package:honbap_signal_flutter/widgets/common_signal_card_widget.dart';

class ChatsEditSignalWidget extends StatefulWidget {
  final Function()? onTapClose;
  final SignalInfoModel? initSignal;

  const ChatsEditSignalWidget({
    super.key,
    this.onTapClose,
    this.initSignal,
  });

  @override
  State<ChatsEditSignalWidget> createState() => _ChatsEditSignalWidgetState();
}

class _ChatsEditSignalWidgetState extends State<ChatsEditSignalWidget> {
  late SignalInfoModel signalInfo;

  @override
  void initState() {
    super.initState();
    signalInfo = widget.initSignal ?? const SignalInfoModel();
  }

  void _onEdit() {
    context.read<ChatRoomBloc>().add(ChatChangeSignalInfoEvent(
          signalInfo: signalInfo,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(Sizes.size20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: Sizes.size10,
            spreadRadius: Sizes.size2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Gaps.h40,
              Text(
                '시그널 글 작성',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(
                width: Sizes.size40,
                child: IconButton(
                  onPressed: widget.onTapClose,
                  icon: const Icon(
                    Icons.close_sharp,
                  ),
                ),
              ),
            ],
          ),
          Gaps.v10,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('조율 후 약속을 수정해주세요'),
                Gaps.v16,
                CommonSignalCardWidget(
                  isEditable: true,
                  initSignal: signalInfo,
                  onChange: (newSignalInfo) {
                    signalInfo = newSignalInfo;
                  },
                ),
                Gaps.v16,
                _button(
                  isColor: false,
                  text: '수정하기',
                  onTap: _onEdit,
                ),
                Gaps.v4,
                _button(
                  isColor: true,
                  text: '확인하기',
                  onTap: widget.onTapClose,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _button({
    required bool isColor,
    required String text,
    Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: Sizes.size10),
        decoration: BoxDecoration(
          color:
              isColor ? Theme.of(context).primaryColor : Colors.grey.shade400,
          borderRadius: BorderRadius.circular(Sizes.size10),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
