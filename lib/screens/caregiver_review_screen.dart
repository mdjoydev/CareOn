import 'package:flutter/material.dart';
import '../main.dart';
import 'caregiver_booking_utils.dart';
import 'caregiver_payment_screen.dart';

class CaregiverReviewScreen extends StatefulWidget {
  final bool isBangla;
  final BookingData bookingData;

  const CaregiverReviewScreen({
    super.key,
    required this.isBangla,
    required this.bookingData,
  });

  @override
  State<CaregiverReviewScreen> createState() => _CaregiverReviewScreenState();
}

class _CaregiverReviewScreenState extends State<CaregiverReviewScreen> {
  bool _agreed = false;

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
        title: const Text('Review & Confirm', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          BookingStepIndicator(currentStep: 5),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const Text('Review & Confirm', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text('Please review your booking details', style: TextStyle(color: Colors.grey, fontSize: 13)),
                const SizedBox(height: 24),
                
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Booking Summary', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 24),
                      _buildSummaryRow('Package:', '${widget.bookingData.packageType} Package'),
                      const SizedBox(height: 16),
                      _buildSummaryRow('Date & Time:', '${_formatDate(widget.bookingData.date)} • ${widget.bookingData.time?.format(context)}'),
                      const SizedBox(height: 16),
                      _buildSummaryRow('Patient Address:', '${widget.bookingData.area} ${widget.bookingData.address}'),
                      const Divider(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Price', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: CareOnApp.careOnGreen)),
                          Text('${widget.bookingData.price}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: CareOnApp.careOnGreen)),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0FDF4),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFDCFCE7)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Terms & Conditions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      const SizedBox(height: 16),
                      _buildBullet('I authorize CareOn-verified professionals to enter the specified address for the booked service time.'),
                      _buildBullet('I agree to provide a safe working environment and comply with all safety guidelines.'),
                      _buildBullet('All personal and medical information will be kept confidential.'),
                      _buildBullet('I confirm that all information provided is accurate and complete.'),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Checkbox(
                            value: _agreed, 
                            onChanged: (v) => setState(() => _agreed = v!),
                            activeColor: CareOnApp.careOnGreen,
                          ),
                          const Expanded(child: Text('I have read and agree to the terms and conditions', style: TextStyle(fontSize: 12))),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
          _buildBottomNav(),
        ],
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
        const SizedBox(width: 20),
        Expanded(child: Text(value, textAlign: TextAlign.right, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14))),
      ],
    );
  }

  Widget _buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 12, color: Color(0xFF374151)))),
        ],
      ),
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
            onPressed: _agreed ? () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CaregiverPaymentScreen(isBangla: widget.isBangla, bookingData: widget.bookingData))) : null,
            style: FilledButton.styleFrom(backgroundColor: const Color(0xFF86EFAC), foregroundColor: const Color(0xFF166534), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            child: const Text('Confirm & Next'),
          ),
        ],
      ),
    );
  }
}
