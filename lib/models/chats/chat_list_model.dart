class ChatListModel {
  final String profileImage, nickname, lastMessage;
  final DateTime laseSendedAt;
  final int unreadMessages;

  ChatListModel.fromJson(Map<String, dynamic> json)
      : profileImage = json['profileImage'],
        nickname = json['nickname'],
        lastMessage = json['lastMessage'],
        laseSendedAt = DateTime.parse(json['lastSendedAt']),
        unreadMessages = json['unreadMessages'];
}
