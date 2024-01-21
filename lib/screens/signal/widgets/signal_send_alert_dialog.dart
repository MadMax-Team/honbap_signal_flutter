import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';

class SignalSendAlertDialog extends StatelessWidget {
  final String nickName;

  const SignalSendAlertDialog({
    super.key,
    required this.nickName,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(Sizes.size7),
        ),
      ),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: Sizes.size20,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Gaps.v20,
          Text(
            '\'$nickName\' 님께',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Text(
            '시그널 요청을 보냈습니다',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Gaps.v20,
          Text(
            '상대방이 시그널 요청을 수락하시면 쪽지방이 연결됩니다.',
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.center,
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
                      '확인',
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
