import 'package:flutter/material.dart';
import '../../main.dart';
import 'physiotherapy_booking_utils.dart';
import 'physiotherapy_payment_screen.dart';

class PhysiotherapyReviewScreen extends StatefulWidget {
  final bool isBangla;
  final PhysiotherapyBookingData bookingData;

  const PhysiotherapyReviewScreen({
    super.key,
    required this.isBangla,
    required this.bookingData,
  });

  @override
  State<PhysiotherapyReviewScreen> createState() => _PhysiotherapyReviewScreenState();
}

class _PhysiotherapyReviewScreenState extends State<PhysiotherapyReviewScreen> {
  bool _agreed = false;

  @override
  Widget build(BuildContext context) {
    final data = widget.bookingData;

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
          widget.isBangla ? 'পর্যালোচনা' : 'Review',
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          PhysiotherapyStepIndicator(currentStep: 3),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Text(
                  widget.isBangla ? 'পর্যালোচনা এবং নিশ্চিত করুন' : 'Review & Confirm',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.isBangla ? 'আপনার বুকিং তথ্য যাচাই করুন' : 'Please review your booking details',
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
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
                      Text(
                        widget.isBangla ? 'বুকিং সারাংশ' : 'Booking Summary',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 24),
                      _buildSummaryRow(widget.isBangla ? 'সেবা:' : 'Service:', data.serviceName ?? 'Physiotherapy'),
                      _buildSummaryRow(widget.isBangla ? 'প্যাকেজ:' : 'Package:', '${data.careLevel} (${data.packageType})'),
                      _buildSummaryRow(widget.isBangla ? 'এলাকা:' : 'Area:', data.area ?? '-'),
                      _buildSummaryRow(widget.isBangla ? 'রোগীর নাম:' : 'Patient:', data.patientName ?? '-'),
                      _buildSummaryRow(widget.isBangla ? 'ঠিকানা:' : 'Address:', data.address ?? '-', isMultiLine: true),
                      const Divider(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.isBangla ? 'মোট মূল্য' : 'Total Price',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: CareOnApp.careOnGreen),
                          ),
                          Text(
                            '৳ ${data.price}',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: CareOnApp.careOnGreen),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),

                Text(
                  widget.isBangla ? 'শর্তাবলী' : 'Terms & Conditions',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 16),
                _buildBullet('I authorize CareOn-verified professionals to enter the specified address for the booked service time.'),
                _buildBullet('I agree to provide a safe working environment and comply with all safety guidelines.'),
                _buildBullet('All personal and medical information will be kept confidential.'),
                _buildBullet('I confirm that all information provided is accurate and complete.'),
                
                const SizedBox(height: 24),
                Row(
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: Checkbox(
                        value: _agreed, 
                        onChanged: (v) => setState(() => _agreed = v!),
                        activeColor: CareOnApp.careOnGreen,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _agreed = !_agreed),
                        child: Text(
                          widget.isBangla ? 'আমি সকল শর্তাবলীতে সম্মত' : 'I have read and agree to the terms and conditions', 
                          style: const TextStyle(fontSize: 13, color: Color(0xFF374151)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(24),
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
                      widget.isBangla ? 'পেছনে' : 'Back',
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FilledButton(
                    onPressed: _agreed 
                      ? () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => PhysiotherapyPaymentScreen(isBangla: widget.isBangla, bookingData: widget.bookingData))) 
                      : null,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: CareOnApp.careOnGreen,
                      disabledBackgroundColor: Colors.grey.shade300,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(
                      widget.isBangla ? 'নিশ্চিত করুন' : 'Confirm & Next',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isMultiLine = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: isMultiLine ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(width: 20),
          Expanded(child: Text(value, textAlign: TextAlign.right, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14))),
        ],
      ),
    );
  }

  Widget _buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13, color: Color(0xFF4B5563), height: 1.4))),
        ],
      ),
    );
  }
}
