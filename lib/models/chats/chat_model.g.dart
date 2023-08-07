// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => ChatModel(
      userName: json['userName'] as String?,
      text: json['text'] as String?,
      sendAt: json['sendAt'] as String?,
    );

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
      'userName': instance.userName,
      'text': instance.text,
      'sendAt': instance.sendAt,
    };
