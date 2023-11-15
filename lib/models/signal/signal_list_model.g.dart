// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signal_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignalListModel _$SignalListModelFromJson(Map<String, dynamic> json) =>
    SignalListModel(
      userIdx: json['userIdx'] as int?,
      signalIdx: json['signalIdx'] as int?,
      checkSigWrite: json['checkSigWrite'] as int?,
      profileImg: json['profileImg'] as String?,
      nickName: json['nickName'] as String?,
      userIntroduce: json['userIntroduce'] as String?,
      sigPromiseArea: json['sigPromiseArea'] as String?,
      sigPromiseTime: json['sigPromiseTime'] as String?,
      sigPromiseMenu: json['sigPromiseMenu'] as String?,
      interest: json['interest'] as String?,
      taste: json['taste'] as String?,
      hateFood: json['hateFood'] as String?,
      preferArea: json['preferArea'] as String?,
      mbti: json['mbti'] as String?,
      distance: (json['distance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SignalListModelToJson(SignalListModel instance) =>
    <String, dynamic>{
      'userIdx': instance.userIdx,
      'signalIdx': instance.signalIdx,
      'checkSigWrite': instance.checkSigWrite,
      'profileImg': instance.profileImg,
      'nickName': instance.nickName,
      'userIntroduce': instance.userIntroduce,
      'sigPromiseArea': instance.sigPromiseArea,
      'sigPromiseTime': instance.sigPromiseTime,
      'sigPromiseMenu': instance.sigPromiseMenu,
      'interest': instance.interest,
      'taste': instance.taste,
      'hateFood': instance.hateFood,
      'preferArea': instance.preferArea,
      'mbti': instance.mbti,
      'distance': instance.distance,
    };
