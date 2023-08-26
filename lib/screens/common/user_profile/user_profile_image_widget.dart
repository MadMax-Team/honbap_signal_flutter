import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/cubit/user_profile_upload_cubit.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileImageWidget extends StatelessWidget {
  const UserProfileImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _UserProfileImageField(),
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
    return Center(
      child: GestureDetector(
        onTap: () async {
          var image = await _picker.pickImage(
            source: ImageSource.gallery,
            imageQuality: 40,
            maxWidth: 200,
            maxHeight: 200,
          );
          context.read<UserProfileUploadCubit>().changeProfileImage(image);
        },
        child: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          radius: Sizes.size52,
          backgroundImage: profileFile == null
              ? Image.asset('assets/images/honbab_smile.png').image
              : Image.file(profileFile).image,
        ),
      ),
    );
  }
}
