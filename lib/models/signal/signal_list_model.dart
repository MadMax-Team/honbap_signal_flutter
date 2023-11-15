import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'signal_list_model.g.dart';

@JsonSerializable()
class SignalListModel extends Equatable {
  final int? userIdx, signalIdx, checkSigWrite;
  final String? profileImg, userName, userIntroduce;
  final String? sigPromiseArea, sigPromiseTime, sigPromiseMenu;
  final String? interest;
  final String? taste, hateFood, preferArea, mbti;
  final double? distance;

  const SignalListModel({
    this.userIdx,
    this.signalIdx,
    this.checkSigWrite,
    this.profileImg,
    this.userName,
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
        userName,
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
