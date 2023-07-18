import 'dart:convert';
import 'package:http/http.dart' as http;

Future<bool> getUserProfileResponse(
    {required Map<String, String?> formData}) async {
  var url =
      Uri.parse('https://ac9953f2-1bfc-45c1-8592-56b7789dbc0a.mock.pstmn.io');
  final body = jsonEncode(formData);
  final response = await http.post(
    url,
    body: body,
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to Post Initial Profile');
  }
}
