abstract class SignalBoxDialogsEvent {}

class SignalBoxDialogEvent extends SignalBoxDialogsEvent {
  final String jwt;

  SignalBoxDialogEvent({required this.jwt});
}