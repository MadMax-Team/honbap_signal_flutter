import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/routes/route_navigation_widget.dart';
import 'package:honbap_signal_flutter/screens/auth/widgets/auth_button_widget.dart';
import 'package:honbap_signal_flutter/screens/auth/widgets/signup_double_check_button_widget.dart';
import 'package:honbap_signal_flutter/screens/auth/widgets/signup_gender_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _passwordCheckFocus = FocusNode();
  final FocusNode _nicknameFocus = FocusNode();

  Map<String, String?> formData = {};

  bool _obscureText = true;
  bool _emailChecked = false;
  bool _passwordChecked = false;
  bool _passwordCheckChecked = false;
  bool _nicknameChecked = false;
  bool _nicknameCheckClicked = false;

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _toggleObscureText() {
    _obscureText = !_obscureText;
    setState(() {});
  }

  String? _emailValidator(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);

    if (value != null && !regExp.hasMatch(value)) {
      setState(() {
        _emailChecked = false;
      });
      _autoFocus();
      return '잘못된 이메일 형식입니다';
    }
    setState(() {
      _emailChecked = true;
    });
    return null;
  }

  String? _passwordValidator(String? value) {
    String pattern =
        r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,16}$';
    RegExp regExp = RegExp(pattern);

    if (value != null && !regExp.hasMatch(value)) {
      _passwordChecked = false;
      _autoFocus();
      return '8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.';
    }
    _passwordChecked = true;
    return null;
  }

  String? _passwordCheckValidator(String? value) {
    if (value != null && formData['password'] != value) {
      _passwordCheckChecked = false;
      _autoFocus();
      return '비밀번호가 틀립니다';
    }
    _passwordCheckChecked = true;
    return null;
  }

  String? _nicknameValidator(String? value) {
    if (value != null && value.isEmpty) {
      setState(() {
        _nicknameChecked = false;
      });
      _autoFocus();
      return '사용할 수 없는 닉네임입니다';
    }
    _autoFocus();
    if (!_nicknameCheckClicked) return "중복확인 해주세요";
    return null;
  }

  void _onNicknameChange(String? value) {
    formData['nickname'] = value;
    setState(() {
      _nicknameChecked = false;
      _nicknameCheckClicked = false;
    });
  }

  void _nicknameCheck() {
    _nicknameCheckClicked = true;
    setState(() {
      if (_formKey.currentState!.validate()) {
        //pass
        _nicknameChecked = true;
      }
    });
    _formKey.currentState!.save();
    _autoFocus();
  }

  void _autoFocus() {
    if (!_emailChecked) {
      _emailFocus.requestFocus();
      return;
    }
    if (!_passwordChecked) {
      _passwordFocus.requestFocus();
      return;
    }
    if (!_passwordCheckChecked) {
      _passwordCheckFocus.requestFocus();
      return;
    }
    if (!_nicknameChecked) {
      _nicknameFocus.requestFocus();
      return;
    }
    _onScaffoldTap();
  }

  void _onBirthTap() async {
    DateTime today = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: DateTime(1900, 1),
      lastDate: today,
    );
    setState(() {
      if (picked == null) {
        formData['birth'] = null;
        return;
      }
      formData['birth'] = picked.toString().split(' ').first;
    });
  }

  void _onGenderBtnTap(String gender) {
    setState(() {
      formData['gender'] = gender;
    });
  }

  void _onSubmitTap() {
    _formKey.currentState!.save();
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate() &&
          formData['birth'] != null &&
          formData['gender'] != null) {
        //pass
        _onScaffoldTap();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const RouteNavigationWidget(),
          ),
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(
            color: Colors.black, // <-- SEE HERE
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.v20,
                  Text(
                    '계정 정보를 입력해 주세요',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Gaps.v36,
                  Text(
                    '사용하실 이메일 아이디를 입력해 주세요',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  TextFormField(
                    focusNode: _emailFocus,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(fontSize: Sizes.size16),
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.check_circle_rounded,
                        color: _emailChecked
                            ? Theme.of(context).primaryColor
                            : Colors.grey.shade300,
                      ),
                      hintText: 'username@example.com',
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
                    validator: (value) => _emailValidator(value),
                    onSaved: (newValue) {
                      formData['email'] = newValue;
                    },
                    onEditingComplete: _onSubmitTap,
                  ),
                  Gaps.v40,
                  Text(
                    '비밀번호를 설정해 주세요',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  TextFormField(
                    focusNode: _passwordFocus,
                    obscureText: _obscureText,
                    style: const TextStyle(fontSize: Sizes.size16),
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: _toggleObscureText,
                        child: Container(
                          width: Sizes.size28,
                          alignment: Alignment.center,
                          child: FaIcon(
                            _obscureText
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeSlash,
                            color: Colors.grey.shade300,
                            size: Sizes.size20,
                          ),
                        ),
                      ),
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
                    validator: (value) => _passwordValidator(value),
                    onSaved: (newValue) {
                      formData['password'] = newValue;
                    },
                    onEditingComplete: _onSubmitTap,
                  ),
                  Gaps.v40,
                  Text(
                    '비밀번호를 확인해 주세요',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  TextFormField(
                    focusNode: _passwordCheckFocus,
                    style: const TextStyle(fontSize: Sizes.size16),
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: _toggleObscureText,
                        child: Container(
                          width: Sizes.size28,
                          alignment: Alignment.center,
                          child: FaIcon(
                            _obscureText
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeSlash,
                            color: Colors.grey.shade300,
                            size: Sizes.size20,
                          ),
                        ),
                      ),
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
                    validator: (value) => _passwordCheckValidator(value),
                    onEditingComplete: _onSubmitTap,
                  ),
                  Gaps.v80,
                  Text(
                    '사용하실 닉네임을 설정해 주세요',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Gaps.v5,
                  Text(
                    '닉네임은 3개월마다 변경이 가능합니다!',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  TextFormField(
                    focusNode: _nicknameFocus,
                    style: const TextStyle(fontSize: Sizes.size16),
                    decoration: InputDecoration(
                      suffix: GestureDetector(
                        onTap: _nicknameCheck,
                        child: SignupDoubleCheckButton(
                          isAvailable: _nicknameChecked,
                        ),
                      ),
                      hintText: '닉네임을 입력해주세요',
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
                    validator: (value) => _nicknameValidator(value),
                    onChanged: (value) => _onNicknameChange(value),
                    onSaved: (newValue) {
                      formData['nickname'] = newValue;
                    },
                    onEditingComplete: _onSubmitTap,
                  ),
                  Gaps.v80,
                  Text(
                    '생년월일과 성별을\n선택해 주세요',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Gaps.v20,
                  Row(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: Column(
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
                                    formData['birth'] ?? '0000-00-00',
                                    style: TextStyle(
                                      color: formData['birth'] != null
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
                      ),
                      Gaps.h20,
                      Flexible(
                        fit: FlexFit.tight,
                        child: Column(
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
                                      isSelected: formData['gender'] == 'M',
                                    ),
                                  ),
                                ),
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: GestureDetector(
                                    onTap: () => _onGenderBtnTap('F'),
                                    child: SignupGenderButton(
                                      text: '여성',
                                      isSelected: formData['gender'] == 'F',
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Gaps.v96,
                  Gaps.v96,
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () {
            _onSubmitTap();
          },
          child: AuthBtnWidget(
            title: "계속하기",
            bgColor: Theme.of(context).primaryColor,
            borderColor: Theme.of(context).primaryColor,
            textColor: Colors.white,
            borderRad: 0,
          ),
        ),
      ),
    );
  }
}
