import 'package:equatable/equatable.dart';

class HomeSignalApplyListModel extends Equatable {
  final int applyedIdx;
  final String? profileImg;
  final String? nickName;

  const HomeSignalApplyListModel({
    required this.applyedIdx,
    this.profileImg,
    this.nickName,
  });

  factory HomeSignalApplyListModel.fromJson(Map<String, dynamic> json) {
    return HomeSignalApplyListModel(
      applyedIdx: json['applyedIdx'] as int,
      profileImg: json['profileImg'] as String?,
      nickName: json['nickName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['applyedIdx'] = applyedIdx;
    data['profileImg'] = profileImg;
    data['nickName'] = nickName;
    return data;
  }

  @override
  List<Object?> get props => [
        applyedIdx,
        profileImg,
        nickName,
      ];
}
