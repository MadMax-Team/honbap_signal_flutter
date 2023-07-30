import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class ChatModel extends Equatable {
  final String? userName;
  final String? text;
  final String? sendAt;

  const ChatModel({
    this.userName,
    this.text,
    this.sendAt,
  });

  ChatModel copyWith({
    String? userName,
    String? text,
    String? sendAt,
  }) =>
      ChatModel(
        userName: userName ?? this.userName,
        text: text ?? this.text,
        sendAt: sendAt ?? this.sendAt,
      );

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);

  @override
  List<Object?> get props => [
        userName,
        text,
        sendAt,
      ];
}
