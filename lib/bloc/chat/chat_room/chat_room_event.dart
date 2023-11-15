abstract class ChatRoomEvent {}

class ChatRoomGetEvent extends ChatRoomEvent {}

class ChatSendEvent extends ChatRoomEvent {
  final String msg;

  ChatSendEvent({
    required this.msg,
  });
}
