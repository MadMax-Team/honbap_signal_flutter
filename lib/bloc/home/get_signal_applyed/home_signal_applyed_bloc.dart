import 'package:bloc/bloc.dart';

import '../../../repository/honbab/home/home_repository.dart';
import 'home_signal_applyed_event.dart';
import 'home_signal_applyed_state.dart';

class HomeSignalApplyedBloc extends Bloc<HomeSignalApplyedEvent, HomeSignalApplyedState> {
  final HomeSignalApplyRepository _homeSignalApplyRepository;

  HomeSignalApplyedBloc(this._homeSignalApplyRepository)
      : super(const HomeSignalApplyedState(status: HomeSignalApplyedStatus.init)) {
    on<HomeSignalApplyedGetEvent>(_homeSignalApplyedGetEventHandler);
  }


  Future<void> _homeSignalApplyedGetEventHandler(
      HomeSignalApplyedGetEvent event,
      Emitter<HomeSignalApplyedState> emit,
      ) async {
    emit(state.copyWith(status: HomeSignalApplyedStatus.loading));

    try {
      var signalApplyResults =
      await _homeSignalApplyRepository.getHomeSignalApplyedList(jwt: event.jwt);

      emit(state.copyWith(
        status: HomeSignalApplyedStatus.success,
        signalApply: signalApplyResults,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: HomeSignalApplyedStatus.error,
        message: e.toString(),
      ));
    }

  }


}