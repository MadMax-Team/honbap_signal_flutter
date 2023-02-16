class MyPageMyInfoModel {
  final String userId, userName, birth, email, phoneNum, sex;

  MyPageMyInfoModel.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        userName = json['userName'],
        birth = json['birth'],
        email = json['email'],
        phoneNum = json['phoneNum'],
        sex = json['sex'];
}
