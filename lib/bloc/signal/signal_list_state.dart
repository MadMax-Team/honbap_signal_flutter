import 'package:equatable/equatable.dart';
import 'package:honbap_signal_flutter/models/signal/signal_list_model.dart';

enum SignalListStatus {
  init('초기화'),
  loading('로딩'),
  success('성공'),
  error('에러');

  const SignalListStatus(this.message);

  final String message;
}

class SignalListState extends Equatable {
  final SignalListStatus status;
  final List<SignalListModel> signals;
  final String? message;

  const SignalListState({
    this.status = SignalListStatus.init,
    this.signals = const [],
    this.message,
  });

  SignalListState copyWith({
    SignalListStatus? status,
    List<SignalListModel>? signals,
    String? message,
  }) =>
      SignalListState(
        status: status ?? this.status,
        signals: signals ?? this.signals,
        message: message,
      );

  @override
  List<Object?> get props => [
        status,
        signals,
        message,
      ];
}
