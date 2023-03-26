import 'package:equatable/equatable.dart';

/// 모델 없음 ///

abstract class SignupPhoneState extends Equatable {}

class SignupPhoneInitState extends SignupPhoneState {
  @override
  List<Object?> get props => [];
}

class SignupPhoneSendLoadingState extends SignupPhoneState {
  @override
  List<Object?> get props => [];
}

class SignupPhoneVerifyLoadingState extends SignupPhoneState {
  @override
  List<Object?> get props => [];
}

class SignupPhoneSendErrorState extends SignupPhoneState {
  final String message;

  SignupPhoneSendErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

class SignupPhoneVerifyErrorState extends SignupPhoneState {
  final String message;

  SignupPhoneVerifyErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

class SignupPhoneSendedState extends SignupPhoneState {
  final bool isSuccess;

  SignupPhoneSendedState({
    required this.isSuccess,
  });

  @override
  List<Object?> get props => [isSuccess];
}

class SignupPhoneVerifiedState extends SignupPhoneState {
  final bool isSuccess;

  SignupPhoneVerifiedState({
    required this.isSuccess,
  });

  @override
  List<Object?> get props => [isSuccess];
}
