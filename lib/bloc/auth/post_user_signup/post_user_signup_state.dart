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
  final String message;

  SignupUserInfoErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

class SignupUserInfoLoadedState extends SignupUserInfoState {
  final ResCodeModel resCode;

  SignupUserInfoLoadedState({
    required this.resCode,
  });

  @override
  List<Object?> get props => [resCode];
}
