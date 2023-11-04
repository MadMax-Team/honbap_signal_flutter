import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/cubit/user_profile_upload_cubit.dart';
import 'package:honbap_signal_flutter/models/mypage/mypage_model.dart';

class UserProfileSettingTagsWidget extends StatelessWidget {
  final UserProfileForm type;

  const UserProfileSettingTagsWidget({
    super.key,
    required this.type,
  });

  void _onTap(BuildContext context, String tag) {
    switch (type) {
      case UserProfileForm.tags:
        {
          var prev =
              context.read<UserProfileUploadCubit>().state.profile?.tags ?? [];
          prev.remove(tag);

          context.read<UserProfileUploadCubit>().update(tags: List.from(prev));
          break;
        }
      case UserProfileForm.preferArea:
        {
          var prev = context
                  .read<UserProfileUploadCubit>()
                  .state
                  .profile
                  ?.preferArea ??
              [];
          prev.remove(tag);

          context
              .read<UserProfileUploadCubit>()
              .update(preferArea: List.from(prev));
          break;
        }
      case UserProfileForm.taste:
        {
          var prev =
              context.read<UserProfileUploadCubit>().state.profile?.taste ?? [];
          prev.remove(tag);

          context.read<UserProfileUploadCubit>().update(taste: List.from(prev));
          break;
        }
      case UserProfileForm.hateFood:
        {
          var prev =
              context.read<UserProfileUploadCubit>().state.profile?.hateFood ??
                  [];
          prev.remove(tag);

          context
              .read<UserProfileUploadCubit>()
              .update(hateFood: List.from(prev));
          break;
        }
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileUploadCubit, UserProfileUploadState>(
      buildWhen: (previous, current) {
        switch (type) {
          case UserProfileForm.tags:
            return previous.profile?.tags != current.profile?.tags;
          case UserProfileForm.preferArea:
            return previous.profile?.preferArea != current.profile?.preferArea;
          case UserProfileForm.taste:
            return previous.profile?.taste != current.profile?.taste;
          case UserProfileForm.hateFood:
            return previous.profile?.hateFood != current.profile?.hateFood;
          default:
            return false;
        }
      },
      builder: (context, state) {
        var list = [];
        switch (type) {
          case UserProfileForm.tags:
            list = state.profile?.tags ?? [];
          case UserProfileForm.preferArea:
            list = state.profile?.preferArea ?? [];
          case UserProfileForm.taste:
            list = state.profile?.taste ?? [];
          case UserProfileForm.hateFood:
            list = state.profile?.hateFood ?? [];
          default:
            list = [];
        }
        return Padding(
          padding: const EdgeInsets.only(bottom: Sizes.size32),
          child: Wrap(
            spacing: Sizes.size3,
            runSpacing: Sizes.size7,
            children: [
              for (var tag in list)
                GestureDetector(
                  onTap: () => _onTap(
                    context,
                    tag,
                  ),
                  child: _UserProfileTagWidget(
                    value: tag,
                    isSquare: type != UserProfileForm.tags,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _UserProfileTagWidget extends StatelessWidget {
  final String value;
  final bool isSquare;

  const _UserProfileTagWidget({
    required this.value,
    required this.isSquare,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.size6,
        horizontal: Sizes.size8,
      ),
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(isSquare ? Sizes.size5 : Sizes.size20),
        color: isSquare ? Colors.white : Theme.of(context).primaryColor,
        border: isSquare
            ? Border.all(
                color: Colors.black26,
                width: Sizes.size1,
              )
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: TextStyle(
              color: isSquare ? Colors.black87 : Colors.white,
            ),
          ),
          Gaps.h5,
          Icon(
            Icons.cancel,
            color: isSquare ? Theme.of(context).primaryColor : Colors.white,
            size: Sizes.size16,
          ),
        ],
      ),
    );
  }
}
