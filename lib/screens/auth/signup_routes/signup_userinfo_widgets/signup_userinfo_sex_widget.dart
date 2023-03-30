import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signup/post_user_signup_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signup/post_user_signup_event.dart';
import 'package:honbap_signal_flutter/bloc/auth/post_user_signup/post_user_signup_state.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/screens/auth/signup_routes/signup_userinfo_widgets/signup_gender_button.dart';

class SignupUserInfoSex extends StatefulWidget {
  const SignupUserInfoSex({super.key});

  @override
  State<SignupUserInfoSex> createState() => _SignupUserInfoSexState();
}

class _SignupUserInfoSexState extends State<SignupUserInfoSex> {
  void _onGenderBtnTap(String gender) {
    context.read<SignupUserBloc>().add(SignupSexChangedEvent(sex: gender));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupUserBloc, SignupUserInfoState>(
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '성별',
            style: Theme.of(context).textTheme.labelSmall,
          ),
          Gaps.v5,
          Row(
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: GestureDetector(
                  onTap: () => _onGenderBtnTap('M'),
                  child: SignupGenderButton(
                    text: '남성',
                    isSelected:
                        (state as SignupUserInfoNormalState).formData.sex ==
                            'M',
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: GestureDetector(
                  onTap: () => _onGenderBtnTap('F'),
                  child: SignupGenderButton(
                    text: '여성',
                    isSelected: state.formData.sex == 'F',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
