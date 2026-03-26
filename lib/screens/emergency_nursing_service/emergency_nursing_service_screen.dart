import 'package:flutter/material.dart';
import '../../main.dart';
import 'emergency_nursing_booking_utils.dart';
import 'emergency_nursing_schedule_screen.dart';

class EmergencyNursingServiceScreen extends StatefulWidget {
  final bool isBangla;
  final EmergencyNursingBookingData bookingData;
  const EmergencyNursingServiceScreen({super.key, required this.isBangla, required this.bookingData});

  @override
  State<EmergencyNursingServiceScreen> createState() => _EmergencyNursingServiceScreenState();
}

class _EmergencyNursingServiceScreenState extends State<EmergencyNursingServiceScreen> {
  final Map<String, int> _servicePrices = {
    'IV cannulation': 500,
    'Nebulization': 600,
    'Injection': 1500,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.isBangla ? 'সেবা নির্বাচন' : 'Select Service',
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            EmergencyNursingStepIndicator(currentStep: 2),
            const Divider(height: 1),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.isBangla ? 'জরুরি নার্সিং সেবা নির্বাচন করুন' : 'Select Emergency Nursing Service',
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.isBangla 
                        ? 'আপনার প্রয়োজনীয় জরুরি নার্সিং সেবা নির্বাচন করুন' 
                        : 'Choose your required emergency nursing service',
                      style: const TextStyle(color: Color(0xFF6B7280), fontSize: 14),
                    ),
                    const SizedBox(height: 32),
                    
                    // Service Selection Cards
                    _buildServiceCard('IV cannulation', '৳ 500', 'IV ক্যানুলেশন'),
                    const SizedBox(height: 16),
                    _buildServiceCard('Nebulization', '৳ 600', 'নেবুলাইজেশন'),
                    const SizedBox(height: 16),
                    _buildServiceCard('Injection', '৳ 1500', 'ইনজেকশন'),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            
            // Bottom Navigation
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(
                        widget.isBangla ? 'পিছনে' : 'Back',
                        style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        if (widget.bookingData.serviceName == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(widget.isBangla ? 'অনুগ্রহ করে একটি সেবা নির্বাচন করুন' : 'Please select a service'))
                          );
                          return;
                        }
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => EmergencyNursingScheduleScreen(
                              isBangla: widget.isBangla,
                              bookingData: widget.bookingData,
                            ),
                          ),
                        );
                      },
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: CareOnApp.careOnGreen,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(
                        widget.isBangla ? 'পরবর্তী' : 'Next',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(String serviceId, String price, String serviceBangla) {
    final isSelected = widget.bookingData.serviceName == serviceId;
    
    return GestureDetector(
      onTap: () => setState(() {
        widget.bookingData.serviceName = serviceId;
        widget.bookingData.price = _servicePrices[serviceId] ?? 500;
      }),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF0FDF4) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? CareOnApp.careOnGreen : Colors.grey.shade200, width: 1.5),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              size: 20,
              color: isSelected ? CareOnApp.careOnGreen : Colors.grey.shade400,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.isBangla ? serviceBangla : serviceId,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? const Color(0xFF065F46) : const Color(0xFF374151),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: const TextStyle(color: CareOnApp.careOnGreen, fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}