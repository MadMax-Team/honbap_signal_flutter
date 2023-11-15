// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatListModel _$ChatListModelFromJson(Map<String, dynamic> json) =>
    ChatListModel(
      roomId: json['roomId'] as String?,
      profileImg: json['profileImg'] as String?,
      nickName: json['nickName'] as String?,
      lastMessage: json['lastMessage'] as String?,
      lastSendedAt: json['lastSendedAt'] as String?,
    );

Map<String, dynamic> _$ChatListModelToJson(ChatListModel instance) =>
    <String, dynamic>{
      'roomId': instance.roomId,
      'profileImg': instance.profileImg,
      'nickName': instance.nickName,
      'lastMessage': instance.lastMessage,
      'lastSendedAt': instance.lastSendedAt,
    };
