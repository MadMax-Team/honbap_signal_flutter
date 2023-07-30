import 'package:equatable/equatable.dart';
import 'package:honbap_signal_flutter/models/chats/chat_list_model.dart';

enum ChatListStatus {
  init('초기화'),
  loading('로딩'),
  success('성공'),
  error('에러');

  const ChatListStatus(this.message);

  final String message;
}

class ChatListState extends Equatable {
  final ChatListStatus status;
  final List<ChatListModel> chatrooms;
  final String? message;

  const ChatListState({
    this.status = ChatListStatus.init,
    this.chatrooms = const [],
    this.message,
  });

  ChatListState copyWith({
    ChatListStatus? status,
    List<ChatListModel>? chatrooms,
    String? message,
  }) =>
      ChatListState(
        status: status ?? this.status,
        chatrooms: chatrooms ?? this.chatrooms,
        message: message,
      );

  @override
  List<Object?> get props => [
        status,
        chatrooms,
        message,
      ];
}
