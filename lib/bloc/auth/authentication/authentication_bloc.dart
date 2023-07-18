import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_event.dart';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState>
    with ChangeNotifier {
  AuthenticationBloc()
      : super(const AuthenticationState(status: AuthenticationStatus.init)) {
    on<AuthenticaionSetState>(_authenticaionSetStateHandler);
    on<AuthenticationLogin>(_authenticationLoginHandler);
    on<AuthenticationLogout>(_authenticationLogoutHandler);
  }

  Future<void> _authenticaionSetStateHandler(
    AuthenticaionSetState event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationState(status: event.status));

    notifyListeners();
  }

  Future<void> _authenticationLoginHandler(
    AuthenticationLogin event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const AuthenticationState(status: AuthenticationStatus.loading));

    print('${event.platform}, ${event.email}, ${event.password}');
    // TODO: login

    emit(AuthenticationState(
      status: AuthenticationStatus.authenticated,
      platform: event.platform,
    ));

    notifyListeners();
  }

  Future<void> _authenticationLogoutHandler(
    AuthenticationLogout event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const AuthenticationState(status: AuthenticationStatus.loading));

    // TODO: Logout

    emit(const AuthenticationState(
      status: AuthenticationStatus.unauthenticated,
    ));
  }
}
