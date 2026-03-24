import 'package:flutter/material.dart';
import '../../core/theme/responsive.dart';
import 'caregiver_location_screen.dart';
import 'caregiver_booking_utils.dart';

class CaregiverServiceDetailsScreen extends StatelessWidget {
  final bool isBangla;
  const CaregiverServiceDetailsScreen({super.key, required this.isBangla});

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
          isBangla ? 'বয়স্ক ও রোগী সেবা' : 'Caregiver for Elderly, Bedridden & Post-Hospital Care',
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
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
                ? 'ঘরে প্রশিক্ষিত কেয়ারগিভারদের দ্বারা দৈনিক সহায়তা এবং মৌলিক স্বাস্থ্য পর্যবেক্ষণ প্রদান করা হয়।\n\nআদর্শ জন্য: বয়স্ক ব্যক্তি, সামান্য অসুস্থতা থেকে সুস্থ হওয়া রোগী, সীমিত গতিশীলতা সম্পন্ন ব্যক্তি এবং ঘরে মৌলিক যত্নের প্রয়োজন এমন নবজাতক।'
                : 'Daily assistance and basic health monitoring provided by trained caregivers.\n\nIdeal for: Elderly persons, patients recovering from minor illness, individuals with limited mobility, and newborns needing basic care at home.',
              services: [
                isBangla ? 'রক্তচাপ, রক্তশর্করা, তাপমাত্রা ও SpO₂ পরীক্ষা' : 'Blood Pressure, Blood Sugar, Temperature & SpO₂ Check',
                isBangla ? 'ব্যক্তিগত স্বাস্থ্যবিধি (গোসল, চুল আঁচড়ানো)' : 'Personal Hygiene (Bathing, Grooming)',
                isBangla ? 'গতিশীলতা ও হাঁটার সহায়তা' : 'Mobility & Walking Assistance',
                isBangla ? 'খাওয়ানোর সহায়তা ও ওষুধ স্মরণ করানো' : 'Feeding Support & Medication Reminder',
                isBangla ? 'নেবুলাইজেশন ও শ্বাস প্রশ্বাস সহায়তা' : 'Nebulization & Breathing Support',
                isBangla ? 'নবজাতকের মৌলিক যত্ন ও বুকের দুধ খাওয়ানোর সহায়তা' : 'Newborn Basic Care & Breastfeeding Support',
                isBangla ? 'হোম নমুনা সংগ্রহ (রক্ত / প্রস্রাব)' : 'Home Sample Collection (Blood / Urine)',
              ],
            ),
            const SizedBox(height: 24),

            // Standard Care Section
            _buildCareSection(
              context,
              title: isBangla ? 'স্ট্যান্ডার্ড কেয়ার' : 'Standard Care',
              description: isBangla 
                ? 'পুনরুদ্ধার সমর্থন এবং দীর্ঘস্থায়ী রোগ ব্যবস্থাপনার জন্য প্রশিক্ষিত নার্সদের দ্বারা নার্সিং যত্ন প্রদান করা হয়।\n\nআদর্শ জন্য: হাসপাতাল থেকে ছুটি পাওয়া রোগী, দীর্ঘস্থায়ী রোগ (ডায়াবেটিস, উচ্চ রক্তচাপ) সম্পন্ন ব্যক্তি, অস্ত্রোপচার পর রোগী এবং স্ট্রোক থেকে সুস্থ হওয়া রোগী।'
                : 'Nursing care provided by trained nurses for recovery support and chronic disease management.\n\nIdeal for: Patients discharged from hospital, individuals with chronic diseases (diabetes, hypertension), post-surgery patients, and stroke recovery patients.',
              services: [
                isBangla ? 'ইনজেকশন (IM / সাবকিউটেনিয়াস)' : 'Injection (IM / Subcutaneous)',
                isBangla ? 'ক্যাথেটারাইজেশন ও ক্যাথেটার যত্ন' : 'Catheterization & Catheter Care',
                isBangla ? 'NG টিউব ইনসারশন ও খাওয়ানো' : 'NG Tube Insertion & Feeding',
                isBangla ? 'উপদংশ প্যাচ ও সেলাই যত্ন' : 'Wound Dressing & Stitches Care',
                isBangla ? 'বিছানার ঘা যত্ন (স্টেজ I–II)' : 'Bedsore Care (Stage I–II)',
                isBangla ? 'ইনসুলিন প্রশাসন' : 'Insulin Administration',
                isBangla ? 'অস্ত্রোপচার ও প্রসবের পর যত্ন' : 'Post-Surgery & Postpartum Care',
                isBangla ? 'মৌলিক ফিজিওথেরাপি ও স্ট্রোক পুনর্বাসন সহায়তা' : 'Basic Physiotherapy & Stroke Rehabilitation Support',
              ],
            ),
            const SizedBox(height: 24),

            // Critical Care Section
            _buildCareSection(
              context,
              title: isBangla ? 'ক্রিটিক্যাল কেয়ার' : 'Critical Care',
              description: isBangla 
                ? 'গুরুতর বা উচ্চ ঝুঁকির চিকিৎসা অবস্থার জন্য দক্ষ নার্সদের দ্বারা ঘরে উন্নত ক্লিনিকাল যত্ন প্রদান করা হয়।\n\nআদর্শ জন্য: ICU স্টেপ-ডাউন রোগী, ভেন্টিলেটর বা অক্সিজেন নির্ভরশীল রোগী, গুরুতর স্ট্রোক রোগী এবং অবিরাম চিকিৎসা পর্যবেক্ষণের প্রয়োজন এমন ব্যক্তি।'
                : 'Advanced clinical care at home provided by skilled nurses for serious or high-risk medical conditions.\n\nIdeal for: ICU step-down patients, ventilator or oxygen-dependent patients, severe stroke patients, and individuals requiring continuous medical monitoring.',
              services: [
                isBangla ? 'IV ক্যানুলেশন ও IV ইনফিউশন' : 'IV Cannulation & IV Infusion',
                isBangla ? 'অক্সিজেন থেরাপি (সিলিন্ডার / কনসেন্ট্রেটর)' : 'Oxygen Therapy (Cylinder / Concentrator)',
                isBangla ? 'BiPAP / CPAP সমর্থন' : 'BiPAP / CPAP Support',
                isBangla ? 'ট্র্যাকিওস্টোমি যত্ন' : 'Tracheostomy Care',
                isBangla ? 'উন্নত বিছানার ঘা ব্যবস্থাপনা (স্টেজ III–IV)' : 'Advanced Bedsore Management (Stage III–IV)',
                isBangla ? 'অবিরাম রোগী পর্যবেক্ষণ' : 'Continuous Patient Monitoring',
                isBangla ? 'ICU স্টেপ-ডাউন হোম কেয়ার' : 'ICU Step-Down Home Care',
                isBangla ? 'প্যালিয়েটিভ ও উন্নত স্ট্রোক কেয়ার' : 'Palliative & Advanced Stroke Care',
              ],
            ),
            const SizedBox(height: 32),

            // Book Now Button
            Center(
              child: FilledButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => CaregiverLocationScreen(
                        isBangla: isBangla,
                        bookingData: BookingData(serviceName: 'Elderly Care'),
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
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
              fontSize: Responsive.scaleFontSize(context, 12),
              color: const Color(0xFF6B7280),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            isBangla ? 'সেবাসমূহ:' : 'Services include:',
            style: TextStyle(
              fontSize: Responsive.scaleFontSize(context, 12),
              fontWeight: FontWeight.bold,
              color: const Color(0xFF374151),
            ),
          ),
          const SizedBox(height: 8),
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
                          fontSize: Responsive.scaleFontSize(context, 11),
                          color: const Color(0xFF6B7280),
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
}
