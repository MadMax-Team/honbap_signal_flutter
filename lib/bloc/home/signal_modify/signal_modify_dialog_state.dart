import 'package:equatable/equatable.dart';

enum SignalModifyDialogStatus {
  init('초기화'),
  loading('로딩'),
  success('성공'),
  error('에러');

  const SignalModifyDialogStatus(this.message);

  final String message;
}

class SignalModifyDialogState extends Equatable {
  final SignalModifyDialogStatus status;
  final String? message;
  final Map<String, dynamic>? signalData;

  const SignalModifyDialogState({
    this.status = SignalModifyDialogStatus.init,
    this.message,
    this.signalData,
  });

  SignalModifyDialogState copyWith({
    SignalModifyDialogStatus? status,
    String? message,
    Map<String, dynamic>? signalData,
  }) =>
      SignalModifyDialogState(
        status: status ?? this.status,
        message: message,
        signalData: signalData ?? this.signalData,
      );

  @override
  List<Object?> get props => [
    status,
    message,
    signalData,
  ];
}