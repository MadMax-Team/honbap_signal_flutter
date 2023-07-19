import 'package:honbap_signal_flutter/bloc/splash/splash_event.dart';
import 'package:honbap_signal_flutter/bloc/splash/splash_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashState(status: LoadStatus.init)) {
    on<SplashChangeLoadStateEvent>(_splashChangeLoadStateEventHandler);
  }

  Future<void> _splashChangeLoadStateEventHandler(
    SplashChangeLoadStateEvent event,
    Emitter<SplashState> emit,
  ) async {
    emit(SplashState(status: event.status));
  }
}
