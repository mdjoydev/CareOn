import 'package:flutter/material.dart';
import 'physiotherapy_location_screen.dart';
import 'physiotherapy_booking_utils.dart';

class PhysiotherapyServiceDetailsScreen extends StatelessWidget {
  final bool isBangla;
  const PhysiotherapyServiceDetailsScreen({super.key, required this.isBangla});

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
          isBangla ? 'ফিজিওথেরাপি সেবা' : 'Physiotherapy at Home',
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isBangla ? 'বেসিক কেয়ার, স্ট্যান্ডার্ড কেয়ার ও ক্রিটিক্যাল কেয়ার প্যাকেজ' : 'Basic Care, Standard Care & Critical Care Packages',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF059669)),
            ),
            const SizedBox(height: 24),

            _buildPackageInfo(
              context,
              title: isBangla ? 'বেসিক কেয়ার' : 'Basic Care',
              who: isBangla ? 'যাদের জন্য এই সেবা:' : 'Who should take service:',
              desc: isBangla 
                ? 'স্বল্পমেয়াদী ব্যবহারকারী বা মৃদু পুনরুদ্ধারের প্রয়োজনের জন্য আদর্শ।\nমৃদু ব্যথা, ভঙ্গি সমস্যা, পেশী শক্ত হওয়া এবং প্রাথমিক পর্যায়ের থেরাপি রোগী, নরম টিস্যুর আঘাত এবং সাব-অ্যাকিউট অবস্থার জন্য।'
                : 'Ideal for short-term users or mild recovery needs.\nRemove mild pain, posture issues, muscle stiffness and early-stage therapy patients, soft tissue injury and sub-acute condition.',
            ),
            const SizedBox(height: 20),

            _buildPackageInfo(
              context,
              title: isBangla ? 'স্ট্যান্ডার্ড কেয়ার' : 'Standard Care',
              who: isBangla ? 'যাদের জন্য এই সেবা:' : 'Who should take service:',
              desc: isBangla 
                ? 'এটি সবচেয়ে জনপ্রিয় প্ল্যান যা দুর্ঘটনা পরবর্তী বা অস্ত্রোপচার পরবর্তী পুনরুদ্ধারের জন্য উপযুক্ত।\nমাঝারি আঘাতের পুনরুদ্ধার, অস্ত্রোপচার পরবর্তী পুনর্বাসন, আর্থ্রাইটিস, বা স্নায়ু সংকোচন রোগী, ক্রীড়া আঘাত পুনর্বাসন এবং গর্ভাবস্থার আগে এবং প্রসবের পরের পুনর্বাসনের জন্য।'
                : 'It is most popular plan suitable for post-accident or post-surgery recovery.\nRemove moderate injury recovery, post-surgery rehab, arthritis, or nerve compression patients, sports injury rehab and before pregnancy & after delivery rehab.',
            ),
            const SizedBox(height: 20),

            _buildPackageInfo(
              context,
              title: isBangla ? 'ক্রিটিক্যাল কেয়ার' : 'Critical Care',
              who: isBangla ? 'যাদের জন্য এই সেবা:' : 'Who should take service:',
              desc: isBangla 
                ? 'দীর্ঘমেয়াদী/দীর্ঘস্থায়ী রোগীদের জন্য আদর্শ।\nস্ট্রোক, পক্ষাঘাত, দীর্ঘস্থায়ী স্নায়বিক বা জেরিয়াট্রিক রোগীদের প্রতিদিন নিবিড় থেরাপির প্রয়োজন।\nস্ট্রোক পুনর্বাসন প্রোগ্রাম, পেশী অ্যাট্রোফি এবং মায়োপ্যাথি।'
                : 'Ideal for long-term/chronic patients.\nStroke, paralysis, chronic neurological or geriatric patients need daily intensive therapy.\nStroke rehabilitation program, muscle atrophy & myopathy.',
            ),
            
            const SizedBox(height: 32),
            Text(
              isBangla ? 'উপলব্ধ প্যাকেজসমূহ' : 'Available Packages',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              isBangla 
                ? 'প্রয়োজনীয় সেবার সময়কাল এবং চিকিৎসা মনোযোগের স্তরের উপর ভিত্তি করে আমাদের দৈনিক বা মাসিক ফিজিওথেরাপি সেশন থেকে বেছে নিন।'
                : 'Select from our Daily or Monthly physiotherapy sessions based on required service duration and level of medical attention.',
              style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
            ),
            const SizedBox(height: 24),

            _buildSessionCard(
              context,
              title: isBangla ? 'দৈনিক সেশন' : 'Daily Session',
              items: [
                isBangla ? '৩০-৪০ মিনিট – বেসিক কেয়ার' : '30-40 Minutes – Basic Care',
                isBangla ? '৩০-৬০ মিনিট – স্ট্যান্ডার্ড কেয়ার' : '30-60 Minutes – Standard Care',
                isBangla ? '৩০-৯০ মিনিট – ক্রিটিক্যাল কেয়ার' : '30-90 Minutes – Critical Care',
              ],
            ),
            const SizedBox(height: 16),
            _buildSessionCard(
              context,
              title: isBangla ? 'মাসিক সেশন' : 'Monthly Session',
              items: [
                isBangla ? '৩০-৪০ মিনিট – বেসিক কেয়ার' : '30-40 Minutes – Basic Care',
                isBangla ? '৩০-৬০ মিনিট – স্ট্যান্ডার্ড কেয়ার' : '30-60 Minutes – Standard Care',
                isBangla ? '৩০-৯০ মিনিট – ক্রিটিক্যাল কেয়ার' : '30-90 Minutes – Critical Care',
              ],
            ),

            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFFEE2E2)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline, color: Color(0xFFDC2626), size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      isBangla 
                        ? 'গুরুত্বপূর্ণ: প্রথম দিনে রোগীর স্বাস্থ্য মূল্যায়নের পর, প্রয়োজনীয় সেশনের সংখ্যা নির্ধারণ করা হবে।'
                        : 'Important: After the patient’s health assessment on the first day, the required number of sessions will be determined.',
                      style: const TextStyle(fontSize: 13, color: Color(0xFF991B1B), fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            Center(
              child: FilledButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => PhysiotherapyLocationScreen(
                        isBangla: isBangla,
                        bookingData: PhysiotherapyBookingData(),
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

  Widget _buildPackageInfo(BuildContext context, {required String title, required String who, required String desc}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF111827))),
        const SizedBox(height: 8),
        Text(who, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF374151))),
        const SizedBox(height: 4),
        Text(desc, style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280), height: 1.5)),
      ],
    );
  }

  Widget _buildSessionCard(BuildContext context, {required String title, required List<String> items}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF111827))),
          const SizedBox(height: 12),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                const Icon(Icons.check_circle, color: Color(0xFF059669), size: 16),
                const SizedBox(width: 10),
                Text(item, style: const TextStyle(fontSize: 14, color: Color(0xFF4B5563))),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
