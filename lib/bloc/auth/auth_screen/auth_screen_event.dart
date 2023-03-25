import 'package:equatable/equatable.dart';

import 'auth_screen_state.dart';

class AuthScreenEvent extends Equatable {
  final AuthScreenEnum screen;

  const AuthScreenEvent({
    required this.screen,
  });

  @override
  List<Object?> get props => [screen];
}
