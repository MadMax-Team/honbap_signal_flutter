import 'package:equatable/equatable.dart';
import 'package:honbap_signal_flutter/models/signal/signal_state_model.dart';

/// [idle] 평상시 \
/// [signaling] 시그널 ON \
/// [matched] 매치 중
enum SignalState {
  idle,
  signaling,
  matched;

  const SignalState();
}

class SignalStateState extends Equatable {
  final SignalState state;
  final SignalStateModel signal;

  const SignalStateState({
    required this.state,
    required this.signal,
  });

  const SignalStateState.init()
      : state = SignalState.idle,
        signal = const SignalStateModel();

  SignalStateState copyWith({
    SignalState? state,
    SignalStateModel? signal,
  }) =>
      SignalStateState(
        state: state ?? this.state,
        signal: signal ?? this.signal,
      );

  @override
  List<Object?> get props => [
        state,
        signal,
      ];
}
