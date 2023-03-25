import 'package:bloc/bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signup/post_user_signup_event.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signup/post_user_signup_state.dart';
import 'package:honbap_signal_flutter/models/auth/auth_signup_model.dart';
import 'package:honbap_signal_flutter/repository/auth/auth_signup_repository.dart';

class SignupUserBloc extends Bloc<SignupUserEvent, SignupUserInfoState> {
  final AuthSignupRepository authSignupRepository;

  SignupUserBloc({
    required this.authSignupRepository,
  }) : super(SignupUserInfoNormalState(formData: AuthSignupModel())) {
    on<SignupButtonPressedEvent>(_handleSignupUserCreateAccountEvent);
    on<SignupEmailChangedEvent>(_handleSignupUserEmailChangeEvent);
    on<SignupPasswordChangedEvent>(_handleSignupUserPasswordChangeEvent);
    on<SignupNickNameChangedEvent>(_handleSignupUserNickNameChangeEvent);
    on<SignupBirthChangedEvent>(_handleSignupUserBirthChangeEvent);
    on<SignupPhoneNumChangedEvent>(_handleSignupUserPhoneNumChangeEvent);
    on<SignupSexChangedEvent>(_handleSignupUserSexChangeEvent);
  }

  // 회원가입 버튼 터치 이벤트 핸들러
  Future<void> _handleSignupUserCreateAccountEvent(
    SignupButtonPressedEvent event,
    Emitter<SignupUserInfoState> emit,
  ) async {
    try {
      emit(SignupUserInfoLoadingState());

      await Future.delayed(const Duration(seconds: 1));

      var res =
          await authSignupRepository.postUserSignup(formData: event.formData);
      print(event.formData);

      emit(SignupUserInfoLoadedState(resCode: res));
      // code 핸들링
    } catch (e) {
      // 통신 실패 핸들링
      emit(SignupUserInfoErrorState(message: e.toString()));
    }
  }

  // 이메일 주소 변경 이벤트 핸들러
  Future<void> _handleSignupUserEmailChangeEvent(
    SignupEmailChangedEvent event,
    Emitter<SignupUserInfoState> emit,
  ) async {
    emit(
      SignupUserInfoNormalState(
        formData: (state as SignupUserInfoNormalState)
            .formData
            .copyWith(email: event.email),
      ),
    );
  }

  // 비밀번호 변경 이벤트 핸들러
  Future<void> _handleSignupUserPasswordChangeEvent(
    SignupPasswordChangedEvent event,
    Emitter<SignupUserInfoState> emit,
  ) async {
    emit(
      SignupUserInfoNormalState(
        formData: (state as SignupUserInfoNormalState)
            .formData
            .copyWith(password: event.password),
      ),
    );
  }

  // 닉네임 변경 이벤트 핸들러
  Future<void> _handleSignupUserNickNameChangeEvent(
    SignupNickNameChangedEvent event,
    Emitter<SignupUserInfoState> emit,
  ) async {
    emit(
      SignupUserInfoNormalState(
        formData: (state as SignupUserInfoNormalState)
            .formData
            .copyWith(nickName: event.nickName),
      ),
    );
  }

  // 생일 변경 이벤트 핸들러
  Future<void> _handleSignupUserBirthChangeEvent(
    SignupBirthChangedEvent event,
    Emitter<SignupUserInfoState> emit,
  ) async {
    emit(
      SignupUserInfoNormalState(
        formData: (state as SignupUserInfoNormalState)
            .formData
            .copyWith(birth: event.birth),
      ),
    );
  }

  // 핸드폰 번호 변겅 이벤트 핸들러
  Future<void> _handleSignupUserPhoneNumChangeEvent(
    SignupPhoneNumChangedEvent event,
    Emitter<SignupUserInfoState> emit,
  ) async {
    emit(
      SignupUserInfoNormalState(
        formData: (state as SignupUserInfoNormalState)
            .formData
            .copyWith(phoneNum: event.phoneNum),
      ),
    );
  }

  // 성별 변경 이벤트 핸들러
  Future<void> _handleSignupUserSexChangeEvent(
    SignupSexChangedEvent event,
    Emitter<SignupUserInfoState> emit,
  ) async {
    emit(
      SignupUserInfoNormalState(
        formData: (state as SignupUserInfoNormalState)
            .formData
            .copyWith(sex: event.sex),
      ),
    );
  }
}
