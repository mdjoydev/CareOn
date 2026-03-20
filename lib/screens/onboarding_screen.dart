import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _currentPage = 0;
  bool _isBangla = false;

  List<_OnboardingPageConfig> get _pages => [
    _OnboardingPageConfig(
      icon: Icons.person_outline_rounded,
      title: _isBangla ? 'পেশাদার স্বাস্থ্যসেবা ঘরে বসেই' : 'Professional Healthcare at Home',
      description: _isBangla 
          ? 'আপনার পরিবারের জন্য বিশ্বস্ত কেয়ারগিভার এবং ডাক্তার বুক করুন।' 
          : 'Book trusted caregivers and doctors for your family.',
    ),
    _OnboardingPageConfig(
      icon: Icons.verified_user_outlined,
      title: _isBangla ? 'ভেরিফাইড মেডিকেল পেশাদার' : 'Verified Medical Professionals',
      description: _isBangla 
          ? 'আপনার যত্নের জন্য প্রত্যয়িত নার্স, ডাক্তার এবং কেয়ারগিভার।' 
          : 'Certified nurses, doctors and caregivers for your care.',
    ),
    _OnboardingPageConfig(
      icon: Icons.event_note_outlined,
      title: _isBangla ? 'সহজ সার্ভিস বুকিং' : 'Easy Service Booking',
      description: _isBangla 
          ? 'ঘরে বসেই স্বাস্থ্যসেবা বুক করুন, ট্র্যাক করুন এবং গ্রহণ করুন।' 
          : 'Book, track and receive healthcare services at home.',
    ),
  ];

  void _goNext() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => LoginScreen(initialIsBangla: _isBangla)),
      );
    }
  }

  void _toggleLanguage() {
    setState(() {
      _isBangla = !_isBangla;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CareOnApp.appBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            children: [
              // Language Switcher
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: _toggleLanguage,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0FDF4),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFDCFCE7)),
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: 'EN',
                            style: TextStyle(color: !_isBangla ? const Color(0xFF15803D) : Colors.grey),
                          ),
                          const TextSpan(
                            text: ' / ',
                            style: TextStyle(color: Colors.grey),
                          ),
                          TextSpan(
                            text: 'বাং',
                            style: TextStyle(color: _isBangla ? const Color(0xFF15803D) : Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _pages.length,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemBuilder: (context, index) {
                    final page = _pages[index];
                    return _OnboardingPage(config: page);
                  },
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) {
                    final isActive = index == _currentPage;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 6,
                      width: isActive ? 24 : 8,
                      decoration: BoxDecoration(
                        color: isActive
                            ? CareOnApp.careOnGreen
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _goNext,
                  child: Text(_currentPage == _pages.length - 1 
                      ? (_isBangla ? 'শুরু করুন' : 'Get Started') 
                      : (_isBangla ? 'পরবর্তী' : 'Next')),
                ),
              ),
              const SizedBox(height: 8),
              if (_currentPage < _pages.length - 1)
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => LoginScreen(initialIsBangla: _isBangla)),
                    );
                  },
                  child: Text(_isBangla ? 'এড়িয়ে যান' : 'Skip'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingPageConfig {
  const _OnboardingPageConfig({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({required this.config});

  final _OnboardingPageConfig config;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 220,
          height: 160,
          decoration: BoxDecoration(
            color: CareOnApp.careOnGreen.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(80),
          ),
          child: Icon(
            config.icon,
            size: 80,
            color: CareOnApp.careOnGreen,
          ),
        ),
        const SizedBox(height: 40),
        Text(
          config.title,
          textAlign: TextAlign.center,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            config.description,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade700,
            ),
          ),
        ),
      ],
    );
  }
}
