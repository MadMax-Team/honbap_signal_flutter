import 'package:equatable/equatable.dart';

abstract class SignalBoxDialogEvent extends Equatable {
  const SignalBoxDialogEvent();

  @override
  List<Object?> get props => [];
}

class GetSignalStateEvent extends SignalBoxDialogEvent {
  final String jwt;

  const GetSignalStateEvent({required this.jwt});

  @override
  List<Object?> get props => [jwt];
}

class SendSignalStateOffEvent extends SignalBoxDialogEvent {
  final String jwt;

  const SendSignalStateOffEvent({required this.jwt});

  @override
  List<Object?> get props => [jwt];
}

class SendSignalDataEvent extends SignalBoxDialogEvent {
  final String jwt;
  final String? sigPromiseTime;
  final String? sigPromiseArea;
  final String? sigPromiseMenu;

  const SendSignalDataEvent({
    required this.jwt,
    this.sigPromiseTime,
    this.sigPromiseArea,
    this.sigPromiseMenu,
  });

  @override
  List<Object?> get props => [jwt, sigPromiseTime, sigPromiseArea, sigPromiseMenu];
}

