// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_signin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthSigninAutoModel _$AuthSigninAutoModelFromJson(Map<String, dynamic> json) =>
    AuthSigninAutoModel(
      isSuccess: json['isSuccess'] as bool?,
      code: json['code'] as int?,
      message: json['message'] as String?,
      result: json['result'] as int?,
    );

Map<String, dynamic> _$AuthSigninAutoModelToJson(
        AuthSigninAutoModel instance) =>
    <String, dynamic>{
      'isSuccess': instance.isSuccess,
      'code': instance.code,
      'message': instance.message,
      'result': instance.result,
    };

AuthSigninMyInfoModel _$AuthSigninMyInfoModelFromJson(
        Map<String, dynamic> json) =>
    AuthSigninMyInfoModel(
      isSuccess: json['isSuccess'] as bool?,
      code: json['code'] as int?,
      message: json['message'] as String?,
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AuthSigninMyInfoModelToJson(
        AuthSigninMyInfoModel instance) =>
    <String, dynamic>{
      'isSuccess': instance.isSuccess,
      'code': instance.code,
      'message': instance.message,
      'result': instance.result?.toJson(),
    };

AuthSigninMyPageModel _$AuthSigninMyPageModelFromJson(
        Map<String, dynamic> json) =>
    AuthSigninMyPageModel(
      isSuccess: json['isSuccess'] as bool?,
      code: json['code'] as int?,
      message: json['message'] as String?,
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => UserProfileModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AuthSigninMyPageModelToJson(
        AuthSigninMyPageModel instance) =>
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
