// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      userId: json['userId'] as int?,
      userName: json['userName'] as String?,
      birth: json['birth'] as String?,
      email: json['email'] as String?,
      phoneNum: json['phoneNum'] as String?,
      sex: json['sex'] as String?,
      createAt: json['createAt'] == null
          ? null
          : DateTime.parse(json['createAt'] as String),
      updateAt: json['updateAt'] == null
          ? null
          : DateTime.parse(json['updateAt'] as String),
      userProfile: json['userProfile'] == null
          ? null
          : UserProfileModel.fromJson(
              json['userProfile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'birth': instance.birth,
      'email': instance.email,
      'phoneNum': instance.phoneNum,
      'sex': instance.sex,
      'createAt': instance.createAt?.toIso8601String(),
      'updateAt': instance.updateAt?.toIso8601String(),
      'userProfile': instance.userProfile?.toJson(),
    };

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) =>
    UserProfileModel(
      profileImg: json['profileImg'] as String?,
      taste: json['taste'] as String?,
      hateFood: json['hateFood'] as String?,
      interest: json['interest'] as String?,
      avgSpeed: json['avgSpeed'] as String?,
      preferArea: json['preferArea'] as String?,
      mbti: json['mbti'] as String?,
      userIntroduce: json['userIntroduce'] as String?,
      updateAt: json['updateAt'] == null
          ? null
          : DateTime.parse(json['updateAt'] as String),
    );

Map<String, dynamic> _$UserProfileModelToJson(UserProfileModel instance) =>
    <String, dynamic>{
      'profileImg': instance.profileImg,
      'taste': instance.taste,
      'hateFood': instance.hateFood,
      'interest': instance.interest,
      'avgSpeed': instance.avgSpeed,
      'preferArea': instance.preferArea,
      'mbti': instance.mbti,
      'userIntroduce': instance.userIntroduce,
      'updateAt': instance.updateAt?.toIso8601String(),
    };