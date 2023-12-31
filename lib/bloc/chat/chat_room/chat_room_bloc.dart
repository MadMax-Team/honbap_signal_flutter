import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/bloc/chat/chat_room/chat_room_event.dart';
import 'package:honbap_signal_flutter/bloc/chat/chat_room/chat_room_state.dart';
import 'package:honbap_signal_flutter/repository/honbab/chat/chat_room_repository.dart';

class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState> {
  final ChatRoomRepository chatRoomRepository;
  final String jwt;
  final String roomId;
  final int? applyedIdx;

  ChatRoomBloc({
    required this.chatRoomRepository,
    required this.jwt,
    required this.roomId,
    this.applyedIdx,
  }) : super(const ChatRoomState(status: ChatRoomStatus.init)) {
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
      var chatResults = await chatRoomRepository.getChats(
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

    var chatResults = await chatRoomRepository.sendChat(
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

    var chatResults = await chatRoomRepository.changeSignalInfo(
      jwt: jwt,
      roomId: roomId,
      signalInfo: event.signalInfo,
      applyedIdx: applyedIdx!,
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
