import 'package:equatable/equatable.dart';
import 'package:honbap_signal_flutter/tools/datetime_formatter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'signal_info_model.g.dart';

@JsonSerializable()
class SignalInfoModel extends Equatable {
  @JsonKey(fromJson: strToDt, toJson: dtToStr)
  final DateTime? sigPromiseTime;
  final String? sigPromiseArea;
  final String? sigPromiseMenu;

  const SignalInfoModel({
    this.sigPromiseTime,
    this.sigPromiseArea,
    this.sigPromiseMenu,
  });

  factory SignalInfoModel.fromJson(Map<String, dynamic> json) =>
      _$SignalInfoModelFromJson(json);

  SignalInfoModel copyWith({
    DateTime? sigPromiseTime,
    String? sigPromiseArea,
    String? sigPromiseMenu,
  }) =>
      SignalInfoModel(
        sigPromiseTime: sigPromiseTime ?? this.sigPromiseTime,
        sigPromiseArea: sigPromiseArea ?? this.sigPromiseArea,
        sigPromiseMenu: sigPromiseMenu ?? this.sigPromiseMenu,
      );

  @override
  List<Object?> get props => [
        sigPromiseTime,
        sigPromiseArea,
        sigPromiseMenu,
      ];
}
