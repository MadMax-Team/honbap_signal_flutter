import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_state.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signin/post_user_signin_event.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signin/post_user_signin_state.dart';
import 'package:honbap_signal_flutter/repository/honbab/auth/auth_repository.dart';

class SigninUserBloc extends Bloc<SinginUserEvent, SigninUserState> {
  final HonbabAuthRepository _honbabAuthRepository;

  SigninUserBloc(this._honbabAuthRepository) : super(const SigninUserState()) {
    on<SigninButtonTapEvent>(_signinButtonTapEventHandler);
    on<SigninEmailChangeEvent>(_signinEmailChangeEventHandler);
    on<SigninPasswordChangeEvent>(_signinPasswordChangeEventHandler);
  }

  Future<void> _signinButtonTapEventHandler(
    SigninButtonTapEvent event,
    Emitter<SigninUserState> emit,
  ) async {
    try {
      // Check if the form is valid
      if (!_isValid(event, emit)) return;

      emit(SinginUserLoadingState(
        email: state.email,
        password: state.password,
      ));

      var res = await _honbabAuthRepository.signin(
        platform: AuthenticationWith.honbab,
        email: state.email,
        password: state.password,
      );

      if (res?.result?.jwt == null || res?.result?.userIdx == null) {
        emit(SigninUserErrorState(
          code: 1003,
          message: res?.message ?? '로그인에 실패했습니다.',
          email: state.email,
          password: state.password,
        ));
      } else {
        emit(SigninUserSuccessState(
          userIdx: res!.result!.userIdx,
          jwt: res.result!.jwt,
          email: state.email,
          password: state.password,
        ));
      }
    } catch (e) {
      emit(SigninUserErrorState(
        code: 1003,
        message: e.toString(),
        email: state.email,
        password: state.password,
      ));
    }
  }

  bool _isValid(
    SigninButtonTapEvent event,
    Emitter<SigninUserState> emit,
  ) {
    if (state.email == null || state.email?.isEmpty == true) {
      print('email error');
      emit(SigninUserErrorState(
        code: 1001,
        message: '이메일을 입력해주세요.',
        email: state.email,
        password: state.password,
      ));
      emit(SigninUserState(
        email: state.email,
        password: state.password,
      ));
      return false;
    }
    if (state.password == null || state.password?.isEmpty == true) {
      emit(SigninUserErrorState(
        code: 1002,
        message: '비밀번호를 입력해주세요.',
        email: state.email,
        password: state.password,
      ));
      emit(SigninUserState(
        email: state.email,
        password: state.password,
      ));
      return false;
    }

    return true;
  }

  // 이메일 주소 변경 이벤트 핸들러
  Future<void> _signinEmailChangeEventHandler(
    SigninEmailChangeEvent event,
    Emitter<SigninUserState> emit,
  ) async {
    emit(SigninUserState(
      email: event.email,
      password: state.password,
    ));
  }

  // 비밀번호 변경 이벤트 핸들러
  Future<void> _signinPasswordChangeEventHandler(
    SigninPasswordChangeEvent event,
    Emitter<SigninUserState> emit,
  ) async {
    emit(SigninUserState(
      email: state.email,
      password: event.password,
    ));
  }
}
