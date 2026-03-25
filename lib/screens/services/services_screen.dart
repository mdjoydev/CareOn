import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/assets.dart';
import '../booking_screen.dart';
import '../caregiver_for_elderly/caregiver_service_details_screen.dart';
import '../patients_attendant_service/patients_attendant_service_details_screen.dart';
import '../ambulance_support/ambulance_booking_screen.dart';

class ServicesScreen extends StatelessWidget {
  final bool isBangla;
  const ServicesScreen({super.key, this.isBangla = false});

  @override
  Widget build(BuildContext context) {
    void openBooking(String service) {
      if (service == 'Elderly Care' || service == 'বয়স্ক সেবা') {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => CaregiverServiceDetailsScreen(isBangla: isBangla),
          ),
        );
      } else if (service == 'Patient Attendant' || service == 'রোগীর পরিচারক') {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PatientsAttendantServiceDetailsScreen(isBangla: isBangla),
          ),
        );
      } else if (service == 'Ambulance' || service == 'অ্যাম্বুলেন্স') {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AmbulanceBookingScreen(isBangla: isBangla),
          ),
        );
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => BookingScreen(initialService: service)),
        );
      }
    }

    return Material(
      color: const Color(0xFFF9FAFB),
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isBangla ? 'আমাদের সেবাসমূহ' : 'Our Services',
                      style: GoogleFonts.inter(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isBangla ? 'আপনার দোরগোড়ায় পেশাদার যত্ন' : 'Professional care at your doorstep',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Section 1: Special Healthcare
              _buildSectionHeader(isBangla ? 'বিশেষ স্বাস্থ্যসেবা' : 'Special Healthcare'),
              _buildSpecialServiceGrid(openBooking),

              const SizedBox(height: 32),

              // Section 2: Medical & Support
              _buildSectionHeader(isBangla ? 'মেডিকেল ও সহায়তা' : 'Medical & Support'),
              _buildSupportGrid(openBooking),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: const Color(0xFF111827),
        ),
      ),
    );
  }

  Widget _buildSpecialServiceGrid(Function(String) onTap) {
    final List<Map<String, dynamic>> specialServices = [
      {
        'label': isBangla ? 'বয়স্ক সেবা' : 'Elderly Care',
        'desc': isBangla ? 'বয়স্কদের জন্য পরিচর্যাকারী' : 'Caregiver for Elderly',
        'image': CareOnAssets.caregiverPng,
        'isPopular': true,
      },
      {
        'label': isBangla ? 'নার্সিং সেবা' : 'Nursing Care',
        'desc': isBangla ? 'দৈনিক/মাসিক ভিত্তিতে' : 'Daily/Monthly basis',
        'image': CareOnAssets.emergencyNursingPng,
        'isPopular': false,
      },
      {
        'label': isBangla ? 'ফিজিওথেরাপি' : 'Physiotherapy',
        'desc': isBangla ? 'পেশাদার থেরাপি' : 'Professional therapy',
        'image': CareOnAssets.physiotherapyPng,
        'isPopular': true,
      },
      {
        'label': isBangla ? 'শিশু সেবা' : 'Baby Care',
        'desc': isBangla ? 'ন্যানি সার্ভিস' : 'Nanny Service',
        'image': CareOnAssets.babyCarePng,
        'isPopular': false,
      },
      {
        'label': isBangla ? 'রোগীর পরিচারক' : 'Patient Attendant',
        'desc': isBangla ? 'ব্যক্তিগত পরিচারক' : 'Personal attendant',
        'image': CareOnAssets.patientAttendantPng,
        'isPopular': false,
      },
    ];

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        mainAxisExtent: 190,
      ),
      itemCount: specialServices.length,
      itemBuilder: (context, index) {
        final service = specialServices[index];
        final isPopular = service['isPopular'] ?? false;

        return GestureDetector(
          onTap: () => onTap(service['label']),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                if (isPopular)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFBBF24),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(24),
                          bottomLeft: Radius.circular(12),
                        ),
                      ),
                      child: Text(
                        'POPULAR',
                        style: GoogleFonts.inter(
                          fontSize: 8,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            service['image'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        service['label'],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        service['desc'],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: const Color(0xFF9CA3AF),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSupportGrid(Function(String) onTap) {
    final List<Map<String, dynamic>> supportServices = [
      {
        'label': isBangla ? 'মেডিকেল টেস্ট' : 'Medical Test',
        'image': CareOnAssets.medicalTestPng,
      },
      {
        'label': isBangla ? 'ডাক্তারের ভিজিট' : 'Doctor Visit',
        'image': CareOnAssets.doctorVisitPng,
      },
      {
        'label': isBangla ? 'অ্যাম্বুলেন্স' : 'Ambulance',
        'image': CareOnAssets.ambulancePng,
        'isEmergency': true,
      },
      {
        'label': isBangla ? 'জরুরি নার্সিং' : 'Emergency Nursing',
        'image': CareOnAssets.emergencyNursingPng,
        'isEmergency': true,
      },
    ];

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        mainAxisExtent: 180,
      ),
      itemCount: supportServices.length,
      itemBuilder: (context, index) {
        final item = supportServices[index];
        final isEmergency = item['isEmergency'] ?? false;

        return GestureDetector(
          onTap: () => onTap(item['label']),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      item['image'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  item['label'],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1F2937),
                  ),
                ),
                if (isEmergency) ...[
                  const SizedBox(height: 4),
                  const Text(
                    '24/7',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFEF4444),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
