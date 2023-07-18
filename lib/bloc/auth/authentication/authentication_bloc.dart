import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_event.dart';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_state.dart';
import 'package:honbap_signal_flutter/repository/honbab/auth/auth_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState>
    with ChangeNotifier {
  final HonbabAuthRepository _honbabAuthRepository;

  AuthenticationBloc(this._honbabAuthRepository)
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

    // TODO: login
    print('${event.platform}, ${event.email}, ${event.password}');
    var jwt = await _honbabAuthRepository.signin(
      platform: event.platform,
      email: event.email,
      password: event.password,
    );

    // jwt 저장
    const storage = FlutterSecureStorage();
    await storage.write(key: 'jwt', value: jwt);

    // splash 화면으로 돌아가기
    emit(const AuthenticationState(
      status: AuthenticationStatus.init,
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
