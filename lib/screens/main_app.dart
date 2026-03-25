import 'package:flutter/material.dart';

import 'home/home_screen.dart';
import 'services/services_screen.dart';
import 'tips_screen.dart';
import 'profile_screen.dart';
import 'sos_screen.dart';
import '../widgets/bottom_navbar.dart';

class LanguageProvider with ChangeNotifier {
  bool _isBangla = false;

  bool get isBangla => _isBangla;

  void toggleLanguage() {
    _isBangla = !_isBangla;
    notifyListeners();
  }
}

class MainApp extends StatelessWidget {
  final bool isBangla;
  const MainApp({super.key, this.isBangla = false});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LanguageProvider().._isBangla = isBangla,
      child: const _MainAppContent(),
    );
  }
}

class _MainAppContent extends StatefulWidget {
  const _MainAppContent({super.key});

  @override
  State<_MainAppContent> createState() => _MainAppContentState();
}

class _MainAppContentState extends State<_MainAppContent> {
  int _currentIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _initializeScreens();
  }

  void _initializeScreens() {
    _screens = [
      HomeScreen(
        onSosTap: _handleSosTap,
        onViewAllServices: () {
          setState(() => _currentIndex = 1);
        },
        onViewAllCheckups: () {
          // Handle view all checkups
        },
      ),
      ServicesScreen(),
      const SizedBox(), // Placeholder for SOS (handled by floating button)
      HealthTipsScreen(),
      ProfileScreen(
        onLanguageToggle: () {
          final provider = Provider.of<LanguageProvider>(context, listen: false);
          provider.toggleLanguage();
        },
      ),
    ];
  }

  void _handleTabSelected(int index) {
    if (index == 2) {
      // SOS is handled by the floating button, not tab
      _handleSosTap();
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  void _handleSosTap() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => const SosScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LanguageProvider>(context);
    final isBangla = provider.isBangla;

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavbar(
        currentIndex: _currentIndex,
        onTabSelected: _handleTabSelected,
        onSosTap: _handleSosTap,
        isBangla: isBangla,
      ),
    );
  }
}
