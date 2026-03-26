import 'package:flutter/material.dart';
import 'medical_test_booking_utils.dart';

class MedicalTestSuccessScreen extends StatelessWidget {
  final bool isBangla;
  final MedicalTestBookingData bookingData;

  const MedicalTestSuccessScreen({
    super.key,
    required this.isBangla,
    required this.bookingData,
  });

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF00A66C);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: primaryGreen.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: primaryGreen,
                  size: 80,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                isBangla ? 'বুকিং সফল হয়েছে!' : 'Booking Successful!',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                isBangla 
                  ? 'আপনার মেডিকেল টেস্ট বুকিং সফলভাবে গ্রহণ করা হয়েছে। আমাদের প্রতিনিধি শীঘ্রই আপনার সাথে যোগাযোগ করবেন।' 
                  : 'Your medical test booking has been successfully received. Our representative will contact you shortly.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
              const SizedBox(height: 48),
              
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _buildInfoRow(
                      isBangla ? 'বুকিং আইডি' : 'Booking ID',
                      '#MT${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
                    ),
                    const Divider(height: 24),
                    _buildInfoRow(
                      isBangla ? 'নির্বাচিত ল্যাব' : 'Selected Lab',
                      bookingData.selectedLab?.name ?? '',
                    ),
                    const Divider(height: 24),
                    _buildInfoRow(
                      isBangla ? 'মোট পরিমাণ' : 'Total Amount',
                      '৳ ${bookingData.grandTotal}',
                      valueColor: primaryGreen,
                    ),
                  ],
                ),
              ),
              
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    isBangla ? 'হোমপেজে ফিরে যান' : 'Back to Home',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: valueColor ?? Colors.black,
          ),
        ),
      ],
    );
  }
}
