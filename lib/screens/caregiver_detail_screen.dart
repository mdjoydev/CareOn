import 'package:flutter/material.dart';
import '../core/theme/responsive.dart';
import '../main.dart';
import 'caregiver_booking_utils.dart';
import 'caregiver_location_screen.dart';

class CaregiverDetailScreen extends StatelessWidget {
  final bool isBangla;
  const CaregiverDetailScreen({super.key, this.isBangla = false});

  @override
  Widget build(BuildContext context) {
    final bookingData = BookingData();

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          isBangla ? 'সেবার বিস্তারিত' : 'Service Details',
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCFCE7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      isBangla ? 'বিশেষ স্বাস্থ্যসেবা' : 'Special Healthcare Services',
                      style: const TextStyle(
                        color: Color(0xFF166534),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    isBangla 
                        ? 'বয়স্ক, শয্যাশায়ী এবং হাসপাতাল পরবর্তী যত্নের জন্য পরিচর্যাকারী' 
                        : 'Caregiver for Elderly, Bedridden & Post-Hospital Care',
                    style: TextStyle(
                      fontSize: Responsive.scaleFontSize(context, 24),
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF111827),
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isBangla 
                        ? 'বয়স্ক, শয্যাশায়ী এবং হাসপাতাল পরবর্তী যত্নের জন্য পরিচর্যাকারী' 
                        : 'Caregiver for Elderly, Bedridden & Post-Hospital Care',
                    style: const TextStyle(color: Color(0xFF6B7280), fontSize: 14),
                  ),
                  const SizedBox(height: 32),
                  
                  // Care Type Cards (Horizontal)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildCareTypeCard(
                          isBangla ? 'বেসিক কেয়ার' : 'Basic Care',
                          isBangla 
                              ? 'বয়স্ক, শয্যাশায়ী এবং হাসপাতাল পরবর্তী যত্নের জন্য পরিচর্যাকারী' 
                              : 'Caregiver for Elderly, Bedridden & Post-Hospital Care',
                        ),
                        const SizedBox(width: 16),
                        _buildCareTypeCard(
                          isBangla ? 'স্ট্যান্ডার্ড কেয়ার' : 'Standard Care',
                          isBangla 
                              ? 'বয়স্ক, শয্যাশায়ী এবং হাসপাতাল পরবর্তী যত্নের জন্য পরিচর্যাকারী' 
                              : 'Caregiver for Elderly, Bedridden & Post-Hospital Care',
                        ),
                        const SizedBox(width: 16),
                        _buildCareTypeCard(
                          isBangla ? 'ক্রিটিক্যাল কেয়ার' : 'Critical Care',
                          isBangla 
                              ? 'বয়স্ক, শয্যাশায়ী এবং হাসপাতাল পরবর্তী যত্নের জন্য পরিচর্যাকারী' 
                              : 'Caregiver for Elderly, Bedridden & Post-Hospital Care',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Available Packages
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F7FA),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isBangla ? 'উপলব্ধ প্যাকেজ' : 'Available Packages',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          isBangla 
                              ? 'বেসিক কেয়ার, স্ট্যান্ডার্ড কেয়ার এবং ক্রিটিক্যাল কেয়ারের অধীনে ৮, ১২ এবং ২৪-ঘণ্টা কভারেজ সহ দৈনিক বা মাসিক প্যাকেজ থেকে বেছে নিন।' 
                              : 'Choose from Daily or Monthly packages with 8, 12 and 24-hours coverage under Basic Care, Standard Care and Critical Care.',
                          style: const TextStyle(color: Color(0xFF6B7280), fontSize: 13, height: 1.4),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildPackageList(isBangla ? 'দৈনিক প্যাকেজ' : 'Daily Package')),
                            Expanded(child: _buildPackageList(isBangla ? 'মাসিক প্যাকেজ' : 'Monthly Package')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: FilledButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => CaregiverLocationScreen(
                        isBangla: isBangla,
                        bookingData: bookingData,
                      ),
                    ),
                  );
                },
                style: FilledButton.styleFrom(
                  minimumSize: const Size(160, 48),
                  backgroundColor: CareOnApp.careOnGreen,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(isBangla ? 'এখনই বুক করুন' : 'Book Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCareTypeCard(String title, String desc) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
          ),
          const SizedBox(height: 12),
          Text(
            desc,
            style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280), height: 1.4),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildPackageList(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 12),
        _buildBulletPoint('8 Hours'),
        _buildBulletPoint('12 Hours'),
        _buildBulletPoint('24 Hours'),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 4,
            decoration: const BoxDecoration(color: Color(0xFF6B7280), shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontSize: 13, color: Color(0xFF374151))),
        ],
      ),
    );
  }
}
