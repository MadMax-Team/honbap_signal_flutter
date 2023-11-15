import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class ChatModel extends Equatable {
  final String? nickName;
  final String? text;
  final String? sendAt;

  const ChatModel({
    this.nickName,
    this.text,
    this.sendAt,
  });

  ChatModel copyWith({
    String? nickName,
    String? text,
    String? sendAt,
  }) =>
      ChatModel(
        nickName: nickName ?? this.nickName,
        text: text ?? this.text,
        sendAt: sendAt ?? this.sendAt,
      );

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);

  @override
  List<Object?> get props => [
        nickName,
        text,
        sendAt,
      ];
}
