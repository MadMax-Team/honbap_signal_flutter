import 'package:equatable/equatable.dart';
import 'package:honbap_signal_flutter/models/signal/signal_list_model.dart';

/// [init] 초기 \
/// [loading] 로딩, 정보 받아오는 중 \
/// [success] 로딩 완료 \
/// [error] 처리 실패
///
/// [changing] 시그널 변경 중 \
enum SignalUserState {
  init,
  loading,
  success,
  error;

  const SignalUserState();
}

class SignalUserStateState extends Equatable {
  final SignalUserState state;
  final String? message;
  final SignalListModel userProfile;

  const SignalUserStateState({
    required this.state,
    this.message,
    required this.userProfile,
  });

  const SignalUserStateState.init()
      : state = SignalUserState.init,
        message = null,
        userProfile = const SignalListModel();

  SignalUserStateState copyWith({
    SignalUserState? state,
    String? message,
    SignalListModel? userProfile,
  }) =>
      SignalUserStateState(
        state: state ?? this.state,
        message: message ?? this.message,
        userProfile: userProfile ?? this.userProfile,
      );

  @override
  List<Object?> get props => [
    state,
    message,
    userProfile,
  ];
}
