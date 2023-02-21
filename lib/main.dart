import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/Themes/create_material_color.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/screens/auth/auth_screen.dart';
import 'package:honbap_signal_flutter/screens/user/widgets/initial_profile_setting_dialog_widget.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'apis/kakao_api_key.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Kakao SDK initialize
  KakaoSdk.init(nativeAppKey: KAKAO_API_KEY);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '혼밥시그널',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ko'),
      ],
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: createMaterialColor(const Color(0xffff4b25)),
        textTheme: const TextTheme(
          // 2022 sets
          // displayLarge, displayMedium, displaySmall
          // headlineLarge, headlineMedium, headlineSmall
          // titleLarge, titleMedium, titleSmall
          // bodyLarge, bodyMedium, bodySmall
          // labelLarge, labelMedium, labelSmall
          titleMedium: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: Sizes.size20,
          ),
          titleSmall: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: Sizes.size16,
          ),
          labelSmall: TextStyle(
            color: Color(0xFFB8B8B8),
            fontSize: Sizes.size10,
            letterSpacing: Sizes.size1 / Sizes.size2,
          ),
        ),
      ),
      home: const InitialProfileDialog(),
    );
  }
}
