import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signup/post_user_signup_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signup/post_user_signup_event.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signup/post_user_signup_state.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';

class SignupUserInfoBirth extends StatefulWidget {
  const SignupUserInfoBirth({super.key});

  @override
  State<SignupUserInfoBirth> createState() => _SignupUserInfoBirthState();
}

class _SignupUserInfoBirthState extends State<SignupUserInfoBirth> {
  void _onBirthTap() async {
    DateTime today = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: DateTime(1900, 1),
      lastDate: today,
    );

    // Invalid
    if (picked == null) return;

    // Valid
    _updateBirth(birth: picked.toString().split(' ').first);
  }

  void _updateBirth({required String birth}) {
    context.read<SignupUserBloc>().add(SignupBirthChangedEvent(birth: birth));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupUserBloc, SignupUserInfoState>(
      listener: (context, state) {
        if (state is SignupUserInfoErrorState && state.code == 1004) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              elevation: 0,
              backgroundColor: Theme.of(context).primaryColor,
            ),
          );
        }
      },
      buildWhen: (previous, current) {
        if (current is SignupUserInfoNormalState) return true;
        return false;
      },
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '생년월일',
            style: Theme.of(context).textTheme.labelSmall,
          ),
          Gaps.v5,
          GestureDetector(
            onTap: _onBirthTap,
            child: Container(
              width: double.infinity,
              height: Sizes.size28,
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size5,
                horizontal: Sizes.size10,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  ((state as SignupUserInfoNormalState).formData.birth ?? '') ==
                          ''
                      ? '0000-00-00'
                      : state.formData.birth ?? '',
                  style: TextStyle(
                    color: state.formData.birth == ''
                        ? Colors.black
                        : Colors.grey.shade400,
                    fontSize: Sizes.size12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
