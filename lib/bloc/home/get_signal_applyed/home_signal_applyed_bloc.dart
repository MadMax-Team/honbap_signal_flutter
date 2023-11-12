import 'package:bloc/bloc.dart';

import '../../../models/home/home_signal_applyed_list_model.dart';
import '../../../repository/honbab/home/home_repository.dart';
import 'home_signal_applyed_event.dart';
import 'home_signal_applyed_state.dart';

class HomeSignalApplyedBloc extends Bloc<HomeSignalApplyedEvent, HomeSignalApplyedState> {
  final HomeSignalApplyRepository _homeSignalApplyRepository;

  HomeSignalApplyedBloc(this._homeSignalApplyRepository)
      : super(const HomeSignalApplyedState(status: HomeSignalApplyedStatus.init)) {
    on<HomeSignalApplyedGetEvent>(_homeSignalApplyedGetEventHandler);
    on<HomeSignalApplyedDeleteEvent>(_homeSignalApplyedDeleteEventHandler);
    on<HomeSignalApplyedAcceptEvent>(_homeSignalApplyedAcceptEventHanler);
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

  Future<void> _homeSignalApplyedDeleteEventHandler(
      HomeSignalApplyedDeleteEvent event,
      Emitter<HomeSignalApplyedState> emit,
      ) async {
    emit(state.copyWith(status: HomeSignalApplyedStatus.loading));

    try {
      var isSuccess =
      await _homeSignalApplyRepository.deleteFromApplylist(jwt: event.jwt, userIdx: event.userIdx, applyedIdx: event.applyedIdx);

      if(isSuccess) {
        final updatedSignalApplyList = List<HomeSignalApplyedListModel>.from(state.signalApply)
          ..removeWhere((item) => item.userIdx == event.userIdx);

        emit(state.copyWith(
          status: HomeSignalApplyedStatus.success,
          signalApply: updatedSignalApplyList,
        ));
      } else {
        emit(state.copyWith(
          status: HomeSignalApplyedStatus.error,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: HomeSignalApplyedStatus.error,
        message: e.toString(),
      ));
    }

  }

  Future<void> _homeSignalApplyedAcceptEventHanler(
      HomeSignalApplyedAcceptEvent event,
      Emitter<HomeSignalApplyedState> emit,
      ) async {
    emit(state.copyWith(status: HomeSignalApplyedStatus.loading));

    try {
      var isSuccess =
      await _homeSignalApplyRepository.acceptFromApplyedList(jwt: event.jwt, matchedIdx: event.matchedIdx);

      if(isSuccess) {
        final updatedSignalApplyList = List<HomeSignalApplyedListModel>.from(state.signalApply)
          ..removeWhere((item) => item.userIdx == event.matchedIdx);

        emit(state.copyWith(
          status: HomeSignalApplyedStatus.success,
          signalApply: updatedSignalApplyList,
        ));
      } else {
        emit(state.copyWith(
          status: HomeSignalApplyedStatus.error,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: HomeSignalApplyedStatus.error,
        message: e.toString(),
      ));
    }
  }
}
