import 'package:flutter/material.dart';
import 'dart:math';
import '../../core/theme/responsive.dart';
import '../../main.dart';
import '../support_screen.dart';
import 'doctor_visit_booking_utils.dart';

class DoctorVisitSuccessScreen extends StatelessWidget {
  final bool isBangla;
  final DoctorVisitBookingData bookingData;

  const DoctorVisitSuccessScreen({
    super.key,
    required this.isBangla,
    required this.bookingData,
  });

  String _generateBookingId() {
    final random = Random();
    final id = random.nextInt(900000) + 100000;
    return '#DOC$id';
  }

  @override
  Widget build(BuildContext context) {
    final bookingId = _generateBookingId();

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // Success Icon
              Container(
                height: 80,
                width: 80,
                decoration: const BoxDecoration(
                  color: Color(0xFFDCFCE7),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle_rounded, color: CareOnApp.careOnGreen, size: 50),
              ),
              const SizedBox(height: 24),
              Text(
                isBangla ? 'বুকিং নিশ্চিত হয়েছে!' : 'Booking Confirmed!',
                style: TextStyle(
                  fontSize: Responsive.scaleFontSize(context, 24),
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                isBangla ? 'ডাক্তারের ভিজিটের জন্য ধন্যবাদ' : 'Thank You for Doctor Visit Booking',
                style: TextStyle(
                  fontSize: Responsive.scaleFontSize(context, 18),
                  fontWeight: FontWeight.w600,
                  color: CareOnApp.careOnGreen,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                isBangla 
                  ? 'আমাদের দল বর্তমানে আপনার অনুরোধের জন্য সেরা উপলব্ধ ডাক্তার নিয়োগ করছে। আপনি ১৫-৩০ মিনিটের মধ্যে একটি কল পাবেন।' 
                  : 'Our team is currently assigning the best available doctor for your request. You will receive a call within 15–30 minutes.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Responsive.scaleFontSize(context, 14),
                  color: const Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),

              // Booking Details Section
              _buildSectionCard(
                title: isBangla ? 'বুকিং বিবরণ' : 'Booking Details',
                children: [
                  _buildDetailRow(isBangla ? 'সেবা:' : 'Service:', bookingData.serviceName),
                  _buildDetailRow(isBangla ? 'বিশেষায়িত:' : 'Specialization:', bookingData.specialization ?? 'N/A'),
                  _buildDetailRow(isBangla ? 'অ্যাপয়েন্টমেন্ট তারিখ:' : 'Appointment Date:', bookingData.appointmentDate != null 
                    ? '${bookingData.appointmentDate!.day}/${bookingData.appointmentDate!.month}/${bookingData.appointmentDate!.year}' 
                    : 'N/A'),
                  _buildDetailRow(isBangla ? 'অ্যাপয়েন্টমেন্ট সময়:' : 'Appointment Time:', bookingData.appointmentTime != null 
                    ? '${bookingData.appointmentTime!.hour}:${bookingData.appointmentTime!.minute.toString().padLeft(2, '0')}' 
                    : 'N/A'),
                  _buildDetailRow(isBangla ? 'বুকিং আইডি:' : 'Booking ID:', bookingId),
                  _buildDetailRow(isBangla ? 'স্ট্যাটাস:' : 'Status:', isBangla ? 'গৃহীত' : 'Received', valueColor: CareOnApp.careOnGreen),
                ],
              ),
              const SizedBox(height: 16),

              // What Happens Next Section
              _buildSectionCard(
                title: isBangla ? 'এরপর কি হবে?' : 'What Happens Next?',
                children: [
                  _buildStepItem(isBangla 
                    ? 'আপনি ১৫-৩০ মিনিটের মধ্যে আমাদের প্রোভাইডারের কাছ থেকে একটি নিশ্চিতকরণ কল পাবেন' 
                    : 'You will receive a confirmation call from our provider within 15–30 minutes'),
                  _buildStepItem(isBangla 
                    ? 'ডাক্তার ভিজিটের সময় এবং স্থানের বিবরণ নিশ্চিত করবেন' 
                    : 'The doctor will confirm the visit time and location details'),
                  _buildStepItem(isBangla 
                    ? 'ভিজিটের পর পেমেন্ট সংগ্রহ করা হবে' 
                    : 'Payment will be collected after the visit'),
                  _buildStepItem(isBangla 
                    ? 'ভিজিট শেষ হওয়ার পর, আপনার অভিজ্ঞতা রেটিং করুন' 
                    : 'After the visit completion, please rate your experience'),
                ],
              ),
              const SizedBox(height: 16),

              // Important Notes Section
              _buildSectionCard(
                title: isBangla ? 'গুরুত্বপূর্ণ নোট:' : 'Important Notes:',
                children: [
                  _buildNoteItem(isBangla 
                    ? 'ডাক্তার পরিষেবা প্রদানকারীরা CareOn-এর নিজস্ব কর্মচারী নয়।' 
                    : 'Doctor service providers are not CareOn’s own employee.'),
                  _buildNoteItem(isBangla 
                    ? 'CareOn একটি ডিজিটাল প্ল্যাটফর্ম যা ডাক্তারের ভিজিটের জন্য সহায়ক হিসেবে ভূমিকা পালন করে।' 
                    : 'CareOn is a digital platform that plays role as facilitator for doctor visit services.'),
                  _buildNoteItem(isBangla 
                    ? 'নিশ্চিতকরণ কলের জন্য আপনার ফোন সচল রাখুন।' 
                    : 'Keep your phone accessible for the confirmation call.'),
                  _buildNoteItem(isBangla 
                    ? 'ভিজিটের সময় এবং ঠিকানা সঠিক কিনা তা নিশ্চিত করুন।' 
                    : 'Ensure the visit time and address are accurate.'),
                ],
              ),
              const SizedBox(height: 24),

              // Call Support
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Color(0xFFECFDF5),
                      child: Icon(Icons.phone_in_talk, color: CareOnApp.careOnGreen, size: 20),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isBangla ? 'কল সাপোর্ট' : 'Call Support',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const Text('+8801319552222', style: TextStyle(color: Color(0xFF6B7280), fontSize: 13)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Need Support Card
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => SupportScreen(isBangla: isBangla)),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Color(0xFFF3F4F6),
                        child: Icon(Icons.help_outline, color: Color(0xFF374151), size: 20),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isBangla ? 'সহায়তা প্রয়োজন?' : 'Need Support?',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          Text(
                            isBangla ? 'তাৎক্ষণিক সাহায্য পান' : 'Get instant help',
                            style: const TextStyle(color: Color(0xFF6B7280), fontSize: 13),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF9CA3AF)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Action Buttons
              _buildActionButton(
                onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                title: isBangla ? 'হোমে ফিরে যান' : 'Back to Home',
                icon: Icons.home_outlined,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: CareOnApp.careOnGreen),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    isBangla ? 'আরেকটি সেবা বুক করুন' : 'Book Another Service',
                    style: const TextStyle(color: CareOnApp.careOnGreen, fontWeight: FontWeight.bold),
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

  Widget _buildSectionCard({required String title, required List<Widget> children}) {
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
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF111827)),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: const TextStyle(color: Color(0xFF6B7280), fontSize: 13)),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: valueColor ?? const Color(0xFF1F2937)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Icon(Icons.check_circle, size: 14, color: CareOnApp.careOnGreen),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 13, color: Color(0xFF4B5563), height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF9CA3AF))),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280), height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({required VoidCallback onPressed, required String title, required IconData icon}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: CareOnApp.careOnGreen,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
          ],
        ),
      ),
    );
  }
}