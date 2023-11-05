import 'dart:convert';

import 'package:honbap_signal_flutter/models/home/home_signal_apply_list_model.dart';
import 'package:http/http.dart' as http;

import '../../../constants/api.dart';
import '../../../models/home/home_signal_applyed_list_model.dart';

class HomeSignalApplyRepository {
  Future<List<HomeSignalApplyedListModel>> getHomeSignalApplyedList({required String jwt}) async {
    final Map<String, String> headers = {
      "Content-Type": "application/json",
      'x-access-token': jwt,
    };

    final res = await http.get(
      Uri.parse('${ApiEndpoint.honbab}/signal/applyedlist'),
      headers: headers,
    );

    List<HomeSignalApplyedListModel> resultList = [];
    if(res.statusCode == 200) {
      for( var signalApplyJson in json.decode(res.body)['result'] as List<dynamic>) {
        resultList.add(HomeSignalApplyedListModel.fromJson(signalApplyJson));
      }
    }

    return resultList;
  }

  Future<List<HomeSignalApplyListModel>> getHomeSignalApplyList({required String jwt}) async {
    final Map<String, String> headers = {
      "Content-Type": "application/json",
      'x-access-token': jwt,
    };

    final res = await http.get(
      Uri.parse('${ApiEndpoint.honbab}/signal/applylist'),
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

  Future<bool> deleteFromApplylist({required String jwt}) async {
    final Map<String, String> headers = {
      "Content-Type": "application/json",
      'x-access-token': jwt,
    };

    // final data = {
    //   "latitude": position.latitude,
    //   "longitude": position.longitude,
    // };
    //
    // final locRes = await http.patch(
    //   Uri.parse('${ApiEndpoint.honbab}/signalFind'), // 요청 URL
    //   headers: headers,
    //   body: json.encode(location),
    // );

    final res = await http.delete(
      Uri.parse('${ApiEndpoint.honbab}/signal/status'),
      headers: headers,
    );

    if (res.statusCode == 200) {
      final responseData = json.decode(res.body);
      if (responseData['isSuccess'] == true && responseData['code'] == 1000) {
        final resultState = responseData['result']['sigStatus'] == 1;
        return resultState;
      } else {
        throw Exception("failed to fetch data");
      }
    } else {
      throw Exception("failtd to fetch data");
    }
  }
}