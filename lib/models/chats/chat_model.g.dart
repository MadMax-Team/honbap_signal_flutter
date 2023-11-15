// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => ChatModel(
      status: json['status'] as String?,
      msg: json['msg'] as String?,
      sendAt: json['sendAt'] as String?,
    );

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'sendAt': instance.sendAt,
    };
