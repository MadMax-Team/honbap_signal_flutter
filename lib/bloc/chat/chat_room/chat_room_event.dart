import 'package:honbap_signal_flutter/models/signal/signal_info_model.dart';

abstract class ChatRoomEvent {}

class ChatRoomGetEvent extends ChatRoomEvent {}

class ChatSendEvent extends ChatRoomEvent {
  final String msg;

  ChatSendEvent({
    required this.msg,
  });
}

class ChatChangeSignalInfoEvent extends ChatRoomEvent {
  final SignalInfoModel signalInfo;

  ChatChangeSignalInfoEvent({
    required this.signalInfo,
  });
}
