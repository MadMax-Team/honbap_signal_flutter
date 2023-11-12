import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/bloc/signal/signal_state_event.dart';
import 'package:honbap_signal_flutter/bloc/signal/signal_state_state.dart';
import 'package:honbap_signal_flutter/models/signal/signal_state_model.dart';

class SignalStateBloc extends Bloc<SignalStateEvent, SignalStateState> {
  SignalStateBloc() : super(const SignalStateState.init()) {
    on<SignalStateOnEvent>(_signalStateOnEventHandler);
    on<SignalStateOffEvent>(_signalStateOffEventHandler);
    on<SignalStateUpdateEvent>(_signalStateUpdateEventHandler);
    on<SignalStateCloseMatchEvent>(_signalStateCloseMatchEventHandler);
  }

  Future<void> _signalStateOnEventHandler(
    SignalStateOnEvent event,
    Emitter<SignalStateState> emit,
  ) async {
    emit(state.copyWith(state: SignalState.matched));
  }

  Future<void> _signalStateOffEventHandler(
    SignalStateOffEvent event,
    Emitter<SignalStateState> emit,
  ) async {
    emit(state.copyWith(state: SignalState.idle));
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
