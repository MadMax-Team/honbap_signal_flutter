import 'dart:convert';
import 'dart:io' as io;
import 'package:honbap_signal_flutter/constants/api.dart';
import 'package:honbap_signal_flutter/models/res_code_model.dart';
import 'package:honbap_signal_flutter/models/user/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';

class UserProfileRepository {
  Future<String?> uploadProfileImage({
    required String jwt,
    required io.File profileFile,
  }) async {
    final Map<String, String> headers = {
      'x-access-token': jwt,
      'Content-Type': 'multipart/form-data',
    };

    // Check if the file extension is in the list of supported formats
    List<String> supportedFormats = ['png', 'jpg', 'jpeg', 'gif', 'bmp'];
    String fileExtension = io.Platform.isWindows
        ? path.extension(profileFile.path).toLowerCase()
        : profileFile.path.split('.').last.toLowerCase();

    if (!supportedFormats.contains(fileExtension)) {
      throw Exception('unsupported image format');
    }

    var url = Uri.parse('${ApiEndpoint.honbab}/user/myimage');
    var request = http.MultipartRequest('PATCH', url);
    request.headers.addAll(headers);
    request.files.add(http.MultipartFile(
      'file',
      http.ByteStream(Stream.castFrom(profileFile.openRead())),
      await profileFile.length(),
      contentType: MediaType('image', fileExtension),
      filename: profileFile.path,
    ));

    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('fail to upload profile image');
    }
  }

  Future<ResCodeModel?> updateProfile({
    required String jwt,
    required UserProfileModel profile,
  }) async {
    final Map<String, String> headers = {
      "Content-Type": "application/json",
      'x-access-token': jwt,
    };

    final res = await http.patch(
      Uri.parse('${ApiEndpoint.honbab}/user/mypage'),
      headers: headers,
      body: jsonEncode(profile.toJson()),
    );

    if (res.statusCode == 200) {
      return ResCodeModel.fromJson(jsonDecode(res.body));
    } else {
      return null;
    }
  }

  Future<ResCodeModel?> updatePassword({
    required String jwt,
    required String pw,
  }) async {
    final Map<String, String> headers = {
      "Content-Type": "application/json",
      'x-access-token': jwt,
    };

    final res = await http.patch(
      Uri.parse('${ApiEndpoint.honbab}/user/myinfo/modifypw'),
      headers: headers,
      body: jsonEncode({'password': pw}),
    );

    if (res.statusCode == 200) {
      return ResCodeModel.fromJson(jsonDecode(res.body));
    } else {
      return null;
    }
  }
}
