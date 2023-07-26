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
      userName: json['userName'] as String?,
      userIntroduce: json['userIntroduce'] as String?,
      taste: json['taste'] as String?,
      hateFood: json['hateFood'] as String?,
      interest: json['interest'] as String?,
      avgSpeed: json['avgSpeed'] as String?,
      preferArea: json['preferArea'] as String?,
      mbti: json['mbti'] as String?,
      updateAt: json['updateAt'] as String?,
      sigPromiseArea: json['sigPromiseArea'] as String?,
      sigPromiseTime: json['sigPromiseTime'] as String?,
    );

Map<String, dynamic> _$SignalListModelToJson(SignalListModel instance) =>
    <String, dynamic>{
      'userIdx': instance.userIdx,
      'signalIdx': instance.signalIdx,
      'checkSigWrite': instance.checkSigWrite,
      'userName': instance.userName,
      'userIntroduce': instance.userIntroduce,
      'taste': instance.taste,
      'hateFood': instance.hateFood,
      'interest': instance.interest,
      'avgSpeed': instance.avgSpeed,
      'preferArea': instance.preferArea,
      'mbti': instance.mbti,
      'updateAt': instance.updateAt,
      'sigPromiseArea': instance.sigPromiseArea,
      'sigPromiseTime': instance.sigPromiseTime,
    };
