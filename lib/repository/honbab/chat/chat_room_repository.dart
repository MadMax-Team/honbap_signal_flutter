import 'dart:convert';
import 'package:honbap_signal_flutter/constants/api.dart';
import 'package:honbap_signal_flutter/models/chats/chat_model.dart';
import 'package:http/http.dart' as http;

class ChatRoomRepository {
  Future<List<ChatModel>> getChats({
    required String jwt,
    required String roomId,
  }) async {
    final Map<String, String> headers = {
      "Content-Type": "application/json",
      'x-access-token': jwt,
    };

    final res = await http.get(
      // Uri.parse('${ApiEndpoint.honbab}/msg/$roomId'),
      Uri.parse('${ApiEndpoint.honbabMock}/msg/1'),
      headers: headers,
    );

    List<ChatModel> resultList = [];
    if (res.statusCode == 200) {
      for (var signalJson in json.decode(res.body)['result'] as List<dynamic>) {
        resultList.add(ChatModel.fromJson(signalJson));
      }
    }

    return resultList;
  }
}
