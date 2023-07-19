import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel extends Equatable {
  final String? jwt;
  final int? userId;
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
    this.userId,
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
    int? userId,
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
        userId: userId ?? this.userId,
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
        userId,
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
  final String? profileImg;
  final String? taste;
  final String? hateFood;
  final String? interest;
  final String? avgSpeed;
  final String? preferArea;
  final String? mbti;
  final String? userIntroduce;
  final String? updateAt;

  const UserProfileModel({
    this.profileImg,
    this.taste,
    this.hateFood,
    this.interest,
    this.avgSpeed,
    this.preferArea,
    this.mbti,
    this.userIntroduce,
    this.updateAt,
  });

  UserProfileModel copyWith({
    String? profileImg,
    String? taste,
    String? hateFood,
    String? interest,
    String? avgSpeed,
    String? preferArea,
    String? mbti,
    String? userIntroduce,
    String? updateAt,
  }) =>
      UserProfileModel(
        profileImg: profileImg ?? this.profileImg,
        taste: taste ?? this.taste,
        hateFood: hateFood ?? this.hateFood,
        interest: interest ?? this.interest,
        avgSpeed: avgSpeed ?? this.avgSpeed,
        preferArea: preferArea ?? this.preferArea,
        mbti: mbti ?? this.mbti,
        userIntroduce: userIntroduce ?? this.userIntroduce,
        updateAt: updateAt ?? this.updateAt,
      );

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);

  @override
  List<Object?> get props => [
        profileImg,
        taste,
        hateFood,
        interest,
        avgSpeed,
        preferArea,
        mbti,
        userIntroduce,
        updateAt,
      ];
}
