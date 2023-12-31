import 'package:bloc/bloc.dart';
import 'package:honbap_signal_flutter/bloc/signal/signal_user/signal_user_event.dart';
import 'package:honbap_signal_flutter/bloc/signal/signal_user/signal_user_state.dart';
import 'package:honbap_signal_flutter/models/signal/signal_list_model.dart';
import 'package:honbap_signal_flutter/repository/honbab/home/home_repository.dart';
import 'package:honbap_signal_flutter/repository/honbab/home/signal_box/home_signal_box_repository.dart';

class SignalUserStateBloc extends Bloc<SignalUserStateEvent, SignalUserStateState> {
  final HomeSignalApplyRepository homeSignalApplyRepository;

  SignalUserStateBloc({
    required this.homeSignalApplyRepository,
  }) : super(const SignalUserStateState.init()) {
    on<SignalUserStateGetEvent>(_signalUserStateGetEventHandler);
    on<SignalUserStateResetEvent>(_signalUserStateResetEventHandler);
  }

  Future<void> _signalUserStateGetEventHandler(
      SignalUserStateGetEvent event,
      Emitter<SignalUserStateState> emit,
    ) async {
      emit(state.copyWith(state: SignalUserState.loading));

      try {
        SignalListModel userProfile =
        await homeSignalApplyRepository.getUserProfile(
          user: event.userIdx,
        );

        emit(state.copyWith(state: SignalUserState.success, userProfile: userProfile));

      } catch (e) {
        var prevState = state.state;
        emit(state.copyWith(
          state: SignalUserState.error,
          message: e.toString(),
        ));
        emit(state.copyWith(
          state: prevState,
          message: e.toString(),
        ));
      }
  }

  Future<void> _signalUserStateResetEventHandler(
      SignalUserStateResetEvent event,
      Emitter<SignalUserStateState> emit,
      ) async {

      emit(state.copyWith(state: SignalUserState.init));
      print('reset');
  }
}