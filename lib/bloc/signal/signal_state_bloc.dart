import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/bloc/signal/signal_state_event.dart';
import 'package:honbap_signal_flutter/bloc/signal/signal_state_state.dart';
import 'package:honbap_signal_flutter/models/signal/signal_state_model.dart';
import 'package:honbap_signal_flutter/repository/honbab/home/signal_box/home_signal_box_repository.dart';

class SignalStateBloc extends Bloc<SignalStateEvent, SignalStateState> {
  final HomeSignalBoxRepository homeSignalBoxRepository;
  final int myIdx;
  final String jwt;
  final String fcmToken;

  SignalStateBloc({
    required this.homeSignalBoxRepository,
    required this.myIdx,
    required this.jwt,
    required this.fcmToken,
  }) : super(const SignalStateState.init()) {
    on<SignalStateGetEvent>(_signalStateGetEventHandler);
    on<SignalStateOnEvent>(_signalStateOnEventHandler);
    on<SignalStateOffEvent>(_signalStateOffEventHandler);
    on<SignalStateUpdateEvent>(_signalStateUpdateEventHandler);
    on<SignalStateCloseMatchEvent>(_signalStateCloseMatchEventHandler);
    on<MatchedSateSaveEvent>(_matchedStateSaveEventHandler);
  }

  Future<void> _signalStateGetEventHandler(
    SignalStateGetEvent event,
    Emitter<SignalStateState> emit,
  ) async {
    emit(state.copyWith(state: SignalState.loading));

    try {
      final resultData =
          await homeSignalBoxRepository.getHomeSignalBoxState(jwt: jwt);
      final signalState = resultData['sigStatus'];
      final matchedState = resultData['sigMatchStatus'];
      // final oppoUserIdx = resultData['userIdx'];
      final oppoUserIdx = myIdx == resultData['applyedIdx']
          ? resultData['userIdx']
          : resultData['applyedIdx'];
      final oppoNickName = resultData['userName'];
      final signalStateModel = SignalStateModel.fromJson(resultData);

      final customizedSignalStateModel = SignalStateModel(
        oppoUserIdx: oppoUserIdx,
        oppoNickName: oppoNickName,
        sigPromiseTime: signalStateModel.sigPromiseTime,
        sigPromiseArea: signalStateModel.sigPromiseArea,
        sigPromiseMenu: signalStateModel.sigPromiseMenu,
      );

      if (matchedState == 1) {
        emit(state.copyWith(
          state: SignalState.matched,
          signal: customizedSignalStateModel,
        ));
        print(customizedSignalStateModel);
      } else {
        if (signalState == 1) {
          emit(state.copyWith(
            state: SignalState.signaling,
            signal: customizedSignalStateModel,
          ));
        } else {
          emit(state.copyWith(
            state: SignalState.idle,
            signal: customizedSignalStateModel,
          ));
        }
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
    print(event);
    emit(state.copyWith(
      signal: SignalStateModel(
        // 현재 api 사양에 맞지 않음
        // oppoUserIdx: event.incomeSignal.oppoUserIdx,
        // oppoNickName: event.incomeSignal.oppoNickName,
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

  Future<void> _matchedStateSaveEventHandler(
    MatchedSateSaveEvent event,
    Emitter<SignalStateState> emit,
  ) async {
    emit(state.copyWith(state: SignalState.loading));

    try {
      await homeSignalBoxRepository.matchedSave(jwt: jwt);

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
}
