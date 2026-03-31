import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import 'screens/onboarding_screen.dart';
import 'screens/login_screen.dart';
import 'screens/main_app.dart';
import 'core/theme/app_theme.dart';
import 'core/state/language_provider.dart';
import 'core/state/user_session.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize and load user session
  await UserSession.instance.loadSession();

  // Android settings
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  // iOS settings
  const DarwinInitializationSettings initializationSettingsDarwin =
  DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider.value(value: UserSession.instance),
      ],
      child: const CareOnApp(),
    ),
  );
}

class CareOnApp extends StatelessWidget {
  const CareOnApp({super.key});

  static const Color careOnGreen = Color(0xFF00A66C);
  static const Color careOnBlue = Color(0xFF0277BD);
  static const Color appBackground = Color(0xFFF8F9FA);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CareOn',
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: MediaQuery.textScalerOf(context).clamp(
              minScaleFactor: 0.85,
              maxScaleFactor: 1.25,
            ),
          ),
          child: child!,
        );
      },
      theme: AppTheme.light(context).copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: careOnGreen,
          primary: careOnGreen,
        ),
        scaffoldBackgroundColor: appBackground,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: careOnGreen, width: 2),
          ),
          prefixIconColor: Colors.grey.shade400,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: careOnGreen,
            minimumSize: const Size(double.infinity, 54),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: AppTheme.light(context).textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      home: _getHome(),
    );
  }

  Widget _getHome() {
    final session = UserSession.instance;
    if (session.name != null && session.name!.isNotEmpty) {
      return const MainApp();
    } else if (session.hasSeenOnboarding) {
      return LoginScreen();
    } else {
      return const OnboardingScreen();
    }
  }
}
