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

  const SignalModifyDialogState({
    this.status = SignalModifyDialogStatus.init,
    this.message,
  });

  SignalModifyDialogState copyWith({
    SignalModifyDialogStatus? status,
    String? message,
  }) =>
      SignalModifyDialogState(
        status: status ?? this.status,
        message: message,
      );

  @override
  List<Object?> get props => [
    status,
    message
  ];
}