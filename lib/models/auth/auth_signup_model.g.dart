// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_signup_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthSignupModel _$AuthSignupModelFromJson(Map<String, dynamic> json) =>
    AuthSignupModel(
      email: json['email'] as String?,
      password: json['password'] as String?,
      nickName: json['nickName'] as String?,
      birth: json['birth'] as String?,
      phoneNum: json['phoneNum'] as String?,
      sex: json['sex'] as String?,
    );

Map<String, dynamic> _$AuthSignupModelToJson(AuthSignupModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'nickName': instance.nickName,
      'birth': instance.birth,
      'phoneNum': instance.phoneNum,
      'sex': instance.sex,
    };
