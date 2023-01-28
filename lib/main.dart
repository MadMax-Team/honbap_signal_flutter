import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/Themes/create_material_color.dart';
import 'package:honbap_signal_flutter/routes/route_navigation_widget.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'apis/kakao_api_key.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Kakao SDK initialize
  KakaoSdk.init(nativeAppKey: KAKAO_API_KEY);

  initializeDateFormatting();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '혼밥시그널',
      theme: ThemeData(
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
            fontSize: 20,
          ),
          labelSmall: TextStyle(
            color: Color(0xFFB8B8B8),
            fontSize: 10,
            letterSpacing: 0.5,
          ),
        ),
      ),
      home: const RouteNavigationWidget(),
    );
  }
}
