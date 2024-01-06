import 'package:equatable/equatable.dart';
import 'package:honbap_signal_flutter/tools/datetime_formatter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'signal_list_model.g.dart';

@JsonSerializable()
class SignalListModel extends Equatable {
  final int? userIdx, signalIdx, checkSigWrite;
  final String? profileImg, nickName, userIntroduce;
  final String? sigPromiseArea, sigPromiseMenu;
  @JsonKey(fromJson: strToDt, toJson: dtToStr)
  final DateTime? sigPromiseTime;
  final String? interest;
  final String? taste, hateFood, preferArea, mbti;
  final double? distance;

  const SignalListModel({
    this.userIdx,
    this.signalIdx,
    this.checkSigWrite,
    this.profileImg,
    this.nickName,
    this.userIntroduce,
    this.sigPromiseArea,
    this.sigPromiseTime,
    this.sigPromiseMenu,
    this.interest,
    this.taste,
    this.hateFood,
    this.preferArea,
    this.mbti,
    this.distance,
  });

  factory SignalListModel.fromJson(Map<String, dynamic> json) =>
      _$SignalListModelFromJson(json);

  @override
  List<Object?> get props => [
        userIdx,
        signalIdx,
        checkSigWrite,
        profileImg,
        nickName,
        userIntroduce,
        sigPromiseArea,
        sigPromiseTime,
        sigPromiseMenu,
        interest,
        taste,
        hateFood,
        preferArea,
        mbti,
        distance,
      ];
}
