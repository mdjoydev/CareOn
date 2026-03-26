import 'package:flutter/material.dart';
import '../../main.dart';
import 'emergency_nursing_booking_utils.dart';
import 'emergency_nursing_service_screen.dart';

class EmergencyNursingLocationScreen extends StatefulWidget {
  final bool isBangla;
  final EmergencyNursingBookingData bookingData;
  const EmergencyNursingLocationScreen({super.key, required this.isBangla, required this.bookingData});

  @override
  State<EmergencyNursingLocationScreen> createState() => _EmergencyNursingLocationScreenState();
}

class _EmergencyNursingLocationScreenState extends State<EmergencyNursingLocationScreen> {
  String? _selectedArea;

  final List<String> _areas = [
    'Old Dhaka', 'Shyamoli', 'Tejgaon',
    'Gulshan', 'Gabtoli', 'Chawkbazar',
    'Mirpur', 'Rampura', 'Badda', 'Mohammadpur'
  ];

  @override
  void initState() {
    super.initState();
    _selectedArea = widget.bookingData.area ?? 'Old Dhaka';
  }

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
          widget.isBangla ? 'লোকেশন' : 'Location',
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            EmergencyNursingStepIndicator(currentStep: 1),
            const Divider(height: 1),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.isBangla ? 'আপনার এলাকা নির্বাচন করুন' : 'Select Your Area',
                      style: const TextStyle(
                        fontSize: 22, 
                        fontWeight: FontWeight.bold, 
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.isBangla 
                        ? 'সেবা প্রদানের জন্য সঠিক এলাকা নির্বাচন করুন' 
                        : 'Please choose the correct area for service delivery',
                      style: const TextStyle(color: Color(0xFF6B7280), fontSize: 14),
                    ),
                    const SizedBox(height: 32),
                    
                    // Area Selection Grid (using Wrap for better stability)
                    Wrap(
                      spacing: 12,
                      runSpacing: 16,
                      children: _areas.map((area) {
                        final isSelected = _selectedArea == area;
                        return InkWell(
                          onTap: () => setState(() => _selectedArea = area),
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: (MediaQuery.of(context).size.width - 72) / 2, // 2 items per row
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFFF0FDF4) : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected ? CareOnApp.careOnGreen : Colors.grey.shade200,
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isSelected ? Icons.check_circle : Icons.circle_outlined,
                                  size: 18,
                                  color: isSelected ? CareOnApp.careOnGreen : Colors.grey.shade400,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    area,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                      color: isSelected ? const Color(0xFF065F46) : const Color(0xFF374151),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
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
                    color: Colors.black.withValues(alpha: 0.05),
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
                        widget.bookingData.area = _selectedArea;
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => EmergencyNursingServiceScreen(
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
}