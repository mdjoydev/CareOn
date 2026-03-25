import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/assets.dart';
import '../core/theme/responsive.dart';

class HealthCheckupPackagesScreen extends StatelessWidget {
  final bool isBangla;
  const HealthCheckupPackagesScreen({super.key, this.isBangla = false});

  @override
  Widget build(BuildContext context) {
    final packages = [
      {
        'image': CareOnAssets.physicalWellnessPng,
        'title': isBangla ? 'প্রাথমিক স্বাস্থ্য পরীক্ষা' : 'Basic health\ncheckup'
      },
      {
        'image': CareOnAssets.womenHealthPng,
        'title': isBangla ? 'নারী স্বাস্থ্য পরীক্ষা' : 'Women health\ncheckup'
      },
      {
        'image': CareOnAssets.migrainePng,
        'title': isBangla ? 'মাইগ্রেন ও পেশীর টান' : 'Migraine & Muscle\nTension'
      },
      {
        'image': CareOnAssets.psychologicalDistressPng,
        'title': isBangla ? 'মানসিক চাপ ও বিষণ্নতা' : 'Psychological\nDistress'
      },
      {
        'image': CareOnAssets.allergyPng,
        'title': isBangla ? 'পরিবেশগত অ্যালার্জি' : 'Environmental\nAllergy'
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF111827)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          isBangla ? 'স্বাস্থ্য পরীক্ষা প্যাকেজ' : 'Health Checkup Packages',
          style: GoogleFonts.inter(
            color: const Color(0xFF111827),
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.scalePadding(context, 24),
          vertical: 24,
        ),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 0.85,
          ),
          itemCount: packages.length,
          itemBuilder: (context, index) {
            final package = packages[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 18,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  Expanded(
                    child: Image.asset(
                      package['image'] as String,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    child: Text(
                      package['title'] as String,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: Responsive.scaleFontSize(context, 12),
                        color: const Color(0xFF111827),
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}