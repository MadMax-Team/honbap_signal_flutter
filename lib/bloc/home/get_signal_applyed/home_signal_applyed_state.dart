import 'package:equatable/equatable.dart';

import '../../../models/home/home_signal_applyed_list_model.dart';

enum HomeSignalApplyedStatus {
  init('초기화'),
  loading('로딩'),
  success('성공'),
  error('에러');

  const HomeSignalApplyedStatus(this.message);

  final String message;
}

class HomeSignalApplyedState extends Equatable {
  final HomeSignalApplyedStatus status;
  final List<HomeSignalApplyedListModel> signalApply;
  final String? message;

  const HomeSignalApplyedState({
    this.status = HomeSignalApplyedStatus.init,
    this.signalApply = const [],
    this.message,
  });

  HomeSignalApplyedState copyWith({
    HomeSignalApplyedStatus? status,
    List<HomeSignalApplyedListModel>? signalApply,
    String? message,
  }) =>
      HomeSignalApplyedState(
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