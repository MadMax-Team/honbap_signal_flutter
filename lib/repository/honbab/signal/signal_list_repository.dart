import 'dart:convert';
import 'package:honbap_signal_flutter/constants/api.dart';
import 'package:honbap_signal_flutter/models/signal/signal_list_model.dart';
import 'package:http/http.dart' as http;

class HonbabSignalListRepository {
  Future<List<SignalListModel>> getSignalList({required String jwt}) async {
    final Map<String, String> headers = {
      "Content-Type": "application/json",
      'x-access-token': jwt,
    };

    final res = await http.get(
      Uri.parse('${ApiEndpoint.honbab}/signalFind/list'),
      headers: headers,
    );

    List<SignalListModel> resultList = [];

    print(res.body);
    if (res.statusCode == 200) {
      for (var signalJson in json.decode(res.body)['result'] as List<dynamic>) {
        resultList.add(SignalListModel.fromJson(signalJson));
      }
    }

    return resultList;
  }
}
