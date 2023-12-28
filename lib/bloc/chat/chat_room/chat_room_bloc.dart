import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/bloc/chat/chat_room/chat_room_event.dart';
import 'package:honbap_signal_flutter/bloc/chat/chat_room/chat_room_state.dart';
import 'package:honbap_signal_flutter/repository/honbab/chat/chat_room_repository.dart';

class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState> {
  final ChatRoomRepository _chatRoomRepository;
  final String jwt;
  final String roomId;

  ChatRoomBloc(
    this._chatRoomRepository,
    this.jwt,
    this.roomId,
  ) : super(const ChatRoomState(status: ChatRoomStatus.init)) {
    on<ChatRoomGetEvent>(_chatRoomGetEventHandler);
    on<ChatSendEvent>(_chatSendEventHandler);
    on<ChatChangeSignalInfoEvent>(_chatChangeSignalInfoEventHandler);
  }

  Future<void> _chatRoomGetEventHandler(
    ChatRoomGetEvent event,
    Emitter<ChatRoomState> emit,
  ) async {
    emit(state.copyWith(status: ChatRoomStatus.loading));

    try {
      var chatResults = await _chatRoomRepository.getChats(
        jwt: jwt,
        roomId: roomId,
      );

      emit(state.copyWith(
        status: ChatRoomStatus.success,
        chats: chatResults,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ChatRoomStatus.error,
        message: e.toString(),
      ));
    }
  }

  Future<void> _chatSendEventHandler(
    ChatSendEvent event,
    Emitter<ChatRoomState> emit,
  ) async {
    emit(state.copyWith(status: ChatRoomStatus.loading));

    var chatResults = await _chatRoomRepository.sendChat(
      jwt: jwt,
      roomId: roomId,
      msg: event.msg,
    );

    if (chatResults.code == 1000) {
      // update message
      await _chatRoomGetEventHandler(ChatRoomGetEvent(), emit);
      emit(state.copyWith(status: ChatRoomStatus.success));
    } else {
      emit(state.copyWith(
        status: ChatRoomStatus.error,
        message: chatResults.message,
      ));
    }
  }

  Future<void> _chatChangeSignalInfoEventHandler(
    ChatChangeSignalInfoEvent event,
    Emitter<ChatRoomState> emit,
  ) async {
    emit(state.copyWith(status: ChatRoomStatus.loading));

    var chatResults = await _chatRoomRepository.changeSignalInfo(
      jwt: jwt,
      roomId: roomId,
      signalInfo: event.signalInfo,
    );

    if (chatResults.code == 1000) {
      emit(state.copyWith(status: ChatRoomStatus.success));
    } else {
      emit(state.copyWith(
        status: ChatRoomStatus.error,
        message: chatResults.message,
      ));
    }
  }
}
