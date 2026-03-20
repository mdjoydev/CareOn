import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SosScreen extends StatelessWidget {
  final bool isBangla;
  const SosScreen({super.key, this.isBangla = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 32),
              decoration: const BoxDecoration(
                color: Color(0xFFE11D48),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isBangla ? 'জরুরী সহায়তা' : 'Emergency\nAssistance',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    isBangla 
                        ? 'দ্রুত চিকিৎসা সেবা পেতে আমাদের সাথে যোগাযোগ করুন। CareOn আপনার সহায়তায় ২৪/৭ নিয়োজিত।'
                        : 'Quick access to medical emergency services. CareOn is available 24/7 for your help.',
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24),
                physics: const BouncingScrollPhysics(),
                children: [
                  _EmergencyCard(
                    title: isBangla ? 'অ্যাম্বুলেন্স কল করুন' : 'Call Ambulance',
                    subtitle: '+880 131 955 2222',
                    icon: Icons.local_shipping_rounded,
                    iconBgColor: const Color(0xFFE11D48),
                    cardBgColor: const Color(0xFFFFF1F2),
                    textColor: const Color(0xFFE11D48),
                    trailing: const Icon(Icons.call_rounded, color: Color(0xFFE11D48), size: 24),
                    onTap: () {},
                  ),
                  const SizedBox(height: 16),
                  _EmergencyCard(
                    title: isBangla ? 'জরুরী নার্স' : 'Emergency Nurse',
                    subtitle: isBangla ? 'দ্রুত প্রতিক্রিয়ার নার্স' : 'Fast response nurse',
                    icon: Icons.favorite_rounded,
                    iconBgColor: const Color(0xFFF59E0B),
                    cardBgColor: const Color(0xFFFFFBEB),
                    textColor: const Color(0xFFB45309),
                    trailing: const Icon(Icons.arrow_forward_rounded, color: Color(0xFFF59E0B), size: 24),
                    onTap: () {},
                  ),
                  const SizedBox(height: 16),
                  _EmergencyCard(
                    title: isBangla ? 'অন-কল ডাক্তার' : 'On-call Doctor',
                    subtitle: isBangla ? 'জরুরী পরামর্শ' : 'Emergency consultation',
                    icon: Icons.medical_services_rounded,
                    iconBgColor: const Color(0xFF3B82F6),
                    cardBgColor: const Color(0xFFEFF6FF),
                    textColor: const Color(0xFF1D4ED8),
                    trailing: const Icon(Icons.arrow_forward_rounded, color: Color(0xFF3B82F6), size: 24),
                    onTap: () {},
                  ),
                  
                  const SizedBox(height: 40),
                  Center(
                    child: Text(
                      isBangla ? 'আমাদের অফিস খুঁজে পাচ্ছেন না?' : 'Need help locating our office?',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: const Color(0xFF94A3B8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmergencyCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconBgColor;
  final Color cardBgColor;
  final Color textColor;
  final Widget trailing;
  final VoidCallback onTap;

  const _EmergencyCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBgColor,
    required this.cardBgColor,
    required this.textColor,
    required this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardBgColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: iconBgColor.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}
