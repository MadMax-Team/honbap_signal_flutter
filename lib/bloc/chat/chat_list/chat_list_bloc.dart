import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/bloc/chat/chat_list/chat_list_event.dart';
import 'package:honbap_signal_flutter/bloc/chat/chat_list/chat_list_state.dart';
import 'package:honbap_signal_flutter/repository/honbab/chat/chat_list_repository.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  final ChatListRepository chatListRepository;
  final String jwt;

  ChatListBloc({
    required this.chatListRepository,
    required this.jwt,
  }) : super(const ChatListState(status: ChatListStatus.init)) {
    on<ChatListGetEvent>(_chatListGetEventHandler);
    on<ChatLeaveEvent>(_chatLeaveEventHandler);
  }

  Future<void> _chatListGetEventHandler(
    ChatListGetEvent event,
    Emitter<ChatListState> emit,
  ) async {
    emit(state.copyWith(status: ChatListStatus.loading));

    try {
      var chatroomResults = await chatListRepository.getChatList(jwt: jwt);

      emit(state.copyWith(
        status: ChatListStatus.success,
        chatrooms: chatroomResults,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ChatListStatus.error,
        message: e.toString(),
        chatrooms: null,
      ));
    }
  }

  Future<void> _chatLeaveEventHandler(
    ChatLeaveEvent event,
    Emitter<ChatListState> emit,
  ) async {
    emit(state.copyWith(status: ChatListStatus.loading));

    var res = await chatListRepository.leaveChatRoom(
      jwt: jwt,
      roomId: event.roomId,
    );

    if (res.code == 1000) {
      await _chatListGetEventHandler(ChatListGetEvent(), emit);
    } else {
      emit(state.copyWith(
        status: ChatListStatus.error,
        message: res.message,
      ));
    }
  }
}
