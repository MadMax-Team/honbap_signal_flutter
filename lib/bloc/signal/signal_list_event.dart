abstract class SignalListEvent {}

class SignalListGetEvent extends SignalListEvent {
  final String jwt;

  SignalListGetEvent({required this.jwt});
}
