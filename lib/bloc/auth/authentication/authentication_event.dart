import 'package:equatable/equatable.dart';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_state.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class AuthenticaionSetState extends AuthenticationEvent {
  final AuthenticationStatus status;

  const AuthenticaionSetState({
    required this.status,
  });

  @override
  List<Object?> get props => [status];
}

class AuthenticationLogin extends AuthenticationEvent {
  final AuthenticationWith platform;
  final String? email;
  final String? password;

  const AuthenticationLogin({
    required this.platform,
    this.email,
    this.password,
  });

  @override
  List<Object?> get props => [
        platform,
        email,
        password,
      ];
}

class AuthenticationLogout extends AuthenticationEvent {
  const AuthenticationLogout();

  @override
  List<Object?> get props => [];
}
