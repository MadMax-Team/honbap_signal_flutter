import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/models/user/user_model.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserState());

  void setUserAuth({
    required String jwt,
    required int userIdx,
  }) {
    emit(state.copyWith(
      user: UserModel(
        jwt: jwt,
        userIdx: userIdx,
      ),
    ));
  }

  void setUserData(UserModel user) {
    emit(state.copyWith(
      user: state.user!.copyWith(
        userIdx: user.userIdx,
        userName: user.userName,
        birth: user.birth,
        email: user.email,
        phoneNum: user.phoneNum,
        sex: user.sex,
        updateAt: user.updateAt,
        createAt: user.createAt,
      ),
    ));
  }

  void setUserProfileData(UserProfileModel userProfile) {
    emit(state.copyWith(
      user: state.user!.copyWith(
        userProfile: userProfile,
      ),
    ));
  }
}

class UserState extends Equatable {
  final UserModel? user;

  const UserState({
    this.user,
  });

  UserState copyWith({
    UserModel? user,
  }) =>
      UserState(user: user ?? this.user);

  @override
  List<Object?> get props => [user];
}
