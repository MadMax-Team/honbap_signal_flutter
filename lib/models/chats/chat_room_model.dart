class ChatRoomModel {
  final String nickname, message;
  final DateTime sendedAt;

  ChatRoomModel.fromJson(Map<String, dynamic> json)
      : nickname = json['nickname'],
        message = json['message'],
        sendedAt = DateTime.parse(json['sendedAt']);
}
