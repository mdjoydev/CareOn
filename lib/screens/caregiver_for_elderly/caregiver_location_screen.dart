import 'package:flutter/material.dart';
import '../../main.dart';
import 'caregiver_booking_utils.dart';
import 'caregiver_package_screen.dart';

class CaregiverLocationScreen extends StatefulWidget {
  final bool isBangla;
  final BookingData bookingData;
  const CaregiverLocationScreen({super.key, required this.isBangla, required this.bookingData});

  @override
  State<CaregiverLocationScreen> createState() => _CaregiverLocationScreenState();
}

class _CaregiverLocationScreenState extends State<CaregiverLocationScreen> {
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.isBangla ? 'সেবা নির্বাচন' : 'Service Booking',
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          BookingStepIndicator(currentStep: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Text(
                  widget.isBangla ? 'ঢাকায় আপনার অবস্থান নির্বাচন করুন' : 'Select Your Location in Dhaka',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.isBangla ? 'এগিয়ে যেতে আপনার এলাকা বেছে নিন' : 'Choose your area to proceed',
                  style: const TextStyle(color: Color(0xFF6B7280)),
                ),
                const SizedBox(height: 32),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: 40,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                  ),
                  itemCount: _areas.length,
                  itemBuilder: (context, index) {
                    final area = _areas[index];
                    final isSelected = _selectedArea == area;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedArea = area),
                      child: Row(
                        children: [
                          Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected ? CareOnApp.careOnGreen : Colors.grey.shade400,
                                width: 2,
                              ),
                            ),
                            child: isSelected 
                                ? Center(child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: CareOnApp.careOnGreen, shape: BoxShape.circle)))
                                : null,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              area,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                color: isSelected ? Colors.black : Colors.grey.shade600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_back_ios, size: 14),
                      const SizedBox(width: 4),
                      Text(widget.isBangla ? 'পিছনে' : 'Back'),
                    ],
                  ),
                ),
                const Spacer(),
                FilledButton(
                  onPressed: () {
                    widget.bookingData.area = _selectedArea;
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => CaregiverPackageScreen(
                          isBangla: widget.isBangla,
                          bookingData: widget.bookingData,
                        ),
                      ),
                    );
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF86EFAC),
                    foregroundColor: const Color(0xFF166534),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Row(
                    children: [
                      Text(widget.isBangla ? 'পরবর্তী' : 'Next'),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_forward_ios, size: 14),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
