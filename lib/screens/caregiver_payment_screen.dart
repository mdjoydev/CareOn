import 'package:flutter/material.dart';
import '../main.dart';
import 'caregiver_booking_utils.dart';
import 'caregiver_success_screen.dart';

class CaregiverPaymentScreen extends StatefulWidget {
  final bool isBangla;
  final BookingData bookingData;

  const CaregiverPaymentScreen({
    super.key,
    required this.isBangla,
    required this.bookingData,
  });

  @override
  State<CaregiverPaymentScreen> createState() => _CaregiverPaymentScreenState();
}

class _CaregiverPaymentScreenState extends State<CaregiverPaymentScreen> {
  String _selectedMethod = 'bKash';

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
        title: const Text('Payment Method', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          BookingStepIndicator(currentStep: 6),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const Text('Payment Method', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text('How would you like to pay?', style: TextStyle(color: Colors.grey, fontSize: 13)),
                const SizedBox(height: 32),
                
                _buildPaymentOption('bKash', 'bKash Payment Information', 'Send payment to: 01319552222', const Color(0xFFFDF2F8), const Color(0xFFBE185D)),
                const SizedBox(height: 16),
                _buildPaymentOption('Bank Transfer', 'Bank Transfer Details', 'Bank: ABC Bank\nAccount Name: Your Company Name\nAccount Number: 123456789\nBranch: Main Branch', const Color(0xFFEFF6FF), const Color(0xFF1D4ED8)),
                const SizedBox(height: 16),
                _buildPaymentOption('Cash On Delivery', '', '', Colors.white, Colors.black),
              ],
            ),
          ),
          _buildBottomNav(),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String val, String title, String details, Color bgColor, Color textColor) {
    final isSelected = _selectedMethod == val;
    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() => _selectedMethod = val),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: isSelected ? CareOnApp.careOnGreen : Colors.grey.shade200),
            ),
            child: Row(
              children: [
                Radio<String>(
                  value: val,
                  groupValue: _selectedMethod,
                  onChanged: (v) => setState(() => _selectedMethod = v!),
                  activeColor: CareOnApp.careOnGreen,
                ),
                Text(val, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ),
        if (isSelected && details.isNotEmpty)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: textColor.withValues(alpha: 0.1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: textColor)),
                const SizedBox(height: 8),
                Text(details, style: const TextStyle(fontSize: 13, height: 1.4)),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildBottomNav() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            child: const Text('Back'),
          ),
          const Spacer(),
          FilledButton(
            onPressed: () {
              widget.bookingData.paymentMethod = _selectedMethod;
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => CaregiverSuccessScreen(isBangla: widget.isBangla, bookingData: widget.bookingData)));
            },
            style: FilledButton.styleFrom(backgroundColor: CareOnApp.careOnGreen, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            child: const Text('Pay & Book'),
          ),
        ],
      ),
    );
  }
}
