import 'package:flutter/material.dart';

import 'home/home_screen.dart';
import 'services/services_screen.dart';
import 'tips_screen.dart';
import 'profile_screen.dart';
import 'sos_screen.dart';
import '../widgets/bottom_navbar.dart';

class MainApp extends StatefulWidget {
  final bool isBangla;
  const MainApp({super.key, this.isBangla = false});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentIndex = 0;
  late List<Widget> _screens;
  late bool _isBangla;

  @override
  void initState() {
    super.initState();
    _isBangla = widget.isBangla;
    _initializeScreens();
  }

  void _initializeScreens() {
    _screens = [
      HomeScreen(
        isBangla: _isBangla,
        onSosTap: _handleSosTap,
        onViewAllServices: () {
          setState(() => _currentIndex = 1);
        },
        onViewAllCheckups: () {
          // Handle view all checkups
        },
      ),
      ServicesScreen(isBangla: _isBangla),
      const SizedBox(), // Placeholder for SOS (handled by floating button)
      HealthTipsScreen(isBangla: _isBangla),
      ProfileScreen(
        isBangla: _isBangla,
        onLanguageToggle: () {
          setState(() {
            _isBangla = !_isBangla;
          });
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
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavbar(
        currentIndex: _currentIndex,
        onTabSelected: _handleTabSelected,
        onSosTap: _handleSosTap,
        isBangla: _isBangla,
      ),
    );
  }
}