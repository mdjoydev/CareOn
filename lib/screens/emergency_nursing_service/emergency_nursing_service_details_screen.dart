import 'package:flutter/material.dart';
import '../../main.dart';
import 'emergency_nursing_booking_utils.dart';
import 'emergency_nursing_location_screen.dart';

class EmergencyNursingServiceDetailsScreen extends StatelessWidget {
  final bool isBangla;
  const EmergencyNursingServiceDetailsScreen({super.key, required this.isBangla});

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
          isBangla ? 'জরুরি নার্সিং সেবা' : 'Emergency Nursing Service',
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isBangla 
                  ? 'জরুরি নার্সিং কেয়ার জরুরি স্বাস্থ্য পরিস্থিতিতে দ্রুত চিকিৎসা সহায়তা প্রদান করে। প্রশিক্ষিত নার্সরা অবস্থা মূল্যায়ন করেন, তাৎক্ষণিক চিকিৎসা প্রদান করেন এবং রোগীদের স্থিতিশীল করার জন্য ভাইটাল সাইন মনিটর করেন, যখন এটি সবচেয়ে বেশি গুরুত্বপূর্ণ হয় তখন নিরাপদ এবং সময়মতো যত্ন নিশ্চিত করেন।' 
                  : 'Emergency Nursing Care offers rapid medical support during urgent health situations. Trained nurses assess conditions, provide immediate treatment, and monitor vital signs to stabilize patients quickly, ensuring safe and timely care when it matters most.',
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 32),

              // Service Description
              Text(
                isBangla ? 'নার্সিং প্রক্রিয়া এবং প্রয়োগের ক্ষেত্র' : 'Nursing Procedure & Applications',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              
              _buildServiceDescription(
                isBangla ? 'NG টিউব ফিডিং / কেয়ার' : 'NG Tube Feeding / Care',
                isBangla ? 'গলা ঘোড়ানোর অসুবিধা, স্ট্রোকের পর' : 'Swallowing difficulties, post-stroke',
              ),
              const SizedBox(height: 12),
              _buildServiceDescription(
                isBangla ? 'ক্ষত ড্রেসিং / সেলাই / আলসার কেয়ার' : 'Wound Dressing / Stitches / Ulcer Care',
                isBangla ? 'পোস্ট-সার্জারি ক্ষত, ডায়াবেটিক আলসার, ক্ষুদ্র বার্ন' : 'Post-surgery wounds, diabetic ulcers, minor burns',
              ),
              const SizedBox(height: 12),
              _buildServiceDescription(
                isBangla ? 'ইনজেকশন / IV পুশ / ওষুধ প্রশাসন' : 'Injection / IV Push / Medication Admin',
                isBangla ? 'অ্যান্টিবায়োটিক, ইনসুলিন, ফ্লুইড থেরাপি' : 'Antibiotics, insulin, fluid therapy',
              ),
              const SizedBox(height: 12),
              _buildServiceDescription(
                isBangla ? 'নেবুলাইজেশন থেরাপি' : 'Nebulization Therapy',
                isBangla ? 'হাঁপানি, COPD, শ্বাসযন্ত্রের সমস্যা' : 'Asthma, COPD, respiratory issues',
              ),
              const SizedBox(height: 12),
              _buildServiceDescription(
                isBangla ? 'ক্যাথেটার কেয়ার / সাকশনিং' : 'Catheter Care / Suctioning',
                isBangla ? 'প্রস্রাব ক্যাথেটার, শ্বাসযন্ত্রের সাকশন' : 'Urinary catheter, respiratory suction',
              ),
              const SizedBox(height: 12),
              _buildServiceDescription(
                isBangla ? 'ভাইটাল সাইন মনিটরিং' : 'Vital Signs Monitoring',
                isBangla ? 'BP, পালস, অক্সিজেন, রক্তশর্করা' : 'BP, pulse, oxygen, blood sugar',
              ),
              const SizedBox(height: 12),
              _buildServiceDescription(
                isBangla ? 'মেডিকেল ইকুইপমেন্ট সেটআপ / অপারেশন' : 'Medical Equipment Setup / Operation',
                isBangla ? 'অক্সিজেন সিলিন্ডার, সাকশন, নেবুলাইজার' : 'Oxygen cylinder, suction, nebulizer',
              ),
              const SizedBox(height: 40),

              // Book Now Button
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => EmergencyNursingLocationScreen(
                          isBangla: isBangla,
                          bookingData: EmergencyNursingBookingData(),
                        ),
                      ),
                    );
                  },
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    backgroundColor: CareOnApp.careOnGreen,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    isBangla ? 'বুক করুন' : 'Book Now',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceDescription(String procedure, String conditions) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.medical_services, color: CareOnApp.careOnGreen, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(procedure, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 4),
              Text(conditions, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }
}
