import 'package:flutter/material.dart';
import '../../core/theme/responsive.dart';
import 'baby_care_location_screen.dart';
import 'baby_care_booking_utils.dart';

class BabyCareServiceDetailsScreen extends StatelessWidget {
  final bool isBangla;
  const BabyCareServiceDetailsScreen({super.key, required this.isBangla});

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
          isBangla ? 'বেবি কেয়ার / ন্যানি সার্ভিস' : 'Baby Care / Nanny Service',
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Service Description
            Text(
              isBangla 
                ? 'দৈনিক/মাসিক ভিত্তিতে ৮/১২/২৪ ঘন্টার জন্য বেসিক, স্ট্যান্ডার্ড ও ক্রিটিক্যাল কেয়ার প্যাকেজের অধীনে'
                : '8/12/24 hours for daily/monthly basis under Basic, Standard & Critical Care packages',
              style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
            ),
            const SizedBox(height: 24),

            // Basic Care Section
            _buildCareSection(
              context,
              title: isBangla ? 'বেসিক কেয়ার' : 'Basic Care',
              description: isBangla 
                ? 'অপরিহার্য শিশু যত্ন এবং তত্ত্বাবধান।'
                : 'Essential childcare and supervision.',
              services: [
                isBangla ? 'খাওয়ানো এবং ডায়াপার পরিবর্তন' : 'Feeding and diaper changing',
                isBangla ? 'ঘুমের সময়সূচী বজায় রাখা' : 'Sleep schedule maintenance',
                isBangla ? 'মৌলিক পরিচ্ছন্নতার যত্ন' : 'Basic hygiene care',
                isBangla ? 'খেলার সময় তত্ত্বাবধান' : 'Playtime supervision',
              ],
            ),
            const SizedBox(height: 24),

            // Standard Care Section
            _buildCareSection(
              context,
              title: isBangla ? 'স্ট্যান্ডার্ড কেয়ার' : 'Standard Care',
              description: isBangla 
                ? 'বেসিক পরিষেবার পাশাপাশি ব্যাপক যত্ন:'
                : 'Comprehensive care including all Basic services plus:',
              services: [
                isBangla ? 'বয়স-উপযোগী কার্যক্রম' : 'Age-appropriate activities',
                isBangla ? 'প্রাথমিক শিক্ষা সহায়তা' : 'Early learning support',
                isBangla ? 'খাবার প্রস্তুত করা' : 'Meal preparation',
                isBangla ? 'শিশুর সাথে সম্পর্কিত হালকা গৃহস্থালির কাজ' : 'Light housekeeping related to baby',
              ],
            ),
            const SizedBox(height: 24),

            // Critical Care Section
            _buildCareSection(
              context,
              title: isBangla ? 'ক্রিটিক্যাল কেয়ার' : 'Critical Care',
              description: isBangla 
                ? 'নবজাতক এবং বিশেষ চাহিদাসম্পন্ন শিশুদের জন্য বিশেষ যত্ন:'
                : 'Specialized care for newborns and special needs:',
              services: [
                isBangla ? 'সমস্ত স্ট্যান্ডার্ড কেয়ার পরিষেবা' : 'All Standard Care services',
                isBangla ? 'নবজাতক যত্ন বিশেষজ্ঞ' : 'Newborn care specialist',
                isBangla ? 'বিকাশের মাইলফলক ট্র্যাকিং' : 'Development milestone tracking',
                isBangla ? '২৪/৭ পর্যবেক্ষণ এবং রিপোর্টিং' : '24/7 monitoring and reporting',
              ],
            ),
            const SizedBox(height: 32),

            // Available Packages Section
            Text(
              isBangla ? 'উপলব্ধ প্যাকেজসমূহ' : 'Available Packages',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              isBangla 
                ? 'বেসিক কেয়ার, স্ট্যান্ডার্ড কেয়ার এবং ক্রিটিক্যাল কেয়ারের অধীনে ৮, ১২ এবং ২৪-ঘন্টার কভারেজ সহ দৈনিক বা মাসিক প্যাকেজ থেকে বেছে নিন।'
                : 'Choose from Daily or Monthly packages with 8, 12 and 24-hours coverage under Basic Care, Standard Care and Critical Care.',
              style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
            ),
            const SizedBox(height: 16),
            _buildPackageInfo(isBangla ? 'দৈনিক প্যাকেজ' : 'Daily Package', isBangla),
            _buildPackageInfo(isBangla ? 'মাসিক প্যাকেজ' : 'Monthly Package', isBangla),
            
            const SizedBox(height: 32),

            // Book Now Button
            Center(
              child: FilledButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => BabyCareLocationScreen(
                        isBangla: isBangla,
                        bookingData: BabyCareBookingData(),
                      ),
                    ),
                  );
                },
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF059669),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  isBangla ? 'এখনই বুক করুন' : 'Book Now',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 24),
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: Responsive.scaleFontSize(context, 18),
              fontWeight: FontWeight.bold,
              color: const Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(
              fontSize: Responsive.scaleFontSize(context, 13),
              color: const Color(0xFF6B7280),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: services.map((service) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.only(top: 6, right: 8),
                      decoration: const BoxDecoration(
                        color: Color(0xFF059669),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        service,
                        style: TextStyle(
                          fontSize: Responsive.scaleFontSize(context, 12),
                          color: const Color(0xFF4B5563),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPackageInfo(String title, bool isBangla) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(isBangla ? '• ৮ ঘন্টা' : '• 8 Hours', style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                Text(isBangla ? '• ১২ ঘন্টা' : '• 12 Hours', style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                Text(isBangla ? '• ২৪ ঘন্টা' : '• 24 Hours', style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
