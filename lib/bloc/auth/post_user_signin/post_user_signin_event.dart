import 'package:equatable/equatable.dart';

abstract class SinginUserEvent extends Equatable {
  const SinginUserEvent();

  @override
  List<Object?> get props => [];
}

// 로그인 버튼 터치 이벤트
class SigninButtonTapEvent extends SinginUserEvent {
  const SigninButtonTapEvent();

  @override
  List<Object?> get props => [];
}

// 이메을 주소 변경 이벤트
class SigninEmailChangeEvent extends SinginUserEvent {
  final String email;

  const SigninEmailChangeEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

// 비밀번호 변경 이벤트
class SigninPasswordChangeEvent extends SinginUserEvent {
  final String password;

  const SigninPasswordChangeEvent({required this.password});

  @override
  List<Object?> get props => [password];
}
