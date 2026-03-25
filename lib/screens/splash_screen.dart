import 'package:flutter/material.dart';

import '../constants/assets.dart';
import 'onboarding_screen.dart';
import 'main_app.dart';
import '../core/state/user_session.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Splash screen time set to 2.5 seconds
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (!mounted) return;
      
      final session = UserSession.instance;
      if (session.name != null && session.name!.isNotEmpty) {
        // User is logged in, go to main app
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MainApp()),
        );
      } else {
        // User not logged in, go to onboarding
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const OnboardingScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background set to white
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.8, end: 1.0),
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeOutBack,
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: child,
            );
          },
          child: Image.asset(
            CareOnAssets.splashScreen, // Using splash screen.png
            width: 280, // Adjusted width for splash screen image
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
