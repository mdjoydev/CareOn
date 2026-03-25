import 'package:flutter/material.dart';
import '../../main.dart';
import 'baby_care_booking_utils.dart';
import 'baby_care_payment_screen.dart';

class BabyCareReviewScreen extends StatefulWidget {
  final bool isBangla;
  final BabyCareBookingData bookingData;

  const BabyCareReviewScreen({
    super.key,
    required this.isBangla,
    required this.bookingData,
  });

  @override
  State<BabyCareReviewScreen> createState() => _BabyCareReviewScreenState();
}

class _BabyCareReviewScreenState extends State<BabyCareReviewScreen> {
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
          BabyCareStepIndicator(currentStep: 5),
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
                
                // Booking Summary Card
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
                      _buildSummaryRow(
                        widget.isBangla ? 'প্যাকেজ:' : 'Package:', 
                        widget.isBangla ? '${widget.bookingData.packageType} প্যাকেজ' : '${widget.bookingData.packageType} Package'
                      ),
                      const SizedBox(height: 16),
                      _buildSummaryRow(
                        widget.isBangla ? 'যত্নের স্তর:' : 'Care Level:', 
                        widget.bookingData.careLevel
                      ),
                      const SizedBox(height: 16),
                      _buildSummaryRow(
                        widget.isBangla ? 'সময়কাল:' : 'Duration:', 
                        widget.bookingData.hours
                      ),
                      const SizedBox(height: 16),
                      _buildSummaryRow(
                        widget.isBangla ? 'তারিখ ও সময়:' : 'Date & Time:', 
                        '${_formatDate(widget.bookingData.date)} • ${widget.bookingData.time?.format(context)}'
                      ),
                      const SizedBox(height: 16),
                      _buildSummaryRow(
                        widget.isBangla ? 'ঠিকানা:' : 'Address:', 
                        '${widget.bookingData.area}, ${widget.bookingData.address}'
                      ),
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
                
                const SizedBox(height: 24),

                // Terms & Conditions Container
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
                      Text(
                        widget.isBangla ? 'শর্তাবলী' : 'Terms & Conditions',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      const SizedBox(height: 16),
                      _buildBullet(widget.isBangla 
                        ? 'আমি বুক করা সেবার জন্য নির্ধারিত ঠিকানায় কেয়ার-অন ভেরিফাইড পেশাদারদের প্রবেশের অনুমতি দিচ্ছি।' 
                        : 'I authorize CareOn-verified professionals to enter the specified address for the booked service time.'),
                      _buildBullet(widget.isBangla 
                        ? 'আমি একটি নিরাপদ কাজের পরিবেশ প্রদান করতে এবং সকল সুরক্ষা নির্দেশিকা মেনে চলতে সম্মত।' 
                        : 'I agree to provide a safe working environment and comply with all safety guidelines.'),
                      _buildBullet(widget.isBangla 
                        ? 'সকল ব্যক্তিগত তথ্য গোপন রাখা হবে।' 
                        : 'All personal information will be kept confidential.'),
                      _buildBullet(widget.isBangla 
                        ? 'আমি নিশ্চিত করছি যে প্রদত্ত সকল তথ্য সঠিক এবং সম্পূর্ণ।' 
                        : 'I confirm that all information provided is accurate and complete.'),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Checkbox(
                            value: _agreed, 
                            onChanged: (v) => setState(() => _agreed = v!),
                            activeColor: CareOnApp.careOnGreen,
                          ),
                          Expanded(
                            child: Text(
                              widget.isBangla 
                                ? 'আমি শর্তাবলী পড়েছি এবং তাতে সম্মত' 
                                : 'I have read and agree to the terms and conditions', 
                              style: const TextStyle(fontSize: 12)
                            ),
                          ),
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
    if (widget.isBangla) {
      return '${date.day}/${date.month}/${date.year}';
    }
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
              onPressed: _agreed 
                ? () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => BabyCarePaymentScreen(isBangla: widget.isBangla, bookingData: widget.bookingData))) 
                : null,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: const Color(0xFF059669),
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
    );
  }
}
