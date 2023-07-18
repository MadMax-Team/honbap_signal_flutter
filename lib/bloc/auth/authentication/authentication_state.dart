import 'package:equatable/equatable.dart';

enum AuthenticationStatus {
  init,
  unauthenticated,
  authenticated,
  loading,
  error,
}

enum AuthenticationWith {
  honbab,
  kakao,
}

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final AuthenticationWith? platform;

  const AuthenticationState({
    required this.status,
    this.platform,
  });

  AuthenticationState copyWith({
    AuthenticationStatus? status,
    AuthenticationWith? platform,
  }) =>
      AuthenticationState(
        status: status ?? this.status,
        platform: platform ?? this.platform,
      );

  @override
  List<Object?> get props => [status, platform];
}
