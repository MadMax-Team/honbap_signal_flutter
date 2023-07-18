import 'package:equatable/equatable.dart';

enum LoadStatus {
  loadingAuth("로그인 체크");

  final String message;

  const LoadStatus(this.message);
}

class SplashState extends Equatable {
  final LoadStatus status;

  const SplashState({
    required this.status,
  });

  @override
  List<Object?> get props => [status];
}
