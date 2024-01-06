import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/models/user/user_model.dart';
import 'package:honbap_signal_flutter/repository/honbab/user/user_profile_repository.dart';

class UserPWChangeCubit extends Cubit<UserPWChangeState> {
  final UserProfileRepository userProfileRepository;
  final UserModel userModel;

  UserPWChangeCubit({
    required this.userProfileRepository,
    required this.userModel,
  }) : super(const UserPWChangeState());

  void changeOldPW(String? value) {
    emit(state.copyWith(oldPassword: value));
  }

  void changeNewPW(String? value) {
    emit(state.copyWith(newPassword: value));
  }

  void updatePassword() async {
    emit(state.copyWith(status: UserPWChangeStatus.updating));

    final res = await userProfileRepository.updatePassword(
      jwt: userModel.jwt ?? '',
      pw: state.newPassword!,
      oldPw: state.oldPassword!,
    );

    if (res != null && res.code == 1000) {
      emit(state.copyWith(status: UserPWChangeStatus.success));
    } else {
      emit(state.copyWith(status: UserPWChangeStatus.failed));
    }
    emit(state.copyWith(status: UserPWChangeStatus.init));
  }
}

enum UserPWChangeStatus {
  init,
  updating,
  success,
  failed,
}

class UserPWChangeState extends Equatable {
  final UserPWChangeStatus status;
  final String? oldPassword;
  final String? newPassword;

  const UserPWChangeState({
    this.status = UserPWChangeStatus.init,
    this.oldPassword,
    this.newPassword,
  });

  UserPWChangeState copyWith({
    UserPWChangeStatus? status,
    String? oldPassword,
    String? newPassword,
  }) =>
      UserPWChangeState(
        status: status ?? this.status,
        oldPassword: oldPassword ?? this.oldPassword,
        newPassword: newPassword ?? this.newPassword,
      );

  @override
  List<Object?> get props => [
        status,
        oldPassword,
        newPassword,
      ];
}
