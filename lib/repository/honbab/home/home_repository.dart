import 'dart:convert';

import 'package:honbap_signal_flutter/models/home/home_signal_apply_list_model.dart';
import 'package:http/http.dart' as http;

import '../../../constants/api.dart';

class HomeSignalApplyRepository {
  Future<List<HomeSignalApplyListModel>> getHomeSignalApplyList({required String jwt}) async {
    final Map<String, String> headers = {
      "Content-Type": "application/json",
      'x-access-token': jwt,
    };

    final res = await http.get(
      Uri.parse('${ApiEndpoint.honbabHomeMock}/signal/applylist'),
      headers: headers,
    );

    List<HomeSignalApplyListModel> resultList = [];
    if(res.statusCode == 200) {
      for( var signalApplyJson in json.decode(res.body)['result'] as List<dynamic>) {
        resultList.add(HomeSignalApplyListModel.fromJson(signalApplyJson));
      }
    }

    return resultList;
  }
}