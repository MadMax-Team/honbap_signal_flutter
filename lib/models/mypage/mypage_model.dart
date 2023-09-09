import 'package:honbap_signal_flutter/models/user/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mypage_model.g.dart';

@JsonSerializable()
class MyPageModel {
  final String? profileImg;
  final String? nickName;
  final String? userIntroduce;
  final List<String>? tags; // UserModel.interest
  final List<String>? preferArea;
  final List<String>? taste;
  final List<String>? hateFood;
  final String? mbti;

  const MyPageModel({
    this.profileImg,
    this.nickName,
    this.userIntroduce,
    this.tags,
    this.preferArea,
    this.taste,
    this.hateFood,
    this.mbti,
  });

  MyPageModel copyWith({
    String? profileImg,
    String? nickName,
    String? userIntroduce,
    List<String>? tags,
    List<String>? preferArea,
    List<String>? taste,
    List<String>? hateFood,
    String? mbti,
  }) =>
      MyPageModel(
        profileImg: profileImg ?? this.profileImg,
        nickName: nickName ?? this.nickName,
        userIntroduce: userIntroduce ?? this.userIntroduce,
        tags: tags ?? this.tags,
        preferArea: preferArea ?? this.preferArea,
        taste: taste ?? this.taste,
        hateFood: hateFood ?? this.hateFood,
        mbti: mbti ?? this.mbti,
      );

  factory MyPageModel.fromJson(Map<String, dynamic> json) =>
      _$MyPageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyPageModelToJson(this);

  // for server spec - UserProfileModel //
  MyPageModel.fromUserProfileModel(
    UserProfileModel? userProfile,
  )   : profileImg = userProfile?.profileImg,
        nickName = null, // copyWith로 받을 예정.
        userIntroduce = userProfile?.userIntroduce,
        tags = userProfile?.interest?.split(','),
        preferArea = userProfile?.preferArea?.split(','),
        taste = userProfile?.taste?.split(','),
        hateFood = userProfile?.hateFood?.split(','),
        mbti = userProfile?.mbti;

  UserProfileModel? toUserProfileModel() => UserProfileModel(
        profileImg: profileImg,
        taste: taste?.join(',').isNotEmpty == true ? taste?.join(',') : null,
        hateFood:
            hateFood?.join(',').isNotEmpty == true ? hateFood?.join(',') : null,
        interest: tags?.join(',').isNotEmpty == true ? tags?.join(',') : null,
        avgSpeed: null,
        preferArea: preferArea?.join(',').isNotEmpty == true
            ? preferArea?.join(',')
            : null,
        mbti: mbti,
        userIntroduce: userIntroduce,
      );
}

enum UserProfileForm {
  nickName('닉네임', ''),
  userIntroduce('소개글', '나의 취향이나 관심사가 담긴 소개글을 작성해주세요'),
  tags('태그선택', '나의 취향이나 관심사가 담긴 태그를 작성해주세요'),
  preferArea('선호장소', ''),
  taste('선호음식', ''),
  hateFood('불호음식', ''),
  mbti('MBTI', '');

  final String message;
  final String hint;

  const UserProfileForm(
    this.message,
    this.hint,
  );
}
