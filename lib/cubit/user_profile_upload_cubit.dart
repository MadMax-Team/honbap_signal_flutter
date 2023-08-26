import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/models/user/user_model.dart';
import 'package:honbap_signal_flutter/repository/honbab/user/user_profile_repository.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileUploadCubit extends Cubit<UserProfileUploadState> {
  final UserProfileRepository userProfileRepository;

  UserProfileUploadCubit({
    required UserProfileModel userProfile,
    required this.userProfileRepository,
  }) : super(UserProfileUploadState(
          profile: userProfile,
        ));

  void changeProfileImage(XFile? image) {
    if (image == null) return;

    var file = File(image.path);
    emit(state.copyWith(profileFile: file));
  }

  // for develop
  void uploadProfileImage({required String jwt}) async {
    if (state.profileFile == null) return;

    emit(state.copyWith(status: UserProfileUploadStatus.uploading));

    var imageUrl = await userProfileRepository.uploadProfileImage(
      jwt: jwt,
      profileFile: state.profileFile!,
    );

    emit(state.copyWith(status: UserProfileUploadStatus.updating));
  }

  // TODO: change all profile values
}

enum UserProfileUploadStatus {
  init,
  uploading, // 프로필 이미지 업로딩 상태
  updating, // 프로필 업데이트 상태
  success, // 변경 성공
  fail, // 변경 실패
}

class UserProfileUploadState extends Equatable {
  final UserProfileUploadStatus status;
  final File? profileFile;
  final UserProfileModel? profile;

  const UserProfileUploadState({
    this.status = UserProfileUploadStatus.init,
    this.profileFile,
    this.profile,
  });

  UserProfileUploadState copyWith({
    UserProfileUploadStatus? status,
    File? profileFile,
    UserProfileModel? profile,
  }) =>
      UserProfileUploadState(
        status: status ?? this.status,
        profileFile: profileFile ?? this.profileFile,
        profile: profile ?? this.profile,
      );

  @override
  List<Object?> get props => [
        status,
        profileFile,
        profile,
      ];
}
