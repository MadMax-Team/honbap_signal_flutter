class ResCodeModel {
  final bool isSuccess;
  final int code;
  final String message;

  ResCodeModel({
    required this.isSuccess,
    required this.code,
    required this.message,
  });

  ResCodeModel.fromJson(Map<String, dynamic> json)
      : isSuccess = json['isSuccess'],
        code = json['code'],
        message = json['message'];
}
