import 'package:bloc/bloc.dart';
import 'package:honbap_signal_flutter/bloc/home/get_signal_apply/home_signal_apply_event.dart';
import 'package:honbap_signal_flutter/bloc/home/get_signal_apply/home_signal_apply_state.dart';
import 'package:honbap_signal_flutter/repository/honbab/home/home_repository.dart';

import '../../../models/home/home_signal_apply_list_model.dart';

class HomeSignalApplyBloc extends Bloc<HomeSignalApplyEvent, HomeSignalApplyState> {
  final HomeSignalApplyRepository _homeSignalApplyRepository;

  HomeSignalApplyBloc(this._homeSignalApplyRepository)
      : super(const HomeSignalApplyState(status: HomeSignalApplyStatus.init)) {
    on<HomeSignalApplyGetEvent>(_homeSignalApplyGetEventHandler);
    on<HomeSignalApplyDeleteEvent>(_homeSignalApplyDeleteEventHandler);
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

  Future<void> _homeSignalApplyDeleteEventHandler(
      HomeSignalApplyDeleteEvent event,
      Emitter<HomeSignalApplyState> emit,
      ) async {
    emit(state.copyWith(status: HomeSignalApplyStatus.loading));

    try {
      var isSuccess =
      await _homeSignalApplyRepository.deleteFromApplylist(jwt: event.jwt, userIdx: event.userIdx, applyedIdx: event.applyedIdx);

      if(isSuccess) {
        final updatedSignalApplyList = List<HomeSignalApplyListModel>.from(state.signalApply)
          ..removeWhere((item) => item.applyedIdx == event.applyedIdx);

        emit(state.copyWith(
          status: HomeSignalApplyStatus.success,
          signalApply: updatedSignalApplyList,
        ));
      } else {
        emit(state.copyWith(
          status: HomeSignalApplyStatus.error,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: HomeSignalApplyStatus.error,
        message: e.toString(),
      ));
    }

  }

}