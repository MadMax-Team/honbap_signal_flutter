import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:honbap_signal_flutter/apis/auth/post_app_send.dart';
import 'package:honbap_signal_flutter/apis/auth/post_app_verify.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/screens/auth/signup_phone_auth_complete.dart';
import 'package:honbap_signal_flutter/screens/auth/widgets/auth_button_widget.dart';
import 'package:honbap_signal_flutter/tools/phone_format_updater.dart';

class SignupPhoneAuthScreen extends StatefulWidget {
  const SignupPhoneAuthScreen({super.key});

  @override
  State<SignupPhoneAuthScreen> createState() => _SignupPhoneAuthScreenState();
}

class _SignupPhoneAuthScreenState extends State<SignupPhoneAuthScreen> {
  String phoneNum = "", authNum = "";
  bool isPhoneSubmit = false;
  bool isLoading = false;

  final _phoneNumFormKey = GlobalKey<FormState>();
  final _authNumFormKey = GlobalKey<FormState>();

  final FocusNode _phoneNumFocusNode = FocusNode();
  final FocusNode _authNumNode = FocusNode();

  void _submitHandler() {
    if (_phoneNumFormKey.currentState!.validate()) {
      if (!isPhoneSubmit) {
        setState(() {
          isLoading = true;
        });
        postAppSend(phoneNumber: phoneNum).then(
          (value) => {
            setState(() {
              isLoading = false;
            }),
            if (value)
              setState(() {
                isPhoneSubmit = true;
              })
            else
              Fluttertoast.showToast(msg: "메세지 전송에 실패했습니다.\n번호 확인 후 다시 시도해주세요.")
          },
        );
      }
    } else {
      _phoneNumFocusNode.requestFocus();
      return;
    }

    if (_authNumFormKey.currentState != null &&
        _authNumFormKey.currentState!.validate()) {
      if (isPhoneSubmit) {
        setState(() {
          isLoading = true;
        });
        postAppVerify(phoneNumber: phoneNum, verifyCode: authNum).then(
          (value) => {
            setState(() {
              isLoading = false;
            }),
            if (value)
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignupPhoneAuthComplete(),
                ),
              )
            else
              Fluttertoast.showToast(msg: "인증에 실패했습니다.\n번호 확인 후 다시 시도해주세요.")
          },
        );
      }
    } else {
      _authNumNode.requestFocus();
      return;
    }
  }

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
          iconTheme: const IconThemeData(
            color: Colors.black, // <-- SEE HERE
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
                child: Column(
                  children: [
                    Gaps.v20,
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
                            enabled: !isPhoneSubmit,
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
                              _submitHandler();
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
                                _submitHandler();
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
              onTap: !isLoading ? _submitHandler : null,
              child: AuthBtnWidget(
                title: "계속하기",
                bgColor: Theme.of(context).primaryColor,
                borderColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
                borderRad: 0,
                isLoading: isLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
