import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/cubit/user_profile_upload_cubit.dart';
import 'package:honbap_signal_flutter/models/mypage/mypage_model.dart';

class UserProfileFormWidget extends StatefulWidget {
  final UserProfileForm type;
  final bool enableBox;
  final String? initValue;

  const UserProfileFormWidget({
    super.key,
    required this.type,
    this.enableBox = true,
    this.initValue,
  });

  @override
  State<UserProfileFormWidget> createState() => _UserProfileFormWidgetState();
}

class _UserProfileFormWidgetState extends State<UserProfileFormWidget> {
  final _fieldKey = GlobalKey<FormFieldState<String>>();
  final _focusNode = FocusNode();

  void _onChanged(String value) {
    switch (widget.type) {
      case UserProfileForm.nickName:
        {
          context.read<UserProfileUploadCubit>().update(nickName: value);
          break;
        }
      case UserProfileForm.userIntroduce:
        {
          context.read<UserProfileUploadCubit>().update(userIntroduce: value);
          break;
        }
      case UserProfileForm.mbti:
        {
          context.read<UserProfileUploadCubit>().update(mbti: value);
          break;
        }
      default:
        {
          if (value.contains(',')) {
            _onFieldSubmitted(value.replaceAll(',', ''));
          }
          break;
        }
    }
  }

  void _onFieldSubmitted(String value) {
    switch (widget.type) {
      case UserProfileForm.tags:
        {
          if (value.isNotEmpty) {
            var prev =
                context.read<UserProfileUploadCubit>().state.profile?.tags ??
                    [];
            prev.add(value);

            context
                .read<UserProfileUploadCubit>()
                .update(tags: List.from(prev));
          }

          _fieldKey.currentState?.reset();
          _focusNode.requestFocus();
          break;
        }
      case UserProfileForm.preferArea:
        {
          if (value.isNotEmpty) {
            var prev = context
                    .read<UserProfileUploadCubit>()
                    .state
                    .profile
                    ?.preferArea ??
                [];
            prev.add(value);

            context
                .read<UserProfileUploadCubit>()
                .update(preferArea: List.from(prev));
          }

          _fieldKey.currentState?.reset();
          _focusNode.requestFocus();
          break;
        }
      case UserProfileForm.taste:
        {
          if (value.isNotEmpty) {
            var prev =
                context.read<UserProfileUploadCubit>().state.profile?.taste ??
                    [];
            prev.add(value);

            context
                .read<UserProfileUploadCubit>()
                .update(taste: List.from(prev));
          }

          _fieldKey.currentState?.reset();
          _focusNode.requestFocus();
          break;
        }
      case UserProfileForm.hateFood:
        {
          if (value.isNotEmpty) {
            var prev = context
                    .read<UserProfileUploadCubit>()
                    .state
                    .profile
                    ?.hateFood ??
                [];
            prev.add(value);

            context
                .read<UserProfileUploadCubit>()
                .update(hateFood: List.from(prev));
          }

          _fieldKey.currentState?.reset();
          _focusNode.requestFocus();
          break;
        }
      case UserProfileForm.mbti:
        {
          FocusScope.of(context).unfocus();
          break;
        }
      default:
        {
          FocusScope.of(context).nextFocus();
          break;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.type.message,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        if (widget.enableBox) Gaps.v10,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: TextFormField(
                key: _fieldKey,
                focusNode: _focusNode,
                initialValue: widget.initValue,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                enableSuggestions: false,
                maxLength: widget.type == UserProfileForm.userIntroduce
                    ? 50
                    : widget.type == UserProfileForm.tags
                        ? 7
                        : widget.type == UserProfileForm.mbti
                            ? 4
                            : null,
                textInputAction: widget.type == UserProfileForm.nickName ||
                        widget.type == UserProfileForm.userIntroduce
                    ? TextInputAction.next
                    : widget.type == UserProfileForm.mbti
                        ? TextInputAction.done
                        : TextInputAction.newline,
                style: const TextStyle(fontSize: Sizes.size16),
                decoration: InputDecoration(
                  hintText: widget.type.hint,
                  hintStyle: Theme.of(context).textTheme.labelSmall,
                  enabledBorder: widget.enableBox
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Sizes.size1),
                          gapPadding: 30,
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                        )
                      : UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                        ),
                  focusedBorder: widget.enableBox
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Sizes.size1),
                          gapPadding: 30,
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      : UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size10,
                  ),
                ),
                cursorColor: Theme.of(context).primaryColor,
                onChanged: _onChanged,
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                onEditingComplete: () {},
                onFieldSubmitted: _onFieldSubmitted,
              ),
            ),
            if (widget.enableBox)
              GestureDetector(
                onTap: () =>
                    _onFieldSubmitted(_fieldKey.currentState?.value ?? ''),
                child: Container(
                  width: Sizes.size80,
                  height: Sizes.size48,
                  color: Theme.of(context).primaryColor,
                  child: Center(
                    child: Text(
                      widget.type == UserProfileForm.mbti ? '수정' : '추가',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
