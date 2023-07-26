import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'signal_list_model.g.dart';

@JsonSerializable()
class SignalListModel extends Equatable {
  final int? userIdx, signalIdx, checkSigWrite;
  final String? userName, userIntroduce;
  final String? taste, hateFood, interest, avgSpeed, preferArea, mbti, updateAt;
  final String? sigPromiseArea, sigPromiseTime;

  const SignalListModel({
    this.userIdx,
    this.signalIdx,
    this.checkSigWrite,
    this.userName,
    this.userIntroduce,
    this.taste,
    this.hateFood,
    this.interest,
    this.avgSpeed,
    this.preferArea,
    this.mbti,
    this.updateAt,
    this.sigPromiseArea,
    this.sigPromiseTime,
  });

  factory SignalListModel.fromJson(Map<String, dynamic> json) =>
      _$SignalListModelFromJson(json);

  @override
  List<Object?> get props => [
        userIdx,
        signalIdx,
        checkSigWrite,
        userName,
        userIntroduce,
        taste,
        hateFood,
        interest,
        avgSpeed,
        preferArea,
        mbti,
        updateAt,
        sigPromiseArea,
        sigPromiseTime,
      ];
}
