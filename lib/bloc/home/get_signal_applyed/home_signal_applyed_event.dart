abstract class HomeSignalApplyedEvent {}

class HomeSignalApplyedGetEvent extends HomeSignalApplyedEvent {
  final String jwt;

  HomeSignalApplyedGetEvent({required this.jwt});
}

class HomeSignalApplyedAcceptEvent extends HomeSignalApplyedEvent {
  final String jwt;
  final int matchedIdx;

  HomeSignalApplyedAcceptEvent({
    required this.jwt,
    required this.matchedIdx,
  });
}

class HomeSignalApplyedDeleteEvent extends HomeSignalApplyedEvent {
  final String jwt;
  final int userIdx;
  final int applyedIdx;

  HomeSignalApplyedDeleteEvent({
    required this.jwt,
    required this.userIdx,
    required this.applyedIdx,
  });
}
