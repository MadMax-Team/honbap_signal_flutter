import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/tools/phone_format_updater.dart';
import 'package:honbap_signal_flutter/screens/login/widgets/login_button_widget.dart';

class LoginPhoneAuthScreen extends StatefulWidget {
  const LoginPhoneAuthScreen({super.key});

  @override
  State<LoginPhoneAuthScreen> createState() => _LoginPhoneAuthScreenState();
}

class _LoginPhoneAuthScreenState extends State<LoginPhoneAuthScreen> {
  String phoneNum = "", authNum = "";
  bool isPhoneSubmit = false;

  final _phoneNumFormKey = GlobalKey<FormState>();
  final _authNumFormKey = GlobalKey<FormState>();

  final FocusNode _phoneNumFocusNode = FocusNode();
  final FocusNode _authNumNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
                child: Column(
                  children: [
                    Form(
                      key: _phoneNumFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '핸드폰 번호를 입력해주세요',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            '입력해 주시는 번호로 인증 번호가 발송됩니다',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          Gaps.v20,
                          TextFormField(
                            focusNode: _phoneNumFocusNode,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: '000-0000-0000',
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              PhoneFormatUpdater(),
                            ],
                            // enabled: !isPhoneSubmit,
                            onTap: () {
                              _phoneNumFocusNode.requestFocus();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "핸드폰 번호를 입력해주세요";
                              }
                              phoneNum = value;
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              submitHandler();
                            },
                          ),
                          Gaps.v60,
                        ],
                      ),
                    ),
                    if (isPhoneSubmit)
                      Form(
                        key: _authNumFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '문자 메세지로 도착한',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              '인증번호를 입력해 주세요',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Gaps.v10,
                            TextFormField(
                              focusNode: _authNumNode,
                              keyboardType: TextInputType.number,
                              onTap: () {
                                _authNumNode.requestFocus();
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "인증번호를 입력해주세요";
                                }
                                authNum = value;
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                submitHandler();
                              },
                            ),
                          ],
                        ),
                      )
                    else
                      Container(),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                submitHandler();
              },
              child: LoginBtnWidget(
                title: "계속하기",
                bgColor: Theme.of(context).primaryColor,
                borderColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
                borderRad: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void submitHandler() {
    if (_phoneNumFormKey.currentState!.validate()) {
      setState(() {
        isPhoneSubmit = true;
      });
      print(phoneNum);
    } else {
      _phoneNumFocusNode.requestFocus();
      return;
    }

    if (_authNumFormKey.currentState != null &&
        _authNumFormKey.currentState!.validate()) {
      print(authNum);
    } else {
      _authNumNode.requestFocus();
      return;
    }

    _authNumNode.unfocus();
    _phoneNumFocusNode.unfocus();
  }
}
