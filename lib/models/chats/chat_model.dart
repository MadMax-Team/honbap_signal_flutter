import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class ChatModel extends Equatable {
  final String? status; // send, receive
  final String? msg;
  final String? sendAt;

  const ChatModel({
    this.status,
    this.msg,
    this.sendAt,
  });

  ChatModel copyWith({
    String? status,
    String? msg,
    String? sendAt,
  }) =>
      ChatModel(
        status: status ?? this.status,
        msg: msg ?? this.msg,
        sendAt: sendAt ?? this.sendAt,
      );

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);

  @override
  List<Object?> get props => [
        status,
        msg,
        sendAt,
      ];
}
