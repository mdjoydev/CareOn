import 'package:flutter/material.dart';
import '../../core/theme/responsive.dart';
import '../../main.dart';
import 'caregiver_booking_utils.dart';

class CaregiverSuccessScreen extends StatelessWidget {
  final bool isBangla;
  final BookingData bookingData;

  const CaregiverSuccessScreen({
    super.key,
    required this.isBangla,
    required this.bookingData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                height: 120,
                width: 120,
                decoration: const BoxDecoration(
                  color: Color(0xFFDCFCE7),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle_rounded, color: CareOnApp.careOnGreen, size: 80),
              ),
              const SizedBox(height: 32),
              Text(
                isBangla ? 'বুকিং সফল হয়েছে!' : 'Booking Successful!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Responsive.scaleFontSize(context, 24),
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                isBangla 
                  ? 'আপনার বুকিং অনুরোধটি গ্রহণ করা হয়েছে। আমাদের প্রতিনিধি শীঘ্রই আপনার সাথে যোগাযোগ করবেন।' 
                  : 'Your booking request has been received. Our representative will contact you shortly for confirmation.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Responsive.scaleFontSize(context, 16),
                  color: const Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                  child: Text(isBangla ? 'হোম পেজে ফিরে যান' : 'Back to Home'),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
