import 'package:honbap_signal_flutter/models/signal/signal_info_model.dart';
import 'package:honbap_signal_flutter/models/signal/signal_state_model.dart';

abstract class SignalStateEvent {}

/// 최초 시그널 정보 가져올 때 사용
///
class SignalStateGetEvent extends SignalStateEvent {
  SignalStateGetEvent();
}

/// 시그널 ON 시 사용
///
/// ---
/// 해당 이벤트가 호출되면 자동으로 [signal.state] 가 [SignalState.signaling] 상태로 변경됩니다.
class SignalStateOnEvent extends SignalStateEvent {
  final SignalInfoModel? signalInfo;

  SignalStateOnEvent({
    this.signalInfo,
  });
}

/// 시그널 OFF 시 사용
///
/// ---
/// 해당 이벤트가 호출되면 자동으로 [signal.state] 가 [SignalState.idle] 상태로 변경됩니다.
class SignalStateOffEvent extends SignalStateEvent {
  SignalStateOffEvent();
}

/// 매칭 종료 시 사용
///
/// ---
/// 해당 이벤트가 호출되면 자동으로 [signal.matched] 가 [SignalState.idle] 상태로 변경됩니다.
class MatchedSateSaveEvent extends SignalStateEvent {
  final int userIdx;
  final int applyIdx;

  MatchedSateSaveEvent({
    required this.userIdx,
    required this.applyIdx,
  });
}

/// 시그널의 변경시 사용
/// - 최초 매칭된 시그널
/// - 업데이트되는 매칭된 시그널
/// ---
/// 추천 [FCM] 응답코드 \
/// [10001], [11001]
/// ---
/// [FCM]으로 시그널 데이터가 들어오면 해당 시그널 정보을 전역적으로 관리하기 위해 사용합니다. \
/// 해당 이벤트가 호출되면 자동으로 [signal.state] 가 [SignalState.matched] 상태로 변경됩니다.
class SignalStateUpdateEvent extends SignalStateEvent {
  final SignalStateModel incomeSignal;

  SignalStateUpdateEvent({required this.incomeSignal});
}

/// 매칭 종료시 사용
/// - 홈에서 매칭 종료 버튼 클릭
/// ---
/// 추천 [FCM] 응답코드 \
/// [10002]
/// ---
/// [FCM]으로 매칭이 종료됨이 알려지면 시그널 정보를 초기화(삭제)하기 위해 사용합니다. \
/// 해당 이벤트가 호출되면 자동으로 [signal.state] 가 [SignalState.idle] 상태로 변경됩니다.
class SignalStateCloseMatchEvent extends SignalStateEvent {
  SignalStateCloseMatchEvent();
}
