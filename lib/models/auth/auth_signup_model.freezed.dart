// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_signup_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AuthSignupModel _$AuthSignupModelFromJson(Map<String, dynamic> json) {
  return _AuthSignupModel.fromJson(json);
}

/// @nodoc
mixin _$AuthSignupModel {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get nickName => throw _privateConstructorUsedError;
  String get birth => throw _privateConstructorUsedError;
  String get phoneNum => throw _privateConstructorUsedError;
  String get sex => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthSignupModelCopyWith<AuthSignupModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthSignupModelCopyWith<$Res> {
  factory $AuthSignupModelCopyWith(
          AuthSignupModel value, $Res Function(AuthSignupModel) then) =
      _$AuthSignupModelCopyWithImpl<$Res, AuthSignupModel>;
  @useResult
  $Res call(
      {String email,
      String password,
      String nickName,
      String birth,
      String phoneNum,
      String sex});
}

/// @nodoc
class _$AuthSignupModelCopyWithImpl<$Res, $Val extends AuthSignupModel>
    implements $AuthSignupModelCopyWith<$Res> {
  _$AuthSignupModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? nickName = null,
    Object? birth = null,
    Object? phoneNum = null,
    Object? sex = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      nickName: null == nickName
          ? _value.nickName
          : nickName // ignore: cast_nullable_to_non_nullable
              as String,
      birth: null == birth
          ? _value.birth
          : birth // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNum: null == phoneNum
          ? _value.phoneNum
          : phoneNum // ignore: cast_nullable_to_non_nullable
              as String,
      sex: null == sex
          ? _value.sex
          : sex // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AuthSignupModelCopyWith<$Res>
    implements $AuthSignupModelCopyWith<$Res> {
  factory _$$_AuthSignupModelCopyWith(
          _$_AuthSignupModel value, $Res Function(_$_AuthSignupModel) then) =
      __$$_AuthSignupModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String email,
      String password,
      String nickName,
      String birth,
      String phoneNum,
      String sex});
}

/// @nodoc
class __$$_AuthSignupModelCopyWithImpl<$Res>
    extends _$AuthSignupModelCopyWithImpl<$Res, _$_AuthSignupModel>
    implements _$$_AuthSignupModelCopyWith<$Res> {
  __$$_AuthSignupModelCopyWithImpl(
      _$_AuthSignupModel _value, $Res Function(_$_AuthSignupModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? nickName = null,
    Object? birth = null,
    Object? phoneNum = null,
    Object? sex = null,
  }) {
    return _then(_$_AuthSignupModel(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      nickName: null == nickName
          ? _value.nickName
          : nickName // ignore: cast_nullable_to_non_nullable
              as String,
      birth: null == birth
          ? _value.birth
          : birth // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNum: null == phoneNum
          ? _value.phoneNum
          : phoneNum // ignore: cast_nullable_to_non_nullable
              as String,
      sex: null == sex
          ? _value.sex
          : sex // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AuthSignupModel implements _AuthSignupModel {
  _$_AuthSignupModel(
      {this.email = '',
      this.password = '',
      this.nickName = '',
      this.birth = '',
      this.phoneNum = '',
      this.sex = ''});

  factory _$_AuthSignupModel.fromJson(Map<String, dynamic> json) =>
      _$$_AuthSignupModelFromJson(json);

  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey()
  final String password;
  @override
  @JsonKey()
  final String nickName;
  @override
  @JsonKey()
  final String birth;
  @override
  @JsonKey()
  final String phoneNum;
  @override
  @JsonKey()
  final String sex;

  @override
  String toString() {
    return 'AuthSignupModel(email: $email, password: $password, nickName: $nickName, birth: $birth, phoneNum: $phoneNum, sex: $sex)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthSignupModel &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.nickName, nickName) ||
                other.nickName == nickName) &&
            (identical(other.birth, birth) || other.birth == birth) &&
            (identical(other.phoneNum, phoneNum) ||
                other.phoneNum == phoneNum) &&
            (identical(other.sex, sex) || other.sex == sex));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, email, password, nickName, birth, phoneNum, sex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthSignupModelCopyWith<_$_AuthSignupModel> get copyWith =>
      __$$_AuthSignupModelCopyWithImpl<_$_AuthSignupModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AuthSignupModelToJson(
      this,
    );
  }
}

abstract class _AuthSignupModel implements AuthSignupModel {
  factory _AuthSignupModel(
      {final String email,
      final String password,
      final String nickName,
      final String birth,
      final String phoneNum,
      final String sex}) = _$_AuthSignupModel;

  factory _AuthSignupModel.fromJson(Map<String, dynamic> json) =
      _$_AuthSignupModel.fromJson;

  @override
  String get email;
  @override
  String get password;
  @override
  String get nickName;
  @override
  String get birth;
  @override
  String get phoneNum;
  @override
  String get sex;
  @override
  @JsonKey(ignore: true)
  _$$_AuthSignupModelCopyWith<_$_AuthSignupModel> get copyWith =>
      throw _privateConstructorUsedError;
}
