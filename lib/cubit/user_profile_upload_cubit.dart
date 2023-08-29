import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/models/mypage/mypage_model.dart';
import 'package:honbap_signal_flutter/models/user/user_model.dart';
import 'package:honbap_signal_flutter/repository/honbab/user/user_profile_repository.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileUploadCubit extends Cubit<UserProfileUploadState> {
  final UserProfileRepository userProfileRepository;

  UserProfileUploadCubit({
    required UserProfileModel? userProfile,
    required this.userProfileRepository,
  }) : super(UserProfileUploadState(
          profile: MyPageModel.fromUserProfileModel(userProfile),
        ));

  void changeProfileImage(XFile? image) {
    if (image == null) {
      emit(state.copyWith(profileFile: null));
      return;
    }

    var file = File(image.path);
    emit(state.copyWith(profileFile: file));
  }

  void uploadWithImage({required String jwt}) async {
    print('image');
    if (state.profileFile == null) return;

    emit(state.copyWith(status: UserProfileUploadStatus.uploading));

    try {
      var imageUrl = await userProfileRepository.uploadProfileImage(
        jwt: jwt,
        profileFile: state.profileFile!,
      );

      if (imageUrl == null) {
        emit(state.copyWith(status: UserProfileUploadStatus.fail));
        emit(state.copyWith(status: UserProfileUploadStatus.init));
        return;
      }

      emit(state.copyWith(
        profile: state.profile?.copyWith(profileImg: imageUrl),
      ));
      upload(jwt: jwt);
    } catch (e) {
      emit(state.copyWith(status: UserProfileUploadStatus.fail));
      emit(state.copyWith(status: UserProfileUploadStatus.init));
    }
  }

  void upload({required String jwt}) async {
    print('upload');
  }

  void update({
    String? profileImg,
    String? userName,
    String? userIntroduce,
    List<String>? tags,
    List<String>? preferArea,
    List<String>? taste,
    List<String>? hateFood,
    String? mbti,
  }) {
    emit(state.copyWith(
      profile: state.profile?.copyWith(
        profileImg: profileImg,
        userName: userName,
        userIntroduce: userIntroduce,
        tags: tags,
        preferArea: preferArea,
        taste: taste,
        hateFood: hateFood,
        mbti: mbti,
      ),
    ));
  }
}

enum UserProfileUploadStatus {
  init,
  uploading,
  success,
  fail,
}

class UserProfileUploadState extends Equatable {
  final UserProfileUploadStatus status;
  final File? profileFile;
  final MyPageModel? profile;

  const UserProfileUploadState({
    this.status = UserProfileUploadStatus.init,
    this.profileFile,
    this.profile,
  });

  UserProfileUploadState copyWith({
    UserProfileUploadStatus? status,
    File? profileFile,
    MyPageModel? profile,
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
