import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_signin_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthSigninModel extends Equatable {
  final bool? isSuccess;
  final int? code;
  final String? message;
  final AuthSigninUserDataModel? result;

  const AuthSigninModel({
    this.isSuccess,
    this.code,
    this.message,
    this.result,
  });

  factory AuthSigninModel.fromJson(Map<String, dynamic> json) =>
      _$AuthSigninModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthSigninModelToJson(this);

  @override
  List<Object?> get props => [
        isSuccess,
        code,
        message,
        result,
      ];
}

@JsonSerializable()
class AuthSigninUserDataModel extends Equatable {
  final int? userIdx;
  final String? jwt;

  const AuthSigninUserDataModel({
    this.userIdx,
    this.jwt,
  });

  AuthSigninUserDataModel copyWith({
    int? userIdx,
    String? jwt,
  }) =>
      AuthSigninUserDataModel(
        userIdx: userIdx ?? this.userIdx,
        jwt: jwt ?? this.jwt,
      );

  factory AuthSigninUserDataModel.fromJson(Map<String, dynamic> json) =>
      _$AuthSigninUserDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthSigninUserDataModelToJson(this);

  @override
  List<Object?> get props => [
        userIdx,
        jwt,
      ];
}
