import 'package:flutter/material.dart';
import '../../main.dart';
import 'patients_attendant_booking_utils.dart';
import 'patients_attendant_success_screen.dart';

class PatientsAttendantPaymentScreen extends StatefulWidget {
  final bool isBangla;
  final PatientsAttendantBookingData bookingData;

  const PatientsAttendantPaymentScreen({
    super.key,
    required this.isBangla,
    required this.bookingData,
  });

  @override
  State<PatientsAttendantPaymentScreen> createState() => _PatientsAttendantPaymentScreenState();
}

class _PatientsAttendantPaymentScreenState extends State<PatientsAttendantPaymentScreen> {
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
        title: Text(
          widget.isBangla ? 'পেমেন্ট পদ্ধতি' : 'Payment Method',
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          PatientsAttendantStepIndicator(currentStep: 6),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Text(
                  widget.isBangla ? 'পেমেন্ট পদ্ধতি' : 'Payment Method',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.isBangla ? 'আপনি কিভাবে পেমেন্ট করতে চান?' : 'How would you like to pay?',
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
                const SizedBox(height: 32),
                
                _buildPaymentOption(
                  'bKash', 
                  widget.isBangla ? 'বিকাশ পেমেন্ট তথ্য' : 'bKash Payment Information', 
                  widget.isBangla ? 'পেমেন্ট পাঠান: ০১৭১৯৫৫২২২২' : 'Send payment to: 01319552222', 
                  const Color(0xFFFDF2F8), 
                  const Color(0xFFBE185D),
                  Icons.account_balance_wallet_outlined,
                ),
                const SizedBox(height: 16),
                _buildPaymentOption(
                  'Bank Transfer', 
                  widget.isBangla ? 'ব্যাংক ট্রান্সফার তথ্য' : 'Bank Transfer Details', 
                  widget.isBangla 
                    ? 'ব্যাংক: এবিসি ব্যাংক\nঅ্যাকাউন্ট নাম: কেয়ারঅন লিমিটেড\nঅ্যাকাউন্ট নম্বর: ১২৩৪৫৬৭৮৯' 
                    : 'Bank: ABC Bank\nAccount Name: CareOn Ltd\nAccount Number: 123456789', 
                  const Color(0xFFEFF6FF), 
                  const Color(0xFF1D4ED8),
                  Icons.account_balance,
                ),
                const SizedBox(height: 16),
                _buildPaymentOption(
                  'Cash On Delivery', 
                  widget.isBangla ? 'ক্যাশ অন ডেলিভারি' : 'Cash On Delivery', 
                  widget.isBangla ? 'সেবা গ্রহণের পর পেমেন্ট করুন' : 'Pay after receiving the service', 
                  const Color(0xFFF9FAFB), 
                  Colors.black87,
                  Icons.payments_outlined,
                ),
              ],
            ),
          ),
          _buildBottomNav(),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String val, String title, String details, Color bgColor, Color textColor, IconData icon) {
    final isSelected = _selectedMethod == val;
    return Column(
      children: [
        InkWell(
          onTap: () => setState(() => _selectedMethod = val),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? CareOnApp.careOnGreen : Colors.grey.shade200,
                width: isSelected ? 2 : 1,
              ),
              color: isSelected ? CareOnApp.careOnGreen.withOpacity(0.02) : Colors.white,
            ),
            child: Row(
              children: [
                Icon(icon, color: isSelected ? CareOnApp.careOnGreen : Colors.grey),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    val == 'bKash' ? (widget.isBangla ? 'বিকাশ' : 'bKash') : 
                    val == 'Bank Transfer' ? (widget.isBangla ? 'ব্যাংক ট্রান্সফার' : 'Bank Transfer') :
                    (widget.isBangla ? 'ক্যাশ অন ডেলিভারি' : 'Cash On Delivery'),
                    style: TextStyle(
                      fontSize: 15, 
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      color: isSelected ? Colors.black : Colors.black87,
                    ),
                  ),
                ),
                Radio<String>(
                  value: val,
                  groupValue: _selectedMethod,
                  onChanged: (v) => setState(() => _selectedMethod = v!),
                  activeColor: CareOnApp.careOnGreen,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          ),
        ),
        if (isSelected && details.isNotEmpty)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: textColor.withOpacity(0.1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: textColor)),
                  ),
                Text(details, style: const TextStyle(fontSize: 13, height: 1.4, color: Colors.black87)),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildBottomNav() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: BorderSide(color: Colors.grey.shade300),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                widget.isBangla ? 'পিছনে' : 'Back',
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: FilledButton(
              onPressed: () {
                widget.bookingData.paymentMethod = _selectedMethod;
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => PatientsAttendantSuccessScreen(
                    isBangla: widget.isBangla, 
                    bookingData: widget.bookingData
                  ),
                ));
              },
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: CareOnApp.careOnGreen,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                widget.isBangla ? 'পেমেন্ট ও বুকিং' : 'Pay & Book',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
