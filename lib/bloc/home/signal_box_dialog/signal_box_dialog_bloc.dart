import 'package:bloc/bloc.dart';
import 'package:honbap_signal_flutter/bloc/home/signal_box_dialog/signal_box_dialog_event.dart';
import 'package:honbap_signal_flutter/bloc/home/signal_box_dialog/signal_box_dialog_state.dart';
import 'package:honbap_signal_flutter/repository/honbab/home/signal_box/home_signal_box_repository.dart';

class SignalBoxDialogBloc extends Bloc<SignalBoxDialogEvent, SignalBoxDialogState> {
  final HomeSignalBoxRepository _boxSendRepository;

  SignalBoxDialogBloc(this._boxSendRepository)
    :super(const SignalBoxDialogState(status: SignalBoxDialogStatus.init)) {
    on<GetSignalStateEvent>(_homeSignalStateGetEventHandler);
    on<SendSignalDataEvent>(_homeSignalBoxSendEventHandler);
  }

  Future<void> _homeSignalStateGetEventHandler(
      GetSignalStateEvent event,
      Emitter<SignalBoxDialogState> emit,
      ) async {
      emit(state.copyWith(status: SignalBoxDialogStatus.loading));

      try {
        final bool signalState =
        await _boxSendRepository.getHomeSignalBoxState(jwt: event.jwt);

        if (signalState) {
          emit(state.copyWith(
            status: SignalBoxDialogStatus.onState,
          ));
        } else {
          emit(state.copyWith(
            status: SignalBoxDialogStatus.offState,
          ));
        }

      } catch (e) {
        emit(state.copyWith(
          status: SignalBoxDialogStatus.error,
          message: e.toString(),
        ));
      }

  }

  Future<void> _homeSignalBoxSendEventHandler (
      SendSignalDataEvent event,
      Emitter<SignalBoxDialogState> emit,
      ) async {

      emit(state.copyWith(status: SignalBoxDialogStatus.loading));

      try {
        await _boxSendRepository.sendDataWithJwt(
          jwt: event.jwt,
          sigPromiseTime: event.sigPromiseTime,
          sigPromiseArea: event.sigPromiseArea,
          sigPromiseMenu: event.sigPromiseMenu,
        );

        if (state.status == SignalBoxDialogStatus.onState) {
          emit(state.copyWith(
            status: SignalBoxDialogStatus.offState,
          ));
        }
        else if (state.status == SignalBoxDialogStatus.offState) {
          emit(state.copyWith(
            status: SignalBoxDialogStatus.onState,
          ));
        }
        else {

        }

      } catch (e) {
        emit(state.copyWith(
          status: SignalBoxDialogStatus.error,
          message: e.toString(),
        ));
      }

  }
}