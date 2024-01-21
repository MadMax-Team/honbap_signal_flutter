import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signup/post_user_signup_event.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signup/post_user_signup_state.dart';
import 'package:honbap_signal_flutter/models/auth/auth_signup_model.dart';
import 'package:honbap_signal_flutter/repository/honbab/auth/auth_signup_repository.dart';

class SignupUserBloc extends Bloc<SignupUserEvent, SignupUserInfoState> {
  final HonbabAuthSignupRepository authSignupRepository;

  SignupUserBloc({
    required this.authSignupRepository,
  }) : super(SignupUserInfoNormalState(formData: const AuthSignupModel())) {
    on<SignupButtonTabEvent>(
      _handleSignupUserCreateAccountEvent,
      transformer: droppable(),
    );
    on<SignupEmailChangedEvent>(_handleSignupUserEmailChangeEvent);
    on<SignupPasswordChangedEvent>(_handleSignupUserPasswordChangeEvent);
    on<SignupUserNameChangedEvent>(_handleSignupUserUserNameChangeEvent);
    on<SignupBirthChangedEvent>(_handleSignupUserBirthChangeEvent);
    on<SignupPhoneNumChangedEvent>(_handleSignupUserPhoneNumChangeEvent);
    on<SignupSexChangedEvent>(_handleSignupUserSexChangeEvent);
  }

  // 회원가입 버튼 터치 이벤트 핸들러
  Future<void> _handleSignupUserCreateAccountEvent(
    SignupButtonTabEvent event,
    Emitter<SignupUserInfoState> emit,
  ) async {
    try {
      // Check if the form is valid
      if (!_isValid(event, emit)) return;

      emit(SignupUserInfoLoadingState());

      var res =
          await authSignupRepository.postUserSignup(formData: event.formData);

      if (res.code == 4000) {
        emit(SignupUserInfoErrorState(
          code: res.code,
          message: res.message,
        ));
      } else {
        emit(SignupUserInfoLoadedState(
          resCode: res,
          formData: event.formData,
        ));
      }
      // code 핸들링
    } catch (e) {
      // 통신 실패 핸들링
      emit(SignupUserInfoErrorState(
        code: 4001,
        message: e.toString(),
      ));
    } finally {
      emit(SignupUserInfoNormalState(formData: event.formData));
    }
  }

  bool _isValid(
    SignupButtonTabEvent event,
    Emitter<SignupUserInfoState> emit,
  ) {
    if (event.formData.email == null || event.formData.email == '') {
      emit(SignupUserInfoErrorState(
        code: 1001,
        message: '이메일을 입력해주세요.',
      ));
      emit(SignupUserInfoNormalState(formData: event.formData));
      return false;
    }
    if (event.formData.password == null || event.formData.password == '') {
      emit(SignupUserInfoErrorState(
        code: 1002,
        message: '비밀번호를 입력해주세요.',
      ));
      emit(SignupUserInfoNormalState(formData: event.formData));
      return false;
    }
    if (event.formData.userName == null || event.formData.userName == '') {
      emit(SignupUserInfoErrorState(
        code: 1003,
        message: '이름을 입력해주세요.',
      ));
      emit(SignupUserInfoNormalState(formData: event.formData));
      return false;
    }
    if (event.formData.birth == null || event.formData.birth == '') {
      emit(SignupUserInfoErrorState(
        code: 1004,
        message: '생일을 선택해주세요.',
      ));
      emit(SignupUserInfoNormalState(formData: event.formData));
      return false;
    }
    if (event.formData.sex == null || event.formData.sex == '') {
      emit(SignupUserInfoErrorState(
        code: 1005,
        message: '성별을 선택해주세요.',
      ));
      emit(SignupUserInfoNormalState(formData: event.formData));
      return false;
    }

    return true;
  }

  // 이메일 주소 변경 이벤트 핸들러
  Future<void> _handleSignupUserEmailChangeEvent(
    SignupEmailChangedEvent event,
    Emitter<SignupUserInfoState> emit,
  ) async {
    if (state is! SignupUserInfoNormalState) return;
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
    if (state is! SignupUserInfoNormalState) return;
    emit(
      SignupUserInfoNormalState(
        formData: (state as SignupUserInfoNormalState)
            .formData
            .copyWith(password: event.password),
      ),
    );
  }

  // 닉네임 변경 이벤트 핸들러
  Future<void> _handleSignupUserUserNameChangeEvent(
    SignupUserNameChangedEvent event,
    Emitter<SignupUserInfoState> emit,
  ) async {
    if (state is! SignupUserInfoNormalState) return;
    emit(
      SignupUserInfoNormalState(
        formData: (state as SignupUserInfoNormalState)
            .formData
            .copyWith(userName: event.userName),
      ),
    );
  }

  // 생일 변경 이벤트 핸들러
  Future<void> _handleSignupUserBirthChangeEvent(
    SignupBirthChangedEvent event,
    Emitter<SignupUserInfoState> emit,
  ) async {
    if (state is! SignupUserInfoNormalState) return;
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
    if (state is! SignupUserInfoNormalState) return;
    emit(
      SignupUserInfoNormalState(
        formData: (state as SignupUserInfoNormalState)
            .formData
            .copyWith(phoneNum: event.phoneNum.replaceAll('-', '')),
      ),
    );
  }

  // 성별 변경 이벤트 핸들러
  Future<void> _handleSignupUserSexChangeEvent(
    SignupSexChangedEvent event,
    Emitter<SignupUserInfoState> emit,
  ) async {
    if (state is! SignupUserInfoNormalState) return;
    emit(
      SignupUserInfoNormalState(
        formData: (state as SignupUserInfoNormalState)
            .formData
            .copyWith(sex: event.sex),
      ),
    );
  }
}
