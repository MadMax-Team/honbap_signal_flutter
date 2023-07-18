import 'package:equatable/equatable.dart';
import 'package:honbap_signal_flutter/models/auth/auth_signup_model.dart';
import 'package:honbap_signal_flutter/models/res_code_model.dart';

abstract class SignupUserInfoState extends Equatable {}

class SignupUserInfoNormalState extends SignupUserInfoState {
  final AuthSignupModel formData;

  SignupUserInfoNormalState({
    required this.formData,
  });

  SignupUserInfoNormalState copyWith({
    String? email,
    String? password,
    String? nickName,
    String? birth,
    String? phoneNum,
    String? sex,
  }) {
    return SignupUserInfoNormalState(
      formData: formData.copyWith(
        email: email ?? formData.email,
        password: password ?? formData.password,
        nickName: nickName ?? formData.nickName,
        birth: birth ?? formData.birth,
        phoneNum: phoneNum ?? formData.phoneNum,
        sex: sex ?? formData.sex,
      ),
    );
  }

  @override
  List<Object?> get props => [formData];
}

class SignupUserInfoLoadingState extends SignupUserInfoState {
  @override
  List<Object?> get props => [];
}

class SignupUserInfoErrorState extends SignupUserInfoState {
  /// 1001: 이메일 입력 필요
  /// 1002: 비밀번호 입력 필요
  /// 1003: 닉네임 입력 필요
  /// 1004: 생일 입력 필요
  /// 1005: 성별 입력 필요
  /// 4001: 통신 실패
  final int code;
  final String message;

  SignupUserInfoErrorState({
    required this.code,
    required this.message,
  });

  @override
  List<Object?> get props => [
        code,
        message,
      ];
}

class SignupUserInfoLoadedState extends SignupUserInfoState {
  final ResCodeModel resCode;
  final AuthSignupModel formData;

  SignupUserInfoLoadedState({
    required this.resCode,
    required this.formData,
  });

  @override
  List<Object?> get props => [
        resCode,
        formData,
      ];
}
