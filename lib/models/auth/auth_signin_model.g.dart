// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_signin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthSigninModel _$AuthSigninModelFromJson(Map<String, dynamic> json) =>
    AuthSigninModel(
      isSuccess: json['isSuccess'] as bool?,
      code: json['code'] as int?,
      message: json['message'] as String?,
      result: json['result'] == null
          ? null
          : AuthSigninUserDataModel.fromJson(
              json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthSigninModelToJson(AuthSigninModel instance) =>
    <String, dynamic>{
      'isSuccess': instance.isSuccess,
      'code': instance.code,
      'message': instance.message,
      'result': instance.result?.toJson(),
    };

AuthSigninUserDataModel _$AuthSigninUserDataModelFromJson(
        Map<String, dynamic> json) =>
    AuthSigninUserDataModel(
      userIdx: json['userIdx'] as int?,
      jwt: json['jwt'] as String?,
    );

Map<String, dynamic> _$AuthSigninUserDataModelToJson(
        AuthSigninUserDataModel instance) =>
    <String, dynamic>{
      'userIdx': instance.userIdx,
      'jwt': instance.jwt,
    };
