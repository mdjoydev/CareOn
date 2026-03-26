import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home/home_screen.dart';
import 'services/services_screen.dart';
import 'tips_screen.dart';
import 'profile_screen.dart';
import 'sos_screen.dart';
import 'health_checkup_packages_screen.dart';
import '../widgets/bottom_navbar.dart';
import '../core/state/language_provider.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentIndex = 0;

  void _handleTabSelected(int index) {
    if (index == 2) {
      _handleSosTap();
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  void _handleSosTap() {
    final provider = Provider.of<LanguageProvider>(context, listen: false);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => SosScreen(isBangla: provider.isBangla),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LanguageProvider>(context);
    final isBangla = provider.isBangla;

    final List<Widget> screens = [
      HomeScreen(
        onSosTap: _handleSosTap,
        onViewAllServices: () => setState(() => _currentIndex = 1),
        onViewAllCheckups: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => HealthCheckupPackagesScreen(isBangla: isBangla),
            ),
          );
        },
      ),
      ServicesScreen(isBangla: isBangla),
      const SizedBox(), // SOS Placeholder
      HealthTipsScreen(isBangla: isBangla),
      ProfileScreen(
        onLanguageToggle: () => provider.toggleLanguage(),
      ),
    ];

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavbar(
        currentIndex: _currentIndex,
        onTabSelected: _handleTabSelected,
        onSosTap: _handleSosTap,
        isBangla: isBangla,
      ),
    );
  }
}
