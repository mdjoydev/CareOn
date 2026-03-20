import 'package:flutter/material.dart';

import 'core/theme/app_colors.dart';
import 'screens/home/home_screen.dart';
import 'screens/services/services_screen.dart';
import 'screens/services/basic_health_checkup_screen.dart';
import 'screens/tips_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/sos_screen.dart';
import 'widgets/bottom_navbar.dart';

class CareOnShell extends StatefulWidget {
  final bool initialIsBangla;
  const CareOnShell({super.key, this.initialIsBangla = false});

  @override
  State<CareOnShell> createState() => _CareOnShellState();
}

class _CareOnShellState extends State<CareOnShell> {
  int _pageIndex = 0;
  late bool _isBangla;

  @override
  void initState() {
    super.initState();
    _isBangla = widget.initialIsBangla;
  }

  void _toggleLanguage() {
    setState(() {
      _isBangla = !_isBangla;
    });
  }

  List<Widget> get _pages => [
        HomeScreen(
          onSosTap: () => setState(() => _pageIndex = 2),
          onViewAllServices: () => setState(() => _pageIndex = 1),
          onViewAllCheckups: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BasicHealthCheckupScreen(isBangla: _isBangla),
              ),
            );
          },
          onLanguageToggle: _toggleLanguage,
          isBangla: _isBangla,
        ),
        ServicesScreen(isBangla: _isBangla),
        SosScreen(isBangla: _isBangla),
        HealthTipsScreen(isBangla: _isBangla),
        ProfileScreen(
          isBangla: _isBangla,
          onLanguageToggle: _toggleLanguage,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _pageIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavbar(
        currentIndex: _pageIndex,
        onTabSelected: (index) => setState(() => _pageIndex = index),
        onSosTap: () => setState(() => _pageIndex = 2),
        isBangla: _isBangla,
      ),
    );
  }
}
