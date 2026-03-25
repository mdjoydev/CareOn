import 'package:flutter/material.dart';
import '../../main.dart';
import 'nursing_booking_utils.dart';
import 'nursing_payment_screen.dart';

class NursingReviewScreen extends StatefulWidget {
  final bool isBangla;
  final NursingBookingData bookingData;

  const NursingReviewScreen({
    super.key,
    required this.isBangla,
    required this.bookingData,
  });

  @override
  State<NursingReviewScreen> createState() => _NursingReviewScreenState();
}

class _NursingReviewScreenState extends State<NursingReviewScreen> {
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
        title: Text(
          widget.isBangla ? 'পর্যালোচনা এবং নিশ্চিত করুন' : 'Review & Confirm',
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          NursingStepIndicator(currentStep: 5),
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
                      _buildSummaryRow(widget.isBangla ? 'প্যাকেজ:' : 'Package:', '${widget.bookingData.packageType} Package'),
                      const SizedBox(height: 16),
                      _buildSummaryRow(widget.isBangla ? 'ধরণ:' : 'Care Level:', widget.bookingData.careLevel),
                      const SizedBox(height: 16),
                      _buildSummaryRow(widget.isBangla ? 'সময়:' : 'Duration:', widget.bookingData.hours),
                      const SizedBox(height: 16),
                      _buildSummaryRow(widget.isBangla ? 'তারিখ ও সময়:' : 'Date & Time:', '${_formatDate(widget.bookingData.date)} • ${widget.bookingData.time?.format(context)}'),
                      const SizedBox(height: 16),
                      _buildSummaryRow(widget.isBangla ? 'রোগীর ঠিকানা:' : 'Patient Address:', '${widget.bookingData.address}'),
                      const Divider(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.isBangla ? 'মোট মূল্য' : 'Total Price',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: CareOnApp.careOnGreen),
                          ),
                          Text(
                            '৳ ${widget.bookingData.price}',
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
                      ? () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => NursingPaymentScreen(isBangla: widget.isBangla, bookingData: widget.bookingData))) 
                      : null,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: CareOnApp.careOnGreen,
                      disabledBackgroundColor: Colors.grey.shade300,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(
                      widget.isBangla ? 'নিশ্চিত করুন এবং পরবর্তী' : 'Confirm & Next',
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
