import 'package:flutter/material.dart';
import 'patients_attendant_location_screen.dart';
import 'patients_attendant_booking_utils.dart';

class PatientsAttendantServiceDetailsScreen extends StatelessWidget {
  final bool isBangla;
  const PatientsAttendantServiceDetailsScreen({super.key, required this.isBangla});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          isBangla ? "পেশেন্ট অ্যাটেনডেন্ট সার্ভিস" : "Patient's Attendant Service",
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isBangla 
                ? 'দৈনিক/মাসিক ভিত্তিতে ৮/১২/২৪ ঘন্টার জন্য বেসিক, স্ট্যান্ডার্ড ও ক্রিটিক্যাল কেয়ার প্যাকেজের অধীনে'
                : '8/12/24 hours for daily/monthly basis under Basic, Standard & Critical Care packages',
              style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
            ),
            const SizedBox(height: 24),

            _buildCareSection(
              context,
              title: isBangla ? 'বেসিক কেয়ার' : 'Basic Care',
              description: isBangla 
                ? 'প্রয়োজনীয় রোগীর সহায়তা এবং সমর্থন।'
                : 'Essential patient assistance and support',
              services: [
                isBangla ? 'রোগীর সঙ্গ' : 'Patient companionship',
                isBangla ? 'খাওয়ানোর সহায়তা' : 'Assistance with meals',
                isBangla ? 'মৌলিক পরিচ্ছন্নতা সহায়তা' : 'Basic hygiene support',
                isBangla ? 'গতিশীলতা সহায়তা' : 'Mobility assistance',
              ],
            ),
            const SizedBox(height: 24),

            _buildCareSection(
              context,
              title: isBangla ? 'স্ট্যান্ডার্ড কেয়ার' : 'Standard Care',
              description: isBangla 
                ? 'বেসিক সার্ভিসের সাথে ব্যাপক সহায়তা:'
                : 'Comprehensive assistance including all Basic services plus:',
              services: [
                isBangla ? 'ওষুধের অনুস্মারক' : 'Medication reminders',
                isBangla ? 'চিকিৎসা কর্মীদের সাথে সমন্বয়' : 'Coordination with medical staff',
                isBangla ? 'রেকর্ড রাখা এবং ডকুমেন্টেশন' : 'Record keeping and documentation',
                isBangla ? 'পরিবারের সাথে যোগাযোগের আপডেট' : 'Family communication updates',
              ],
            ),
            const SizedBox(height: 24),

            _buildCareSection(
              context,
              title: isBangla ? 'ক্রিটিক্যাল কেয়ার' : 'Critical Care',
              description: isBangla 
                ? 'ক্রিটিক্যাল রোগীদের জন্য নিবিড় সমর্থন:'
                : 'Intensive support for critical patients:',
              services: [
                isBangla ? 'সকল স্ট্যান্ডার্ড কেয়ার সার্ভিস' : 'All Standard Care services',
                isBangla ? '২৪/৭ রোগী পর্যবেক্ষণ' : '24/7 patient monitoring',
                isBangla ? 'জরুরী প্রতিক্রিয়া সমন্বয়' : 'Emergency response coordination',
                isBangla ? 'বিস্তারিত অগ্রগতি প্রতিবেদন' : 'Detailed progress reporting',
              ],
            ),
            const SizedBox(height: 32),

            Text(
              isBangla ? 'উপলব্ধ প্যাকেজসমূহ' : 'Available Packages',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              isBangla 
                ? 'বেসিক কেয়ার, স্ট্যান্ডার্ড কেয়ার এবং ক্রিটিক্যাল কেয়ারের অধীনে ৮, ১২ এবং ২৪ ঘন্টার কভারেজ সহ দৈনিক বা মাসিক প্যাকেজ থেকে বেছে নিন।'
                : 'Choose from Daily or Monthly packages with 8, 12 and 24-hours coverage under Basic Care, Standard Care and Critical Care.',
              style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
            ),
            const SizedBox(height: 16),
            
            _buildPackageSummary(
              title: isBangla ? 'দৈনিক প্যাকেজ' : 'Daily Package',
              items: ['8 Hours', '12 Hours', '24 Hours'],
            ),
            const SizedBox(height: 12),
            _buildPackageSummary(
              title: isBangla ? 'মাসিক প্যাকেজ' : 'Monthly Package',
              items: ['8 Hours', '12 Hours', '24 Hours'],
            ),
            
            const SizedBox(height: 40),

            Center(
              child: FilledButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => PatientsAttendantLocationScreen(
                        isBangla: isBangla,
                        bookingData: PatientsAttendantBookingData(),
                      ),
                    ),
                  );
                },
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF059669),
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  isBangla ? 'এখনই বুক করুন' : 'Book Now',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildCareSection(BuildContext context, {required String title, required String description, required List<String> services}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280), height: 1.5),
          ),
          const SizedBox(height: 16),
          ...services.map((service) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.check_circle, color: Color(0xFF059669), size: 16),
                const SizedBox(width: 10),
                Expanded(child: Text(service, style: const TextStyle(fontSize: 13, color: Color(0xFF4B5563)))),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildPackageSummary({required String title, required List<String> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        const SizedBox(height: 8),
        Row(
          children: items.map((item) => Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(item, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
          )).toList(),
        ),
      ],
    );
  }
}
