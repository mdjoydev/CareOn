import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SupportScreen extends StatelessWidget {
  final bool isBangla;

  const SupportScreen({super.key, this.isBangla = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: Text(
          isBangla ? 'সাপোর্ট ও সহায়তা' : 'Support & Help',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF111827),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildContactCard(
              icon: Icons.phone_android_rounded,
              title: isBangla ? 'মোবাইল' : 'Mobile',
              subtitle: '+880 131 955 2222',
              description: isBangla ? '২৪/৭ সাপোর্ট উপলব্ধ' : '24/7 Support Available',
              color: const Color(0xFF3B82F6),
            ),
            const SizedBox(height: 16),
            _buildContactCard(
              icon: Icons.chat_bubble_outline_rounded,
              title: isBangla ? 'হোয়াটসঅ্যাপ' : 'WhatsApp',
              subtitle: '+880 131 955 2222',
              description: isBangla ? 'দ্রুত প্রতিক্রিয়া' : 'Quick responses',
              color: const Color(0xFF10B981),
            ),
            const SizedBox(height: 16),
            _buildContactCard(
              icon: Icons.email_outlined,
              title: isBangla ? 'ই-মেইল' : 'Email',
              subtitle: 'info@careon.me',
              description: isBangla ? '২৪ ঘণ্টার মধ্যে প্রতিক্রিয়া' : 'Response within 24 hours',
              color: const Color(0xFFEC4899),
            ),
            const SizedBox(height: 16),
            _buildContactCard(
              icon: Icons.location_on_outlined,
              title: isBangla ? 'অফিস ঠিকানা' : 'Office Address',
              subtitle: isBangla
                  ? 'হাউস ০৬, রোড ০২, ব্লক এল, বনানী, ঢাকা ১২১৩, বাংলাদেশ'
                  : 'House 06, Road 02, Block L, Banani, Dhaka 1213, Bangladesh',
              description: '',
              color: const Color(0xFF8B5CF6),
            ),
            const SizedBox(height: 16),
            _buildContactCard(
              icon: Icons.access_time_rounded,
              title: isBangla ? 'সেবা সময়' : 'Service Hours',
              subtitle: isBangla ? 'জরুরী অবস্থার জন্য ২৪/৭' : '24/7 for emergencies',
              description: isBangla ? 'অফিস: সকাল ৯টা - রাত ৮টা' : 'Office 9 AM - 8 PM',
              color: const Color(0xFFF59E0B),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                if (description.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
