import 'dart:convert';

import '../../../../constants/api.dart';
import 'package:http/http.dart' as http;

class HomeSignalBoxRepository {

  Future<void> sendDataWithJwt({
    required String jwt,
    String? sigPromiseTime,
    String? sigPromiseArea,
    String? sigPromiseMenu,
  }) async {
    final headers = {
      "Content-Type": "application/json",
      'x-access-token': jwt,
    };

    final data = {
      "sigPromiseTime": sigPromiseTime,
      "sigPromiseArea": sigPromiseArea,
      "sigPromiseMenu": sigPromiseMenu,
    };

    final res = await http.post(
      Uri.parse('${ApiEndpoint.honbabHomeMock}/signal/list'), // 요청 URL
      headers: headers,
      body: json.encode(data),
    );

    if (res.statusCode == 200) {
      final responseData = json.decode(res.body);
      if (responseData['isSuccess'] == true && responseData['code'] == 1000) {

      } else {
        throw Exception("failed to fetch data");
      }
    } else {
      throw Exception("failtd to fetch data");
    }
  }

  Future<bool> getHomeSignalBoxState({required String jwt}) async {
    final Map<String, String> headers = {
      "Content-Type": "application/json",
      'x-access-token': jwt,
    };

    final res = await http.get(
      Uri.parse('${ApiEndpoint.honbabHomeMock}/signalState'),
      headers: headers,
    );

    if (res.statusCode == 200) {
      final responseData = json.decode(res.body);
      if (responseData['isSuccess'] == true && responseData['code'] == 1000) {
        final resultState = responseData['result']['state'] as bool;
        return resultState;
      } else {
        throw Exception("failed to fetch data");
      }
    } else {
      throw Exception("failtd to fetch data");
    }
  }

  Future<void> sendToSignalOff({
    required String jwt,
  }) async {
    final headers = {
      "Content-Type": "application/json",
      'x-access-token': jwt,
    };

    final res = await http.delete(
      Uri.parse('${ApiEndpoint.honbabHomeMock}/signal/list/off'), // 요청 URL
      headers: headers,
    );

    if (res.statusCode == 200) {
      final responseData = json.decode(res.body);
      if (responseData['isSuccess'] == true && responseData['code'] == 1000) {

      } else {
        throw Exception("failed to send data");
      }
    } else {
      throw Exception("failtd to send data");
    }
  }

  Future<Map<String, dynamic>> getSignalDetail({required String jwt}) async {
    final Map<String, String> headers = {
      "Content-Type": "application/json",
      'x-access-token': jwt,
    };

    final res = await http.get(
      Uri.parse('${ApiEndpoint.honbabHomeMock}/signal/detail'),
      headers: headers,
    );

    if (res.statusCode == 200) {
      final responseData = json.decode(res.body);
      if (responseData['isSuccess'] == true && responseData['code'] == 1000) {
        final resultData = responseData['result'] as Map<String, dynamic>;
        return resultData;
      } else {
        throw Exception("failed to fetch data");
      }
    } else {
      throw Exception("failtd to fetch data");
    }
  }
}