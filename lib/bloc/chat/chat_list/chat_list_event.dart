abstract class ChatListEvent {}

class ChatListGetEvent extends ChatListEvent {}

class ChatLeaveEvent extends ChatListEvent {
  final String roomId;

  ChatLeaveEvent({
    required this.roomId,
  });
}
