import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/app.dart';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_bloc.dart';
import 'package:honbap_signal_flutter/bloc/splash/splash_bloc.dart';
import 'package:honbap_signal_flutter/cubit/fcm_cubit.dart';
import 'package:honbap_signal_flutter/cubit/user_cubit.dart';
import 'package:honbap_signal_flutter/firebase_options.dart';
import 'package:honbap_signal_flutter/repository/honbab/auth/auth_repository.dart';
import 'package:honbap_signal_flutter/repository/honbab/auth/auth_signup_repository.dart';
import 'package:honbap_signal_flutter/repository/honbab/home/location_repository.dart';
import 'package:honbap_signal_flutter/repository/kakao/kakao_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:path_provider/path_provider.dart';
import 'apis/kakao_api_key.dart';

RemoteMessage? bgMessage;

void main() async {
  // flutter ensure initialized
  WidgetsFlutterBinding.ensureInitialized();

  // initialize all dependencies
  await initializeDependencies();

  // listening fcm from background

  FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);

  // get fcm token
  String? fcmToken = await FirebaseMessaging.instance.getToken();
  print('FCM Token: $fcmToken');

  runApp(MyApp(
    fcmToken: fcmToken ?? '',
    bgMessage: bgMessage,
  ));
}

Future<void> _onBackgroundMessage(RemoteMessage message) async {
  bgMessage = message;
  print('bg fcm: ${message.notification?.title}');
}

Future<void> initializeDependencies() async {
  // Firebase initialize
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // hydrated_bloc initialize
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  // Kakao SDK initialize
  KakaoSdk.init(nativeAppKey: KAKAO_API_KEY);
  // set FCM permission
  FirebaseMessaging.instance.requestPermission(
    badge: true,
    alert: true,
    sound: true,
  );
}

class MyApp extends StatelessWidget {
  final String fcmToken;
  final RemoteMessage? bgMessage;

  const MyApp({
    super.key,
    required this.fcmToken,
    this.bgMessage,
  });

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
        RepositoryProvider(
          create: (context) => LocationRepository(),
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
          BlocProvider(
            create: (context) => FCMCubit(
              fcmToken,
              bgMessage,
            ),
            lazy: false,
          ),
        ],
        child: const App(),
      ),
    );
  }
}
