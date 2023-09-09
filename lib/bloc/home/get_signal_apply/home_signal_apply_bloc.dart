import 'package:bloc/bloc.dart';
import 'package:honbap_signal_flutter/bloc/home/get_signal_apply/home_signal_apply_event.dart';
import 'package:honbap_signal_flutter/bloc/home/get_signal_apply/home_signal_apply_state.dart';
import 'package:honbap_signal_flutter/repository/honbab/home/home_repository.dart';

class HomeSignalApplyBloc extends Bloc<HomeSignalApplyEvent, HomeSignalApplyState> {
  final HomeSignalApplyRepository _homeSignalApplyRepository;

  HomeSignalApplyBloc(this._homeSignalApplyRepository)
      : super(const HomeSignalApplyState(status: HomeSignalApplyStatus.init)) {
    on<HomeSignalApplyGetEvent>(_homeSignalApplyGetEventHandler);
  }


  Future<void> _homeSignalApplyGetEventHandler(
    HomeSignalApplyGetEvent event,
    Emitter<HomeSignalApplyState> emit,
  ) async {
    emit(state.copyWith(status: HomeSignalApplyStatus.loading));

    try {
      var signalApplyResults =
          await _homeSignalApplyRepository.getHomeSignalApplyList(jwt: event.jwt);

      emit(state.copyWith(
        status: HomeSignalApplyStatus.success,
        signalApply: signalApplyResults,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: HomeSignalApplyStatus.error,
        message: e.toString(),
      ));
    }

  }


}