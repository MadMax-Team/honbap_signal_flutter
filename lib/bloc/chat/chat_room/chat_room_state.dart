import 'package:equatable/equatable.dart';
import 'package:honbap_signal_flutter/models/chats/chat_model.dart';

enum ChatRoomStatus {
  init('초기화'),
  loading('로딩'),
  success('성공'),
  error('에러');

  const ChatRoomStatus(this.message);

  final String message;
}

class ChatRoomState extends Equatable {
  final ChatRoomStatus status;
  final List<ChatModel> chats;
  final String? message;

  const ChatRoomState({
    this.status = ChatRoomStatus.init,
    this.chats = const [],
    this.message,
  });

  ChatRoomState copyWith({
    ChatRoomStatus? status,
    List<ChatModel>? chats,
    String? message,
  }) =>
      ChatRoomState(
        status: status ?? this.status,
        chats: chats ?? this.chats,
        message: message,
      );

  @override
  List<Object?> get props => [
        status,
        chats,
        message,
      ];
}
