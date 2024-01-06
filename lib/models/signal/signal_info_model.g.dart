// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signal_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignalInfoModel _$SignalInfoModelFromJson(Map<String, dynamic> json) =>
    SignalInfoModel(
      sigPromiseTime: strToDt(json['sigPromiseTime'] as String?),
      sigPromiseArea: json['sigPromiseArea'] as String?,
      sigPromiseMenu: json['sigPromiseMenu'] as String?,
    );

Map<String, dynamic> _$SignalInfoModelToJson(SignalInfoModel instance) =>
    <String, dynamic>{
      'sigPromiseTime': dtToStr(instance.sigPromiseTime),
      'sigPromiseArea': instance.sigPromiseArea,
      'sigPromiseMenu': instance.sigPromiseMenu,
    };
