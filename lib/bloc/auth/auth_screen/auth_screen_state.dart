import 'package:equatable/equatable.dart';

enum AuthScreenEnum {
  phoneCheck,
  phoneComplete,
  userInfo,
}

class AuthScreenState extends Equatable {
  final AuthScreenEnum screen;

  const AuthScreenState({
    required this.screen,
  });

  @override
  List<Object?> get props => [screen];
}
