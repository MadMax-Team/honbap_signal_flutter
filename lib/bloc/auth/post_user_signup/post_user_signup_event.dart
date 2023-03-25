import 'package:equatable/equatable.dart';
import 'package:honbap_signal_flutter/models/auth/auth_signup_model.dart';

abstract class SignupUserEvent extends Equatable {
  const SignupUserEvent();

  @override
  List<Object?> get props => [];
}

// 회원가입 버튼 터치 이벤트
class SignupButtonPressedEvent extends SignupUserEvent {
  final AuthSignupModel formData;

  const SignupButtonPressedEvent({required this.formData});

  @override
  List<Object?> get props => [formData];
}

// 이메일 주소 변경 이벤트
class SignupEmailChangedEvent extends SignupUserEvent {
  final String email;

  const SignupEmailChangedEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

// 비밀번호 변경 이벤트
class SignupPasswordChangedEvent extends SignupUserEvent {
  final String password;

  const SignupPasswordChangedEvent({required this.password});

  @override
  List<Object?> get props => [password];
}

// 닉네임 변경 이벤트
class SignupNickNameChangedEvent extends SignupUserEvent {
  final String nickName;

  const SignupNickNameChangedEvent({required this.nickName});

  @override
  List<Object?> get props => [nickName];
}

// 생일 변경 이벤트
class SignupBirthChangedEvent extends SignupUserEvent {
  final String birth;

  const SignupBirthChangedEvent({required this.birth});

  @override
  List<Object?> get props => [birth];
}

// 핸드폰 번호 변겅 이벤트
class SignupPhoneNumChangedEvent extends SignupUserEvent {
  final String phoneNum;

  const SignupPhoneNumChangedEvent({required this.phoneNum});

  @override
  List<Object?> get props => [phoneNum];
}

// 성별 변경 이벤트
class SignupSexChangedEvent extends SignupUserEvent {
  final String sex;

  const SignupSexChangedEvent({required this.sex});

  @override
  List<Object?> get props => [sex];
}
