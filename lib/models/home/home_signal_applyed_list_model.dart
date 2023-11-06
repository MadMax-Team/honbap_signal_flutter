import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class HomeSignalApplyedListModel extends Equatable {
  final int userIdx;
  final String? profileImg;
  final String? nickName;

  const HomeSignalApplyedListModel({
    required this.userIdx,
    this.profileImg,
    this.nickName,
  });

  factory HomeSignalApplyedListModel.fromJson(Map<String, dynamic> json) {
    return HomeSignalApplyedListModel(
      userIdx: json['userIdx'] as int,
      profileImg: json['profileImg'] as String?,
      nickName: json['nickName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['userIdx'] = userIdx;
    data['profileImg'] = profileImg;
    data['nickName'] = nickName;
    return data;
  }

  @override
  List<Object?> get props => [userIdx, profileImg, nickName];

}