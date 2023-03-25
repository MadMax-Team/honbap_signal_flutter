import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_signup_model.freezed.dart';
part 'auth_signup_model.g.dart';

@freezed
class AuthSignupModel with _$AuthSignupModel {
  factory AuthSignupModel({
    @Default('') String email,
    @Default('') String password,
    @Default('') String nickName,
    @Default('') String birth,
    @Default('') String phoneNum,
    @Default('') String sex,
  }) = _AuthSignupModel;

  factory AuthSignupModel.fromJson(Map<String, dynamic> json) =>
      _$AuthSignupModelFromJson(json);
}
