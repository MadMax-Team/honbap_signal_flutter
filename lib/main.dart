import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/app.dart';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_bloc.dart';
import 'package:honbap_signal_flutter/bloc/splash/splash_bloc.dart';
import 'package:honbap_signal_flutter/cubit/user_cubit.dart';
import 'package:honbap_signal_flutter/repository/honbab/auth/auth_repository.dart';
import 'package:honbap_signal_flutter/repository/honbab/auth/auth_signup_repository.dart';
import 'package:honbap_signal_flutter/repository/kakao/kakao_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:path_provider/path_provider.dart';
import 'apis/kakao_api_key.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Kakao SDK initialize
  KakaoSdk.init(nativeAppKey: KAKAO_API_KEY);

  // for hydrated_bloc
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => KakaoRepository(),
        ),
        RepositoryProvider(
          create: (context) => HonbabAuthSignupRepository(),
        ),
        RepositoryProvider(
          create: (context) => HonbabAuthRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AuthenticationBloc(context.read<HonbabAuthRepository>()),
          ),
          BlocProvider(
            create: (context) => UserCubit(),
          ),
          BlocProvider(
            create: (context) => SplashBloc(),
          ),
        ],
        child: const App(),
      ),
    );
  }
}
