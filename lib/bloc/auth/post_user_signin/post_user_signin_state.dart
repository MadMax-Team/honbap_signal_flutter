import 'package:equatable/equatable.dart';

class SigninUserState extends Equatable {
  final String? email;
  final String? password;

  const SigninUserState({
    this.email,
    this.password,
  });

  SigninUserState copyWith({
    String? email,
    String? password,
  }) =>
      SigninUserState(
        email: email ?? this.email,
        password: password ?? this.password,
      );

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}

class SinginUserLoadingState extends SigninUserState {
  const SinginUserLoadingState({
    String? email,
    String? password,
  }) : super(
          email: email,
          password: password,
        );

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}

class SigninUserSuccessState extends SigninUserState {
  final int? userIdx;
  final String? jwt;

  const SigninUserSuccessState({
    String? email,
    String? password,
    this.userIdx,
    this.jwt,
  }) : super(
          email: email,
          password: password,
        );

  @override
  List<Object?> get props => [
        email,
        password,
        userIdx,
        jwt,
      ];
}

class SigninUserErrorState extends SigninUserState {
  final int? code;
  final String? message;

  const SigninUserErrorState({
    String? email,
    String? password,
    this.code,
    this.message,
  }) : super(
          email: email,
          password: password,
        );

  @override
  List<Object?> get props => [
        email,
        password,
        code,
        message,
      ];
}
