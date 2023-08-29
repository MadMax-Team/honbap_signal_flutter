import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/cubit/user_cubit.dart';
import 'package:honbap_signal_flutter/cubit/user_profile_upload_cubit.dart';
import 'package:honbap_signal_flutter/models/mypage/mypage_model.dart';
import 'package:honbap_signal_flutter/screens/auth/widgets/auth_button_widget.dart';
import 'package:honbap_signal_flutter/screens/common/user_profile/widgets/user_profile_form_widget.dart';
import 'package:honbap_signal_flutter/screens/common/user_profile/widgets/user_profile_image_widget.dart';
import 'package:honbap_signal_flutter/screens/common/user_profile/widgets/user_profile_tags_widget.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  void _onChangeBtnTap(BuildContext context) {
    var jwt = context.read<UserCubit>().state.user!.jwt;
    var cubit = context.read<UserProfileUploadCubit>();
    if (cubit.state.profileFile == null) {
      context.read<UserProfileUploadCubit>().upload(jwt: jwt!);
    } else {
      context.read<UserProfileUploadCubit>().uploadWithImage(jwt: jwt!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          '프로필 설정',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
        child: ListView(
          children: const [
            UserProfileImageWidget(),
            UserProfileFormWidget(type: UserProfileForm.userName),
            Gaps.v32,
            UserProfileFormWidget(type: UserProfileForm.userIntroduce),
            Gaps.v10,
            UserProfileFormWidget(type: UserProfileForm.tags),
            UserProfileTagsWidget(type: UserProfileForm.tags),
            UserProfileFormWidget(type: UserProfileForm.preferArea),
            Gaps.v10,
            UserProfileTagsWidget(type: UserProfileForm.preferArea),
            UserProfileFormWidget(type: UserProfileForm.taste),
            Gaps.v10,
            UserProfileTagsWidget(type: UserProfileForm.taste),
            UserProfileFormWidget(type: UserProfileForm.hateFood),
            Gaps.v10,
            UserProfileTagsWidget(type: UserProfileForm.hateFood),
            UserProfileFormWidget(type: UserProfileForm.mbti),
            Gaps.v32,
          ],
        ),
      ),
      bottomNavigationBar:
          BlocConsumer<UserProfileUploadCubit, UserProfileUploadState>(
        listener: (context, state) {
          if (state.status == UserProfileUploadStatus.fail) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('프로필 변경에 실패했습니다.'),
                elevation: 0,
                backgroundColor: Theme.of(context).primaryColor,
              ),
            );
          }
        },
        builder: (context, state) => BottomAppBar(
          color: Theme.of(context).primaryColor,
          child: GestureDetector(
            onTap: () => _onChangeBtnTap(context),
            child: AuthBtnWidget(
              title: "프로필 설정 완료",
              bgColor: Theme.of(context).primaryColor,
              borderColor: Theme.of(context).primaryColor,
              textColor: Colors.white,
              borderRad: 0,
              isLoading: state.status == UserProfileUploadStatus.uploading,
            ),
          ),
        ),
      ),
    );
  }
}
