import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/cubit/user_pw_change_cubit.dart';

class UserPasswordSubmitButton extends StatelessWidget {
  const UserPasswordSubmitButton({super.key});

  void _onTap(BuildContext context) {
    final cubit = context.read<UserPWChangeCubit>();

    if (cubit.state.newPassword?.isNotEmpty == true &&
        cubit.state.oldPassword?.isNotEmpty == true) {
      if (cubit.state.status == UserPWChangeStatus.updating) return;

      cubit.updatePassword();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPWChangeCubit, UserPWChangeState>(
      builder: (context, state) => GestureDetector(
        onTap: () => _onTap(context),
        child: Container(
          height: Sizes.size48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes.size5),
            color: state.newPassword?.isNotEmpty == true &&
                    state.oldPassword?.isNotEmpty == true
                ? Theme.of(context).primaryColor
                : Colors.grey.shade400,
          ),
          child: Center(
            child: state.status == UserPWChangeStatus.updating
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const Text(
                    '저장',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
