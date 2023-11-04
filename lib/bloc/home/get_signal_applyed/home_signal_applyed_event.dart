abstract class HomeSignalApplyedEvent {}

class HomeSignalApplyedGetEvent extends HomeSignalApplyedEvent {
  final String jwt;

  HomeSignalApplyedGetEvent({required this.jwt});
}