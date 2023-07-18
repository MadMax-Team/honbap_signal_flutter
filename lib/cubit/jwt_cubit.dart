import 'package:hydrated_bloc/hydrated_bloc.dart';

class JWTCubit extends HydratedCubit<String?> {
  JWTCubit() : super(null);

  void setJWT(String? jwt) => emit(jwt);

  @override
  String? fromJson(Map<String, dynamic> json) => json['jwt'] as String?;

  @override
  Map<String, dynamic>? toJson(String? state) => {'jwt': state};
}
