import 'package:bloc/bloc.dart';
import 'package:honbap_signal_flutter/bloc/home/signal_modify/signal_modify_dialog_event.dart';
import 'package:honbap_signal_flutter/bloc/home/signal_modify/signal_modify_dialog_state.dart';
import 'package:honbap_signal_flutter/repository/honbab/home/signal_box/home_signal_box_repository.dart';

class SignalModifyBloc extends Bloc<SignalModifyEvent, SignalModifyDialogState> {
  final HomeSignalBoxRepository _boxSendRepository;

  SignalModifyBloc(this._boxSendRepository)
      :super(const SignalModifyDialogState(status: SignalModifyDialogStatus.init)) {
    on<GetSignalStateDetailEvent>(_homeSignalModifyGetEventHandler);
  }

  Future<void> _homeSignalModifyGetEventHandler(
      GetSignalStateDetailEvent event,
      Emitter<SignalModifyDialogState> emit,
      ) async {
    emit(state.copyWith(status: SignalModifyDialogStatus.loading));

    try {
      final Map<String, dynamic> signalData = await _boxSendRepository.getSignalDetail(jwt: event.jwt);

      emit(state.copyWith(
        status: SignalModifyDialogStatus.success,
        signalData: signalData,
      ));

    } catch (e) {
      emit(state.copyWith(
        status: SignalModifyDialogStatus.error,
        message: e.toString(),
      ));
    }

  }
}