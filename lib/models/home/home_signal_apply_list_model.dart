import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class HomeSignalApplyListModel extends Equatable {
  final String? nickName;

  const HomeSignalApplyListModel({
    this.nickName,
  });

  factory HomeSignalApplyListModel.fromJson(Map<String, dynamic> json) {
    return HomeSignalApplyListModel(
      nickName: json['nickName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['nickName'] = nickName;
    return data;
  }

  @override
  List<Object?> get props => [nickName];

}