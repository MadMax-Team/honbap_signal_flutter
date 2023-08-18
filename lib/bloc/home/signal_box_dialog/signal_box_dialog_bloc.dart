import 'package:bloc/bloc.dart';
import 'package:honbap_signal_flutter/bloc/home/signal_box_dialog/signal_box_dialog_event.dart';
import 'package:honbap_signal_flutter/bloc/home/signal_box_dialog/signal_box_dialog_state.dart';

class SignalBoxDialogBloc extends Bloc<SignalBoxDialogEvent, SignalBoxDialogState> {
  SignalBoxDialogBloc() : super(const SignalBoxDialogState());

  @override
  Stream<SignalBoxDialogState> mapEventToState(SignalBoxDialogEvent event) async* {
    // DialogState 에서 사용하는 status와 signalState를 적절하게 설정하고 emit
    yield state.copyWith(
      status: SignalBoxDialogStatus.loading);

    // 여기서 사용자 인터랙션 및 서버 통신 로직을 처리합니다.
    // 필요한 비즈니스 로직을 여기에 구현하면 됩니다.

    try {
      // 서버와 통신하고 결과에 따라 상태 변경
      // 예시로 딜레이와 성공 상태만 다룹니다.
      await Future.delayed(Duration(seconds: 2)); // 통신 시뮬레이션

      // 상태를 업데이트하여 성공 상태로 변경
      yield state.copyWith(
        status: SignalBoxDialogStatus.onSuccess,
        message: 'Data submitted successfully.',
      );
    } catch (error) {
      yield state.copyWith(
        status: SignalBoxDialogStatus.error,
        message: 'Error occurred: $error',
      );
    }
    }
}