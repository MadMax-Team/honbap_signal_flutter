import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/bloc/signal/signal_list_event.dart';
import 'package:honbap_signal_flutter/bloc/signal/signal_list_state.dart';
import 'package:honbap_signal_flutter/repository/honbab/signal/signal_list_repository.dart';

class SignalListBloc extends Bloc<SignalListEvent, SignalListState> {
  final HonbabSignalListRepository honbabSignalListRepository;
  final int myUserIdx;

  SignalListBloc({
    required this.honbabSignalListRepository,
    required this.myUserIdx,
  }) : super(const SignalListState(status: SignalListStatus.init)) {
    on<SignalListGetEvent>(_signalListGetEventHandler);
  }

  Future<void> _signalListGetEventHandler(
    SignalListGetEvent event,
    Emitter<SignalListState> emit,
  ) async {
    emit(state.copyWith(status: SignalListStatus.loading));

    try {
      var signalResults = await honbabSignalListRepository.getSignalList(
        jwt: event.jwt,
      );

      emit(state.copyWith(
        status: SignalListStatus.success,
        signals: signalResults
            .where((signal) => signal.userIdx != myUserIdx)
            .toList(),
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SignalListStatus.error,
        message: e.toString(),
      ));
    }
  }
}
