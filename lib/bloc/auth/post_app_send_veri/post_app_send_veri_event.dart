import 'package:equatable/equatable.dart';

abstract class SignupPhoneEvent extends Equatable {}

// 다음 버튼(verify code send) 터치 이벤트
class SignupPhoneSendTabEvent extends SignupPhoneEvent {
  final String phoneNumber;

  SignupPhoneSendTabEvent({
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [phoneNumber];
}

// 다음 버튼(verify) 터치 이벤트
class SignupPhoneVerifyTabEvent extends SignupPhoneEvent {
  final String phoneNumber;
  final String verifyCode;

  SignupPhoneVerifyTabEvent({
    required this.phoneNumber,
    required this.verifyCode,
  });

  @override
  List<Object?> get props => [
        phoneNumber,
        verifyCode,
      ];
}
