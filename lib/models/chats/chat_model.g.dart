// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => ChatModel(
      nickName: json['nickName'] as String?,
      text: json['text'] as String?,
      sendAt: json['sendAt'] as String?,
    );

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
      'nickName': instance.nickName,
      'text': instance.text,
      'sendAt': instance.sendAt,
    };
