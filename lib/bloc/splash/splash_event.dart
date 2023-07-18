import 'package:equatable/equatable.dart';
import 'package:honbap_signal_flutter/bloc/splash/splash_state.dart';

class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object?> get props => [];
}

class SplashChangeLoadStateEvent extends SplashEvent {
  final LoadStatus status;

  const SplashChangeLoadStateEvent({
    required this.status,
  });

  @override
  List<Object?> get props => [status];
}
