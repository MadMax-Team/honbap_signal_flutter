import 'package:equatable/equatable.dart';
import 'package:honbap_signal_flutter/models/user/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_signin_model.g.dart';

@JsonSerializable()
class AuthSigninAutoModel extends Equatable {
  final bool? isSuccess;
  final int? code;
  final String? message;
  final int? result;

  const AuthSigninAutoModel({
    this.isSuccess,
    this.code,
    this.message,
    this.result,
  });

  factory AuthSigninAutoModel.fromJson(Map<String, dynamic> json) =>
      _$AuthSigninAutoModelFromJson(json);

  @override
  List<Object?> get props => [
        isSuccess,
        code,
        message,
        result,
      ];
}

@JsonSerializable(explicitToJson: true)
class AuthSigninMyInfoModel extends Equatable {
  final bool? isSuccess;
  final int? code;
  final String? message;
  final UserModel? result;

  AuthSigninMyInfoModel({
    this.isSuccess,
    this.code,
    this.message,
    List<UserModel>? result,
  }) : result = result?.first;

  factory AuthSigninMyInfoModel.fromJson(Map<String, dynamic> json) =>
      _$AuthSigninMyInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthSigninMyInfoModelToJson(this);

  @override
  List<Object?> get props => [
        isSuccess,
        code,
        message,
        result,
      ];
}

// 배열로 오는 경우: 자동 로그인 시.
@JsonSerializable(explicitToJson: true)
class AuthSigninMyPageModel extends Equatable {
  final bool? isSuccess;
  final int? code;
  final String? message;
  final UserProfileModel? result;

  AuthSigninMyPageModel({
    this.isSuccess,
    this.code,
    this.message,
    List<UserProfileModel>? result,
  }) : result = result?.first;

  factory AuthSigninMyPageModel.fromJson(Map<String, dynamic> json) =>
      _$AuthSigninMyPageModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthSigninMyPageModelToJson(this);

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
