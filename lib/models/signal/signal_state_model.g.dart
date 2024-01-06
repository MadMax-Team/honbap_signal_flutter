// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signal_state_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignalStateModel _$SignalStateModelFromJson(Map<String, dynamic> json) =>
    SignalStateModel(
      oppoUserIdx: json['oppoUserIdx'] as int?,
      matchUserIdx: json['matchUserIdx'] as int?,
      matchApplyIdx: json['matchApplyIdx'] as int?,
      oppoNickName: json['oppoNickName'] as String?,
      imgUrl: json['imgUrl'] as String?,
      sigPromiseTime: strToDt(json['sigPromiseTime'] as String?),
      sigPromiseArea: json['sigPromiseArea'] as String?,
      sigPromiseMenu: json['sigPromiseMenu'] as String?,
    );

Map<String, dynamic> _$SignalStateModelToJson(SignalStateModel instance) =>
    <String, dynamic>{
      'sigPromiseTime': dtToStr(instance.sigPromiseTime),
      'sigPromiseArea': instance.sigPromiseArea,
      'sigPromiseMenu': instance.sigPromiseMenu,
      'oppoUserIdx': instance.oppoUserIdx,
      'matchUserIdx': instance.matchUserIdx,
      'matchApplyIdx': instance.matchApplyIdx,
      'oppoNickName': instance.oppoNickName,
      'imgUrl': instance.imgUrl,
    };
