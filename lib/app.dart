import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:honbap_signal_flutter/Themes/create_material_color.dart';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_bloc.dart';
import 'package:honbap_signal_flutter/bloc/auth/authentication/authentication_state.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/screens/routes/route_navigation_widget.dart';
import 'package:honbap_signal_flutter/screens/auth/auth_screen.dart';
import 'package:honbap_signal_flutter/screens/splash/splash_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = GoRouter(
      initialLocation: '/',
      refreshListenable: context.read<AuthenticationBloc>(),
      redirect: (context, state) {
        var authState = context.read<AuthenticationBloc>().state.status;

        switch (authState) {
          case AuthenticationStatus.init:
            return '/';
          case AuthenticationStatus.loading:
          case AuthenticationStatus.error:
            break;
          case AuthenticationStatus.unauthenticated:
            return '/auth';
          case AuthenticationStatus.authenticated:
            return '/home';
        }
        return state.path;
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          path: '/auth',
          builder: (context, state) => const AuthScreen(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const RouteNavigationWidget(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
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
        fontFamily: 'Pretendard',
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
            fontSize: Sizes.size14,
            letterSpacing: Sizes.size1 / Sizes.size2,
          ),
        ),
      ),
    );
  }
}
