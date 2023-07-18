import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_app_send_veri/post_app_send_veri_event.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_app_send_veri/post_app_send_veri_state.dart';
import 'package:honbap_signal_flutter/repository/honbab/auth/auth_signup_repository.dart';

class SignupPhoneBloc extends Bloc<SignupPhoneEvent, SignupPhoneState> {
  final HonbabAuthSignupRepository authSignupRepository;

  SignupPhoneBloc({
    required this.authSignupRepository,
  }) : super(SignupPhoneInitState()) {
    on<SignupPhoneSendTabEvent>(_handleSignupPhoneSendTabEvent);
    on<SignupPhoneVerifyTabEvent>(_handleSignupPhoneVerifyTabEvent);
  }

  // 다음 버튼(verify code send) 터치 이벤트 핸들러
  Future<void> _handleSignupPhoneSendTabEvent(
    SignupPhoneSendTabEvent event,
    Emitter<SignupPhoneState> emit,
  ) async {
    try {
      emit(SignupPhoneSendLoadingState());

      var res = await authSignupRepository.postAppSend(
        phoneNumber: event.phoneNumber,
      );

      emit(SignupPhoneSendedState(isSuccess: res));
    } catch (e) {
      emit(SignupPhoneSendErrorState(message: e.toString()));
    }
  }

  // 다음 버튼(verify) 터치 이벤트 핸들러
  Future<void> _handleSignupPhoneVerifyTabEvent(
    SignupPhoneVerifyTabEvent event,
    Emitter<SignupPhoneState> emit,
  ) async {
    try {
      emit(SignupPhoneVerifyLoadingState());

      var res = await authSignupRepository.postAppVerify(
        phoneNumber: event.phoneNumber,
        verifyCode: event.verifyCode,
      );

      emit(SignupPhoneVerifiedState(isSuccess: res));
    } catch (e) {
      emit(SignupPhoneVerifyErrorState(message: e.toString()));
    }
  }
}
