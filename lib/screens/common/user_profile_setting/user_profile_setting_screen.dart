import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_event.dart';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_state.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/cubit/user_cubit.dart';
import 'package:honbap_signal_flutter/cubit/user_profile_upload_cubit.dart';
import 'package:honbap_signal_flutter/models/mypage/mypage_model.dart';
import 'package:honbap_signal_flutter/screens/auth/widgets/auth_button_widget.dart';
import 'package:honbap_signal_flutter/screens/common/user_profile_setting/widgets/user_profile_setting_form_widget.dart';
import 'package:honbap_signal_flutter/screens/common/user_profile_setting/widgets/user_profile_setting_image_widget.dart';
import 'package:honbap_signal_flutter/screens/common/user_profile_setting/widgets/user_profile_setting_tags_widget.dart';

class UserProfileSettingScreen extends StatefulWidget {
  final bool isFirst;

  const UserProfileSettingScreen({
    super.key,
    this.isFirst = false,
  });

  @override
  State<UserProfileSettingScreen> createState() =>
      _UserProfileSettingScreenState();
}

class _UserProfileSettingScreenState extends State<UserProfileSettingScreen> {
  @override
  void initState() {
    super.initState();

    var initProfile = context.read<UserCubit>().state.user;
    context.read<UserProfileUploadCubit>().update(
          hateFood: initProfile?.userProfile?.hateFood?.split(','),
          mbti: initProfile?.userProfile?.mbti,
          nickName: initProfile?.userProfile?.nickName,
          preferArea: initProfile?.userProfile?.preferArea?.split(','),
          profileImg: initProfile?.userProfile?.profileImg,
          tags: initProfile?.userProfile?.interest?.split(','),
          taste: initProfile?.userProfile?.taste?.split(','),
          userIntroduce: initProfile?.userProfile?.userIntroduce,
        );
  }

  void _onChangeBtnTap(BuildContext context) {
    var jwt = context.read<UserCubit>().state.user!.jwt;
    var cubit = context.read<UserProfileUploadCubit>();

    if (cubit.state.profile?.nickName?.isNotEmpty == false) {
      cubit.nickNameFocus();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('닉네임을 입력해주세요'),
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
      return;
    }

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
        leading: widget.isFirst
            ? null
            : IconButton(
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
        child: BlocBuilder<UserProfileUploadCubit, UserProfileUploadState>(
          builder: (context, state) => ListView(
            children: [
              Gaps.v10,
              const UserProfileSettingImageWidget(),
              UserProfileSettingFormWidget(
                type: UserProfileForm.nickName,
                enableBox: false,
                initValue: state.profile?.nickName,
              ),
              Gaps.v32,
              UserProfileSettingFormWidget(
                type: UserProfileForm.userIntroduce,
                enableBox: false,
                initValue: state.profile?.userIntroduce,
              ),
              Gaps.v10,
              const UserProfileSettingFormWidget(type: UserProfileForm.tags),
              Gaps.v5,
              const UserProfileSettingTagsWidget(type: UserProfileForm.tags),
              const UserProfileSettingFormWidget(
                  type: UserProfileForm.preferArea),
              Gaps.v10,
              const UserProfileSettingTagsWidget(
                  type: UserProfileForm.preferArea),
              const UserProfileSettingFormWidget(type: UserProfileForm.taste),
              Gaps.v10,
              const UserProfileSettingTagsWidget(type: UserProfileForm.taste),
              const UserProfileSettingFormWidget(
                  type: UserProfileForm.hateFood),
              Gaps.v10,
              const UserProfileSettingTagsWidget(
                  type: UserProfileForm.hateFood),
              UserProfileSettingFormWidget(
                type: UserProfileForm.mbti,
                initValue: state.profile?.mbti,
              ),
              Gaps.v32,
            ],
          ),
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
          if (state.status == UserProfileUploadStatus.success) {
            // Update user profile
            context
                .read<UserCubit>()
                .setUserProfileData(state.profile!.toUserProfileModel()!);
            // Goto /home
            context.read<AuthenticationBloc>().add(const AuthenticaionSetState(
                  status: AuthenticationStatus.authenticated,
                ));
            if (!widget.isFirst) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('프로필을 성공적으로 저장했습니다.'),
                  elevation: 0,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              );
            }
          }
        },
        builder: (context, state) => BottomAppBar(
          padding: EdgeInsets.zero,
          height: Sizes.size52,
          child: GestureDetector(
            onTap: state.status == UserProfileUploadStatus.uploading
                ? null
                : () => _onChangeBtnTap(context),
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
