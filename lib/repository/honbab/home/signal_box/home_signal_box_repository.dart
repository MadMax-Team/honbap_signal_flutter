import 'dart:convert';

import '../../../../constants/api.dart';
import 'package:http/http.dart' as http;

import '../location_repository.dart';

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

    final position = await LocationRepository().fetchLocation();
    print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');

    final location = {
      "latitude": position.latitude,
      "longitude": position.longitude,
    };

    final locRes = await http.patch(
      Uri.parse('${ApiEndpoint.honbab}/signalFind'), // 요청 URL
      headers: headers,
      body: json.encode(location),
    );

    if (locRes.statusCode == 200) {
      final responseData = json.decode(locRes.body);
      if (responseData['isSuccess'] == true && responseData['code'] == 1000) {
      } else {
        throw Exception("failed to location data");
      }
    } else {
      throw Exception("failtd to location data");
    }

    final data = {
      "sigPromiseTime": sigPromiseTime,
      "sigPromiseArea": sigPromiseArea,
      "sigPromiseMenu": sigPromiseMenu,
    };

    final res = await http.post(
      Uri.parse('${ApiEndpoint.honbab}/signal/list'), // 요청 URL
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

  Future<void> sendToSignalOff({
    required String jwt,
  }) async {
    final headers = {
      "Content-Type": "application/json",
      'x-access-token': jwt,
    };

    final res = await http.delete(
      Uri.parse('${ApiEndpoint.honbab}/signal/list/off'), // 요청 URL
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
      Uri.parse('${ApiEndpoint.honbab}/signal/info'),
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