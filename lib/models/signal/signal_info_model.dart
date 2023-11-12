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

  SignalInfoModel copyWith({
    String? sigPromiseTime,
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
