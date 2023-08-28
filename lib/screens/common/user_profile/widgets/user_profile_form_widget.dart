import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/cubit/user_profile_upload_cubit.dart';
import 'package:honbap_signal_flutter/models/mypage/mypage_model.dart';

class UserProfileFormWidget extends StatefulWidget {
  final UserProfileForm type;

  const UserProfileFormWidget({
    super.key,
    required this.type,
  });

  @override
  State<UserProfileFormWidget> createState() => _UserProfileFormWidgetState();
}

class _UserProfileFormWidgetState extends State<UserProfileFormWidget> {
  final _fieldKey = GlobalKey<FormFieldState<String>>();
  final _focusNode = FocusNode();

  void _onChanged(String value) {
    switch (widget.type) {
      case UserProfileForm.userName:
        {
          context.read<UserProfileUploadCubit>().update(userName: value);
          break;
        }
      case UserProfileForm.userIntroduce:
        {
          context.read<UserProfileUploadCubit>().update(userIntroduce: value);
          break;
        }
      case UserProfileForm.tags:
        {
          if (value.contains(',')) {
            _onFieldSubmitted(value.replaceAll(',', ''));
          }
          break;
        }
    }
  }

  void _onFieldSubmitted(String value) {
    if (widget.type == UserProfileForm.tags) {
      if (value.isNotEmpty) {
        var prev =
            context.read<UserProfileUploadCubit>().state.profile?.tags ?? [];
        prev.add(value);

        context.read<UserProfileUploadCubit>().update(tags: List.from(prev));
      }

      _fieldKey.currentState?.reset();
      _focusNode.requestFocus();
      return;
    }

    FocusScope.of(context).nextFocus();
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
        TextFormField(
          key: _fieldKey,
          focusNode: _focusNode,
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          enableSuggestions: false,
          textInputAction: widget.type != UserProfileForm.tags
              ? TextInputAction.next
              : TextInputAction.newline,
          style: const TextStyle(fontSize: Sizes.size16),
          decoration: InputDecoration(
            hintText: widget.type.hint,
            hintStyle: Theme.of(context).textTheme.labelSmall,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade400,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          cursorColor: Theme.of(context).primaryColor,
          onChanged: _onChanged,
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          onEditingComplete: () {},
          onFieldSubmitted: _onFieldSubmitted,
        ),
        widget.type != UserProfileForm.tags ? Gaps.v32 : Gaps.v10,
      ],
    );
  }
}
