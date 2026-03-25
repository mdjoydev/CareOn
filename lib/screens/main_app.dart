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

  @override
  void initState() {
    super.initState();
    _initializeScreens();
  }

  void _initializeScreens() {
    _screens = [
      HomeScreen(
        isBangla: widget.isBangla,
        onSosTap: _handleSosTap,
        onViewAllServices: () {
          setState(() => _currentIndex = 1);
        },
        onViewAllCheckups: () {
          // Handle view all checkups
        },
      ),
      ServicesScreen(isBangla: widget.isBangla),
      const SizedBox(), // Placeholder for SOS (handled by floating button)
      HealthTipsScreen(isBangla: widget.isBangla),
      ProfileScreen(isBangla: widget.isBangla),
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
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const SosScreen()),
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
        isBangla: widget.isBangla,
      ),
    );
  }
}