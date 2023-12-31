import 'package:equatable/equatable.dart';
import 'package:honbap_signal_flutter/models/signal/signal_state_model.dart';

/// [idle] 평상시 \
/// [signaling] 시그널 ON \
/// [matched] 매치 중 \
/// [init] 최초 상태 \
/// [loading] 로딩, 정보 받아오는 중 \
/// [error] 처리 실패
///
/// [changing] 시그널 변경 중 \
enum SignalState {
  idle,
  signaling,
  matched,
  init,
  loading,
  changing,
  error;

  const SignalState();
}

class SignalStateState extends Equatable {
  final SignalState state;
  final String? message;
  final SignalStateModel signal;

  const SignalStateState({
    required this.state,
    this.message,
    required this.signal,
  });

  const SignalStateState.init()
      : state = SignalState.init,
        message = null,
        signal = const SignalStateModel();

  SignalStateState copyWith({
    SignalState? state,
    String? message,
    SignalStateModel? signal,
  }) =>
      SignalStateState(
        state: state ?? this.state,
        message: message ?? this.message,
        signal: signal ?? this.signal,
      );

  @override
  List<Object?> get props => [
        state,
        message,
        signal,
      ];
}
