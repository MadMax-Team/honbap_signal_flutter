abstract class HomeSignalApplyEvent {}

class HomeSignalApplyGetEvent extends HomeSignalApplyEvent {
  final String jwt;

  HomeSignalApplyGetEvent({required this.jwt});
}