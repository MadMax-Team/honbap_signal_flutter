import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_list_model.g.dart';

@JsonSerializable()
class ChatListModel extends Equatable {
  final String? roomId;
  final String? profileImg;
  final String? nickName;
  final String? lastMessage;
  final String? lastSendedAt;

  const ChatListModel({
    this.roomId,
    this.profileImg,
    this.nickName,
    this.lastMessage,
    this.lastSendedAt,
  });

  ChatListModel copyWith({
    String? roomId,
    String? profileImg,
    String? nickName,
    String? lastMessage,
    String? lastSendedAt,
  }) =>
      ChatListModel(
        roomId: roomId ?? this.roomId,
        profileImg: profileImg ?? this.profileImg,
        nickName: nickName ?? this.nickName,
        lastMessage: lastMessage ?? this.lastMessage,
        lastSendedAt: roomId ?? this.roomId,
      );

  factory ChatListModel.fromJson(Map<String, dynamic> json) =>
      _$ChatListModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatListModelToJson(this);

  @override
  List<Object?> get props => [
        roomId,
        profileImg,
        nickName,
        lastMessage,
        lastSendedAt,
      ];
}
