import 'dart:convert';
import 'package:honbap_signal_flutter/constants/api.dart';
import 'package:honbap_signal_flutter/models/chats/chat_list_model.dart';
import 'package:honbap_signal_flutter/models/res_code_model.dart';
import 'package:http/http.dart' as http;

class ChatListRepository {
  Future<List<ChatListModel>> getChatList({required String jwt}) async {
    final Map<String, String> headers = {
      "Content-Type": "application/json",
      'x-access-token': jwt,
    };

    final res = await http.get(
      Uri.parse('${ApiEndpoint.honbab}/msg'),
      headers: headers,
    );

    print(res.body);

    List<ChatListModel> resultList = [];
    if (res.statusCode == 200) {
      for (var signalJson in json.decode(res.body)['result'] as List<dynamic>) {
        resultList.add(ChatListModel.fromJson(signalJson));
      }
    }

    return resultList;
  }

  Future<ResCodeModel> leaveChatRoom({
    required String jwt,
    required String roomId,
  }) async {
    try {
      final Map<String, String> headers = {
        "Content-Type": "application/json",
        'x-access-token': jwt,
      };

      final Map<String, String> body = {
        'roomId': roomId,
      };

      final res = await http.delete(
        Uri.parse('${ApiEndpoint.honbab}/msg'),
        headers: headers,
        body: jsonEncode(body),
      );

      if (res.statusCode == 200) {
        return ResCodeModel.fromJson(jsonDecode(res.body));
      }
    } catch (e) {
      return ResCodeModel(
        isSuccess: false,
        code: 4001,
        message: e.toString(),
      );
    }
    return ResCodeModel(
      isSuccess: false,
      code: 4002,
      message: '통신에 실패했습니다.',
    );
  }
}
