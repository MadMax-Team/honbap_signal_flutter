abstract class HomeSignalApplyEvent {}

class HomeSignalApplyGetEvent extends HomeSignalApplyEvent {
  final String jwt;

  HomeSignalApplyGetEvent({required this.jwt});
}

class HomeSignalApplyDeleteEvent extends HomeSignalApplyEvent {
  final String jwt;
  final int userIdx;
  final int applyedIdx;

  HomeSignalApplyDeleteEvent({
    required this.jwt,
    required this.userIdx,
    required this.applyedIdx,
  });

  @override
  List<Object?> get props => [jwt, userIdx, applyedIdx];
}
