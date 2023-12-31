abstract class SignalUserStateEvent {}

/// 상대 유저의 프로필 정보 가져올 때 사용
///
class SignalUserStateGetEvent extends SignalUserStateEvent {
  final int userIdx;

  SignalUserStateGetEvent(
      this.userIdx,
  );
}

/// 상태 초기화를 위해 사용
class SignalUserStateResetEvent extends SignalUserStateEvent {}
