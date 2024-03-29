import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/cubit/user_cubit.dart';
import 'package:honbap_signal_flutter/cubit/user_profile_upload_cubit.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileSettingImageWidget extends StatelessWidget {
  const UserProfileSettingImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '나의 프로필',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Column(
          children: [
            _UserProfileImageField(),
            Gaps.v10,
            const Text('사진변경'),
          ],
        ),
      ],
    );
  }
}

class _UserProfileImageField extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  _UserProfileImageField();

  @override
  Widget build(BuildContext context) {
    var profileFile = context.select<UserProfileUploadCubit, File?>(
        (cubit) => cubit.state.profileFile);
    var originProfileImg =
        context.read<UserCubit>().state.user?.userProfile?.profileImg;
    return Center(
      child: GestureDetector(
        onTap: () async {
          try {
            var image = await _picker.pickImage(
              source: ImageSource.gallery,
              imageQuality: 40,
              maxWidth: 200,
              maxHeight: 200,
            );
            context.read<UserProfileUploadCubit>().changeProfileImage(image);
          } catch (e) {
            context.read<UserProfileUploadCubit>().changeProfileImage(null);
          }
        },
        child: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          radius: Sizes.size72,
          backgroundImage: profileFile == null && originProfileImg != null
              ? Image.network(originProfileImg).image
              : profileFile == null
                  ? Image.asset('assets/images/honbab_smile.png').image
                  : Image.file(profileFile).image,
        ),
      ),
    );
  }
}
