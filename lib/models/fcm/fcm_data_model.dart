import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fcm_data_model.g.dart';

@JsonSerializable()
class FCMDataModel extends Equatable {
  final String? code;
  final String? message;

  const FCMDataModel({this.code, this.message});

  factory FCMDataModel.fromJson(Map<String, dynamic> json) =>
      _$FCMDataModelFromJson(json);

  @override
  List<Object?> get props => [
        code,
        message,
      ];
}
