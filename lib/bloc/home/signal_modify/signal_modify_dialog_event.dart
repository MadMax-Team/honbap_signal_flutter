import 'package:equatable/equatable.dart';

abstract class SignalModifyEvent extends Equatable {
  const SignalModifyEvent();

  @override
  List<Object?> get props => [];
}

class GetSignalStateDetailEvent extends SignalModifyEvent {
  final String jwt;

  const GetSignalStateDetailEvent({required this.jwt});

  @override
  List<Object?> get props => [jwt];
}

