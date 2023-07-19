import 'package:equatable/equatable.dart';

enum LoadStatus {
  init('초기화'),
  loadingAuth("로그인 체크"),
  loadingUserData("사용자 정보를 불러오는"),
  loadingUserProfileData("사용자 프로필을 불러오는");

  final String message;

  const LoadStatus(this.message);
}

class SplashState extends Equatable {
  final LoadStatus status;

  const SplashState({
    required this.status,
  });

  @override
  List<Object?> get props => [status];
}
