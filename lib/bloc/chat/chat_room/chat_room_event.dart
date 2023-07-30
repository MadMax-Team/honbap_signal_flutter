abstract class ChatRoomEvent {}

class ChatRoomGetEvent extends ChatRoomEvent {
  final String jwt;

  ChatRoomGetEvent({required this.jwt});
}
