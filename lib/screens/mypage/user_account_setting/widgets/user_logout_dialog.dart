import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_event.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';

class UserLogoutDialog extends StatelessWidget {
  const UserLogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(Sizes.size7),
        ),
      ),
      contentPadding: const EdgeInsets.all(0),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Gaps.v20,
          Text(
            '로그아웃',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Gaps.v20,
          Text(
            '정말 로그아웃하시겠습니까?',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Gaps.v12,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: Navigator.of(context).pop,
                  child: Container(
                    alignment: Alignment.center,
                    height: Sizes.size44,
                    child: Text(
                      '취소',
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: Sizes.size14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    context
                        .read<AuthenticationBloc>()
                        .add(const AuthenticationLogout());
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: Sizes.size44,
                    child: Text(
                      '로그아웃',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: Sizes.size14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
