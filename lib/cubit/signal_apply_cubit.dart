import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/models/user/user_model.dart';
import 'package:honbap_signal_flutter/repository/honbab/signal/signal_list_repository.dart';

class SignalApplyCubit extends Cubit<SignalApplyState> {
  final HonbabSignalListRepository signalRepository;
  final UserModel userModel;

  SignalApplyCubit({
    required this.signalRepository,
    required this.userModel,
  }) : super(const SignalApplyState());

  void applySignal() async {
    emit(const SignalApplyState(status: SignalApplyStatus.loading));

    // TODO: update indexies
    final res = await signalRepository.postSignalList(
      jwt: userModel.jwt ?? '',
      userIdx: 0,
      applyedIdx: 0,
    );

    if (res.code == 1000) {
      emit(const SignalApplyState(status: SignalApplyStatus.loaded));
    } else {
      emit(SignalApplyState(
        status: SignalApplyStatus.error,
        message: res.message,
      ));
    }
  }
}

enum SignalApplyStatus {
  init,
  loading,
  loaded,
  error,
}

class SignalApplyState extends Equatable {
  final SignalApplyStatus status;
  final String? message;

  const SignalApplyState({
    this.status = SignalApplyStatus.init,
    this.message,
  });

  @override
  List<Object?> get props => [
        status,
        message,
      ];
}
