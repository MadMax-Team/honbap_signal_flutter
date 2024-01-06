import 'package:honbap_signal_flutter/models/signal/signal_info_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'signal_state_model.g.dart';

/// 추천 사용처 - Bloc 에서 관리
/// - 홈 화면의 버튼 제어용
/// - 홈 화면의 나의 매칭 상대 정보 확인용
/// - 채팅 화면의 시그널 정보 확인용
@JsonSerializable(explicitToJson: true)
class SignalStateModel extends SignalInfoModel {
  final int? oppoUserIdx;
  final int? matchUserIdx;
  final String? oppoNickName;
  final String? imgUrl;

  const SignalStateModel({
    this.oppoUserIdx,
    this.matchUserIdx,
    this.oppoNickName,
    this.imgUrl,
    super.sigPromiseTime,
    super.sigPromiseArea,
    super.sigPromiseMenu,
  });

  factory SignalStateModel.fromJson(Map<String, dynamic> json) =>
      _$SignalStateModelFromJson(json);

  @override
  List<Object?> get props => [
        oppoUserIdx,
        matchUserIdx,
        oppoNickName,
        imgUrl,
        sigPromiseTime,
        sigPromiseArea,
        sigPromiseMenu,
      ];
}
