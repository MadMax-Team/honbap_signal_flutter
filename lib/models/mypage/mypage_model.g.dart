// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mypage_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyPageModel _$MyPageModelFromJson(Map<String, dynamic> json) => MyPageModel(
      profileImg: json['profileImg'] as String?,
      userName: json['userName'] as String?,
      userIntroduce: json['userIntroduce'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      preferArea: (json['preferArea'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      taste:
          (json['taste'] as List<dynamic>?)?.map((e) => e as String).toList(),
      hateFood: (json['hateFood'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      mbti: json['mbti'] as String?,
    );

Map<String, dynamic> _$MyPageModelToJson(MyPageModel instance) =>
    <String, dynamic>{
      'profileImg': instance.profileImg,
      'userName': instance.userName,
      'userIntroduce': instance.userIntroduce,
      'tags': instance.tags,
      'preferArea': instance.preferArea,
      'taste': instance.taste,
      'hateFood': instance.hateFood,
      'mbti': instance.mbti,
    };
