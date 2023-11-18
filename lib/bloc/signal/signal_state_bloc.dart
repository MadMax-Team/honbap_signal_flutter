import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/bloc/signal/signal_state_event.dart';
import 'package:honbap_signal_flutter/bloc/signal/signal_state_state.dart';
import 'package:honbap_signal_flutter/models/signal/signal_state_model.dart';
import 'package:honbap_signal_flutter/repository/honbab/home/signal_box/home_signal_box_repository.dart';

class SignalStateBloc extends Bloc<SignalStateEvent, SignalStateState> {
  final HomeSignalBoxRepository homeSignalBoxRepository;
  final String jwt;
  final String fcmToken;

  SignalStateBloc({
    required this.homeSignalBoxRepository,
    required this.jwt,
    required this.fcmToken,
  }) : super(const SignalStateState.init()) {
    on<SignalStateGetEvent>(_signalStateGetEventHandler);
    on<SignalStateOnEvent>(_signalStateOnEventHandler);
    on<SignalStateOffEvent>(_signalStateOffEventHandler);
    on<SignalStateUpdateEvent>(_signalStateUpdateEventHandler);
    on<SignalStateCloseMatchEvent>(_signalStateCloseMatchEventHandler);
  }

  Future<void> _signalStateGetEventHandler(
    SignalStateGetEvent event,
    Emitter<SignalStateState> emit,
  ) async {
    emit(state.copyWith(state: SignalState.loading));

    try {
      final bool signalState =
          await homeSignalBoxRepository.getHomeSignalBoxState(jwt: jwt);

      if (signalState) {
        emit(state.copyWith(state: SignalState.signaling));
      } else {
        emit(state.copyWith(state: SignalState.idle));
      }
    } catch (e) {
      var prevState = state.state;
      emit(state.copyWith(
        state: SignalState.error,
        message: e.toString(),
      ));
      emit(state.copyWith(
        state: prevState,
        message: e.toString(),
      ));
    }
  }

  Future<void> _signalStateOnEventHandler(
    SignalStateOnEvent event,
    Emitter<SignalStateState> emit,
  ) async {
    emit(state.copyWith(state: SignalState.loading));

    try {
      await homeSignalBoxRepository.sendDataWithJwt(
        jwt: jwt,
        sigPromiseTime: event.signalInfo?.sigPromiseTime,
        sigPromiseArea: event.signalInfo?.sigPromiseArea,
        sigPromiseMenu: event.signalInfo?.sigPromiseMenu,
        fcm: fcmToken,
      );

      emit(state.copyWith(state: SignalState.signaling));
    } catch (e) {
      var prevState = state.state;
      emit(state.copyWith(
        state: SignalState.error,
        message: e.toString(),
      ));
      emit(state.copyWith(
        state: prevState,
        message: e.toString(),
      ));
    }

    emit(state.copyWith(state: SignalState.signaling));
  }

  Future<void> _signalStateOffEventHandler(
    SignalStateOffEvent event,
    Emitter<SignalStateState> emit,
  ) async {
    emit(state.copyWith(state: SignalState.loading));

    try {
      await homeSignalBoxRepository.sendToSignalOff(jwt: jwt);

      emit(state.copyWith(state: SignalState.idle));
    } catch (e) {
      var prevState = state.state;
      emit(state.copyWith(
        state: SignalState.error,
        message: e.toString(),
      ));
      emit(state.copyWith(
        state: prevState,
        message: e.toString(),
      ));
    }
  }

  Future<void> _signalStateUpdateEventHandler(
    SignalStateUpdateEvent event,
    Emitter<SignalStateState> emit,
  ) async {
    emit(state.copyWith(
      state: SignalState.matched,
      signal: SignalStateModel(
        oppoUserIdx: event.incomeSignal.oppoUserIdx,
        oppoNickName: event.incomeSignal.oppoNickName,
        sigPromiseTime: event.incomeSignal.sigPromiseTime,
        sigPromiseArea: event.incomeSignal.sigPromiseArea,
        sigPromiseMenu: event.incomeSignal.sigPromiseMenu,
      ),
    ));
  }

  Future<void> _signalStateCloseMatchEventHandler(
    SignalStateCloseMatchEvent event,
    Emitter<SignalStateState> emit,
  ) async {
    emit(state.copyWith(
      state: SignalState.idle,
      signal: const SignalStateModel(),
    ));
  }
}
