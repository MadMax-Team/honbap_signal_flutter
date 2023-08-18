import 'package:equatable/equatable.dart';

enum SignalBoxDialogStatus {
  init('초기화'),
  onState('on 상태'),
  offState('off 상태'),
  onSuccess('on 성공'),
  offSuccess('off 성공'),
  loading('로딩'),
  error('에러');

  const SignalBoxDialogStatus(this.message);

  final String message;
}

class SignalBoxDialogState extends Equatable {
  final SignalBoxDialogStatus status;
  final String? message;

  const SignalBoxDialogState({
    this.status = SignalBoxDialogStatus.init,
    this.message,
  });

  SignalBoxDialogState copyWith({
    SignalBoxDialogStatus? status,
    String? message,
  }) =>
      SignalBoxDialogState(
        status: status ?? this.status,
        message: message,
      );

  @override
  List<Object?> get props => [
    status,
    message
  ];
}