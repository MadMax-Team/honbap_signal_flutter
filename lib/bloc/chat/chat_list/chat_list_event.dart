abstract class ChatListEvent {}

class ChatListGetEvent extends ChatListEvent {
  final String jwt;

  ChatListGetEvent({required this.jwt});
}
