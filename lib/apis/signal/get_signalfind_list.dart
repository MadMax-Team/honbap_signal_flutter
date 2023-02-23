import 'dart:convert';
import 'package:honbap_signal_flutter/models/signal/signal_signal_list_model.dart';
import 'package:http/http.dart' as http;

Future<List<SignalSignalListModel>> getSignalFindList() async {
  // TODO: get jwt
  const String jwt = 'testJWTStringValue123';

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'x-access-token': jwt,
  };

  final res = await http.get(
    Uri.parse(
        'https://dc717f14-ad08-4610-bea0-e2a54a8de8d6.mock.pstmn.io/signalFind/list'),
    headers: headers,
  );

  if (res.statusCode == 200) {
    List<SignalSignalListModel> resultList = [];
    for (var signalJson in json.decode(res.body)['result'] as List<dynamic>) {
      resultList.add(SignalSignalListModel.fromJson(signalJson));
    }
    return resultList;
  } else {
    throw Exception('_getMyPageMyInfo() failed');
  }
}
