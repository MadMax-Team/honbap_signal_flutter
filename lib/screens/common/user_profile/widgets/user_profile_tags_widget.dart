import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/cubit/user_profile_upload_cubit.dart';

class UserProfileTagsWidget extends StatelessWidget {
  const UserProfileTagsWidget({super.key});

  void _onTap(BuildContext context, String tag) {
    var prev = context.read<UserProfileUploadCubit>().state.profile?.tags ?? [];
    prev.remove(tag);

    context.read<UserProfileUploadCubit>().update(tags: List.from(prev));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileUploadCubit, UserProfileUploadState>(
      buildWhen: (previous, current) =>
          previous.profile?.tags != current.profile?.tags,
      builder: (context, state) => Wrap(
        children: [
          for (var tag in state.profile?.tags ?? [])
            GestureDetector(
              onTap: () => _onTap(
                context,
                tag,
              ),
              child: _UserProfileTagWidget(
                value: tag,
              ),
            ),
        ],
      ),
    );
  }
}

class _UserProfileTagWidget extends StatelessWidget {
  final String value;

  const _UserProfileTagWidget({
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.size2,
        horizontal: Sizes.size4,
      ),
      margin: const EdgeInsets.only(left: Sizes.size3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size10),
        color: Theme.of(context).primaryColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
