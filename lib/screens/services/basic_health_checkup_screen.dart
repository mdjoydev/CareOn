import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/assets.dart';

class BasicHealthCheckupScreen extends StatelessWidget {
  final bool isBangla;
  const BasicHealthCheckupScreen({super.key, this.isBangla = false});

  @override
  Widget build(BuildContext context) {
    final _ = Theme.of(context).textTheme;
    
    final cards = [
      {
        'image': CareOnAssets.physicalWellnessPng,
        'title': isBangla ? 'প্রাথমিক স্বাস্থ্য পরীক্ষা' : 'Basic health checkup',
        'subtitle': isBangla ? 'ভাইটালিটি চেক' : 'Vitality & health check',
      },
      {
        'image': CareOnAssets.womenHealthPng,
        'title': isBangla ? 'নারী স্বাস্থ্য পরীক্ষা' : 'Women health checkup',
        'subtitle': isBangla ? 'বিশেষজ্ঞ চেকআপ' : 'Specialized health check',
      },
      {
        'image': CareOnAssets.migrainePng,
        'title': isBangla ? 'মাইগ্রেন ও টেনশন' : 'Migraine & Tension',
        'subtitle': isBangla ? 'পেশীর ব্যথা উপশম' : 'Muscle tension relief',
      },
      {
        'image': CareOnAssets.psychologicalDistressPng,
        'title': isBangla ? 'মানসিক স্বাস্থ্য' : 'Mental Wellness',
        'subtitle': isBangla ? 'কাউন্সেলিং সাপোর্ট' : 'Support & counseling',
      },
      {
        'image': CareOnAssets.allergyPng,
        'title': isBangla ? 'অ্যালার্জি সিনড্রোম' : 'Allergy Syndrome',
        'subtitle': isBangla ? 'পরিবেশগত সুরক্ষা' : 'Environmental protection',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF111827), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isBangla ? 'স্বাস্থ্য পরীক্ষা প্যাকেজ' : 'Health Checkup Packages',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w800,
            color: const Color(0xFF111827),
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(24),
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 36,
          mainAxisExtent: 160, // Reduced from 190 to make cards more compact
        ),
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final card = cards[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 80, // Slightly reduced to fit better in smaller cards
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.asset(
                        card['image'] as String,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    card['title'] as String,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 13, // Slightly smaller font for more compact look
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    card['subtitle'] as String,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
