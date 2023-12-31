import 'dart:convert';
import 'package:honbap_signal_flutter/constants/api.dart';
import 'package:honbap_signal_flutter/models/chats/chat_model.dart';
import 'package:honbap_signal_flutter/models/res_code_model.dart';
import 'package:honbap_signal_flutter/models/signal/signal_info_model.dart';
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
      Uri.parse('${ApiEndpoint.honbab}/msg/$roomId'),
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

  Future<ResCodeModel> sendChat({
    required String jwt,
    required String roomId,
    required String msg,
  }) async {
    try {
      final Map<String, String> headers = {
        "Content-Type": "application/json",
        'x-access-token': jwt,
      };
      final Map<String, String> body = {
        'msg': msg,
      };

      final res = await http.post(
        Uri.parse('${ApiEndpoint.honbab}/msg/$roomId'),
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

  Future<ResCodeModel> changeSignalInfo({
    required String jwt,
    required String roomId,
    required SignalInfoModel signalInfo,
  }) async {
    try {
      final Map<String, String> headers = {
        "Content-Type": "application/json",
        'x-access-token': jwt,
      };

      final Map<String, String> body = {
        'where': signalInfo.sigPromiseArea!,
        'when': signalInfo.sigPromiseTime!,
        'menu': signalInfo.sigPromiseMenu!,
      };

      final res = await http.patch(
        Uri.parse('${ApiEndpoint.honbab}/msg/promise/$roomId'),
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
