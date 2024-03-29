import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel extends Equatable {
  final String? jwt;
  final int? userIdx;
  final String? userName;
  final String? birth;
  final String? email;
  final String? phoneNum;
  final String? sex;
  final String? createAt;
  final String? updateAt;
  final UserProfileModel? userProfile;

  const UserModel({
    this.jwt,
    this.userIdx,
    this.userName,
    this.birth,
    this.email,
    this.phoneNum,
    this.sex,
    this.createAt,
    this.updateAt,
    this.userProfile,
  });

  UserModel copyWith({
    String? jwt,
    int? userIdx,
    String? userName,
    String? birth,
    String? email,
    String? phoneNum,
    String? sex,
    String? createAt,
    String? updateAt,
    UserProfileModel? userProfile,
  }) =>
      UserModel(
        jwt: jwt ?? this.jwt,
        userIdx: userIdx ?? this.userIdx,
        userName: userName ?? this.userName,
        birth: birth ?? this.birth,
        email: email ?? this.email,
        phoneNum: phoneNum ?? this.phoneNum,
        sex: sex ?? this.sex,
        createAt: createAt ?? this.createAt,
        updateAt: updateAt ?? this.updateAt,
        userProfile: userProfile ?? this.userProfile,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [
        jwt,
        userIdx,
        userName,
        birth,
        email,
        phoneNum,
        sex,
        createAt,
        updateAt,
        userProfile,
      ];
}

@JsonSerializable()
class UserProfileModel extends Equatable {
  final String? nickName;
  final String? profileImg;
  final String? taste;
  final String? hateFood;
  final String? interest;
  final String? avgSpeed;
  final String? preferArea;
  final String? mbti;
  final String? userIntroduce;

  const UserProfileModel({
    this.nickName,
    this.profileImg,
    this.taste,
    this.hateFood,
    this.interest,
    this.avgSpeed,
    this.preferArea,
    this.mbti,
    this.userIntroduce,
  });

  UserProfileModel copyWith({
    String? nickName,
    String? profileImg,
    String? taste,
    String? hateFood,
    String? interest,
    String? avgSpeed,
    String? preferArea,
    String? mbti,
    String? userIntroduce,
  }) =>
      UserProfileModel(
        nickName: nickName ?? this.nickName,
        profileImg: profileImg ?? this.profileImg,
        taste: taste ?? this.taste,
        hateFood: hateFood ?? this.hateFood,
        interest: interest ?? this.interest,
        avgSpeed: avgSpeed ?? this.avgSpeed,
        preferArea: preferArea ?? this.preferArea,
        mbti: mbti ?? this.mbti,
        userIntroduce: userIntroduce ?? this.userIntroduce,
      );

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);

  @override
  List<Object?> get props => [
        nickName,
        profileImg,
        taste,
        hateFood,
        interest,
        avgSpeed,
        preferArea,
        mbti,
        userIntroduce,
      ];
}
