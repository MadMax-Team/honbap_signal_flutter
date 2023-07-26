// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_signup_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthSignupModel _$AuthSignupModelFromJson(Map<String, dynamic> json) =>
    AuthSignupModel(
      email: json['email'] as String?,
      password: json['password'] as String?,
      userName: json['userName'] as String?,
      birth: json['birth'] as String?,
      phoneNum: json['phoneNum'] as String?,
      sex: json['sex'] as String?,
      userId: json['userId'] as String? ?? 'Null',
    );

Map<String, dynamic> _$AuthSignupModelToJson(AuthSignupModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'userName': instance.userName,
      'birth': instance.birth,
      'phoneNum': instance.phoneNum,
      'sex': instance.sex,
      'userId': instance.userId,
    };
