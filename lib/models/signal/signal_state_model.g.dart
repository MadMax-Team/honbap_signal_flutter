// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signal_state_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignalStateModel _$SignalStateModelFromJson(Map<String, dynamic> json) =>
    SignalStateModel(
      oppoUserIdx: json['oppoUserIdx'] as int?,
      oppoNickName: json['oppoNickName'] as String?,
      sigPromiseTime: json['sigPromiseTime'] as String?,
      sigPromiseArea: json['sigPromiseArea'] as String?,
      sigPromiseMenu: json['sigPromiseMenu'] as String?,
    );

Map<String, dynamic> _$SignalStateModelToJson(SignalStateModel instance) =>
    <String, dynamic>{
      'sigPromiseTime': instance.sigPromiseTime,
      'sigPromiseArea': instance.sigPromiseArea,
      'sigPromiseMenu': instance.sigPromiseMenu,
      'oppoUserIdx': instance.oppoUserIdx,
      'oppoNickName': instance.oppoNickName,
    };
