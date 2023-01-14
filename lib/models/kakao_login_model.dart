class KakaoLoginModel {
  final int id;
  final String connectedAt;
  final _KakaoPropertiesModel properties;
  final _KakaoAccountModel kakaoAccount;

  KakaoLoginModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        connectedAt = json['connected_at'],
        properties = _KakaoPropertiesModel.fromJson(json['properties']),
        kakaoAccount = _KakaoAccountModel.fromJson(json['kakao_account']);
}

class _KakaoPropertiesModel {
  final String nickname;

  _KakaoPropertiesModel.fromJson(Map<String, dynamic> json)
      : nickname = json['nickname'];
}

class _KakaoAccountModel {
  final bool profileNicknameNeedsAgreement,
      hasEmail,
      emailNeedsAgreement,
      isEmailValid,
      isEmailVerified;
  final _KakaoPropertiesModel profile;
  final String email;

  _KakaoAccountModel.fromJson(Map<String, dynamic> json)
      : profileNicknameNeedsAgreement =
            json['profile_nickname_needs_agreement'],
        profile = _KakaoPropertiesModel.fromJson(json['profile']),
        hasEmail = json['has_email'],
        emailNeedsAgreement = json['email_needs_agreement'],
        isEmailValid = json['is_email_valid'],
        isEmailVerified = json['is_email_verified'],
        email = json['email'];
}
