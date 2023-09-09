import 'package:equatable/equatable.dart';

import '../../../models/home/home_signal_apply_list_model.dart';

enum HomeSignalApplyStatus {
  init('초기화'),
  loading('로딩'),
  success('성공'),
  error('에러');

  const HomeSignalApplyStatus(this.message);

  final String message;
}

class HomeSignalApplyState extends Equatable {
  final HomeSignalApplyStatus status;
  final List<HomeSignalApplyListModel> signalApply;
  final String? message;

  const HomeSignalApplyState({
    this.status = HomeSignalApplyStatus.init,
    this.signalApply = const [],
    this.message,
  });

  HomeSignalApplyState copyWith({
    HomeSignalApplyStatus? status,
    List<HomeSignalApplyListModel>? signalApply,
    String? message,
  }) =>
      HomeSignalApplyState(
        status: status ?? this.status,
        signalApply: signalApply ?? this.signalApply,
        message: message,
      );


  @override
  List<Object?> get props => [
    status,
    signalApply,
    message,
  ];

}