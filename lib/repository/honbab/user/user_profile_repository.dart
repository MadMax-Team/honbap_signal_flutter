import 'dart:io' as io;
import 'package:honbap_signal_flutter/constants/api.dart';
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
      return 'res string';
    } else {
      throw Exception('fail to upload profile image');
    }
  }
}
