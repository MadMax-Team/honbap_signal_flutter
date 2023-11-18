import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/bloc/chat/chat_list/chat_list_event.dart';
import 'package:honbap_signal_flutter/bloc/chat/chat_list/chat_list_state.dart';
import 'package:honbap_signal_flutter/repository/honbab/chat/chat_list_repository.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  final ChatListRepository _chatListRepository;

  ChatListBloc(this._chatListRepository)
      : super(const ChatListState(status: ChatListStatus.init)) {
    on<ChatListGetEvent>(_chatListGetEventHandler);
  }

  Future<void> _chatListGetEventHandler(
    ChatListGetEvent event,
    Emitter<ChatListState> emit,
  ) async {
    emit(state.copyWith(status: ChatListStatus.loading));

    try {
      var chatroomResults =
          await _chatListRepository.getChatList(jwt: event.jwt);

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
}
