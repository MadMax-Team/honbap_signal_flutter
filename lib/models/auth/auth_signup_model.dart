import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_signup_model.g.dart';

@JsonSerializable()
class AuthSignupModel extends Equatable {
  final String? email;
  final String? password;
  final String? nickName;
  final String? birth;
  final String? phoneNum;
  final String? sex;

  const AuthSignupModel({
    this.email,
    this.password,
    this.nickName,
    this.birth,
    this.phoneNum,
    this.sex,
  });

  AuthSignupModel copyWith({
    String? email,
    String? password,
    String? nickName,
    String? birth,
    String? phoneNum,
    String? sex,
  }) =>
      AuthSignupModel(
        email: email ?? this.email,
        password: password ?? this.password,
        nickName: nickName ?? this.nickName,
        birth: birth ?? this.birth,
        phoneNum: phoneNum ?? this.phoneNum,
        sex: sex ?? this.sex,
      );

  factory AuthSignupModel.fromJson(Map<String, dynamic> json) =>
      _$AuthSignupModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthSignupModelToJson(this);

  @override
  List<Object?> get props => [
        email,
        password,
        nickName,
        birth,
        phoneNum,
        sex,
      ];
}
