import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    context.read<UserProfileUploadCubit>().uploadProfileImage(jwt: jwt!);
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
        padding: const EdgeInsets.all(Sizes.size20),
        child: ListView(
          children: const [
            UserProfileImageWidget(),
            UserProfileFormWidget(type: UserProfileForm.userName),
            UserProfileFormWidget(type: UserProfileForm.userIntroduce),
            UserProfileFormWidget(type: UserProfileForm.tags),
            UserProfileTagsWidget(),
          ],
        ),
      ),
      bottomNavigationBar:
          BlocConsumer<UserProfileUploadCubit, UserProfileUploadState>(
        listener: (context, state) {
          // if (state is SigninUserErrorState && state.code == 1003) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(
          //       content: Text(state.message ?? '로그인에 실패했습니다.'),
          //       elevation: 0,
          //       backgroundColor: Theme.of(context).primaryColor,
          //     ),
          //   );
          // }
          // if (state is SigninUserSuccessState) {
          //   _onLoginSuccess(user: state);
          // }
        },
        builder: (context, state) => BottomAppBar(
          color: Theme.of(context).primaryColor,
          child: GestureDetector(
            onTap: () => _onChangeBtnTap(context),
            child: AuthBtnWidget(
              title: "변경하기",
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
