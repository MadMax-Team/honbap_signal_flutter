import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'signal_info_model.g.dart';

@JsonSerializable()
class SignalInfoModel extends Equatable {
  final String? sigPromiseTime;
  final String? sigPromiseArea;
  final String? sigPromiseMenu;

  const SignalInfoModel({
    this.sigPromiseTime,
    this.sigPromiseArea,
    this.sigPromiseMenu,
  });

  factory SignalInfoModel.fromJson(Map<String, dynamic> json) =>
      _$SignalInfoModelFromJson(json);

  @override
  List<Object?> get props => [
        sigPromiseTime,
        sigPromiseArea,
        sigPromiseMenu,
      ];
}
