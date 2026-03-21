import 'package:flutter/material.dart';
import '../main.dart';
import 'caregiver_booking_utils.dart';
import 'caregiver_schedule_screen.dart';

class CaregiverPackageScreen extends StatefulWidget {
  final bool isBangla;
  final BookingData bookingData;
  const CaregiverPackageScreen({super.key, required this.isBangla, required this.bookingData});

  @override
  State<CaregiverPackageScreen> createState() => _CaregiverPackageScreenState();
}

class _CaregiverPackageScreenState extends State<CaregiverPackageScreen> {
  final Map<String, Map<String, Map<String, int>>> _prices = {
    'Daily': {
      'Basic Care': {'8 Hours': 600, '12 Hours': 1200, '24 Hours': 2400},
      'Standard Care': {'8 Hours': 1200, '12 Hours': 2400, '24 Hours': 3200},
      'Critical Care': {'8 Hours': 4000, '12 Hours': 6000, '24 Hours': 8000},
    },
    'Monthly': {
      'Basic Care': {'8 Hours': 3200, '12 Hours': 4800, '24 Hours': 5500},
      'Standard Care': {'8 Hours': 4800, '12 Hours': 6400, '24 Hours': 7200},
      'Critical Care': {'8 Hours': 12000, '12 Hours': 16000, '24 Hours': 24000},
    }
  };

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
        title: const Text('Select Package', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          BookingStepIndicator(currentStep: 2),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const Text('Select Package & Care Type', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Choose daily or monthly, hours, and care level', style: TextStyle(color: Color(0xFF6B7280))),
                const SizedBox(height: 24),
                
                // Daily/Monthly Toggle
                Container(
                  decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      Expanded(child: _buildTypeToggle('Daily Package', 'Daily')),
                      Expanded(child: _buildTypeToggle('Monthly Package', 'Monthly')),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                const Text('Select Care Type & Hours', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 20),
                
                _buildCareSection('Basic Care'),
                const SizedBox(height: 24),
                _buildCareSection('Standard Care'),
                const SizedBox(height: 24),
                _buildCareSection('Critical Care'),
                const SizedBox(height: 40),
              ],
            ),
          ),
          _buildBottomNav(),
        ],
      ),
    );
  }

  Widget _buildTypeToggle(String label, String value) {
    final isSelected = widget.bookingData.packageType == value;
    return GestureDetector(
      onTap: () => setState(() => widget.bookingData.packageType = value),
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? CareOnApp.careOnGreen : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(label, style: TextStyle(color: isSelected ? Colors.white : Colors.grey.shade600, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildCareSection(String careType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(careType, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF374151))),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildHourCard(careType, '8 Hours'),
            const SizedBox(width: 12),
            _buildHourCard(careType, '12 Hours'),
            const SizedBox(width: 12),
            _buildHourCard(careType, '24 Hours'),
          ],
        ),
      ],
    );
  }

  Widget _buildHourCard(String careType, String hour) {
    final isSelected = widget.bookingData.careLevel == careType && widget.bookingData.hours == hour;
    final price = _prices[widget.bookingData.packageType]![careType]![hour];

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() {
          widget.bookingData.careLevel = careType;
          widget.bookingData.hours = hour;
          widget.bookingData.price = price!;
        }),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? CareOnApp.careOnGreen : Colors.grey.shade200, width: 1.5),
          ),
          child: Column(
            children: [
              Text(hour, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 4),
              Text(widget.bookingData.packageType == 'Daily' ? 'Per Day' : 'Per Month', style: const TextStyle(fontSize: 10, color: Colors.grey)),
              const SizedBox(height: 4),
              Text('৳ $price', style: const TextStyle(color: CareOnApp.careOnGreen, fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
        ),
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
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CaregiverScheduleScreen(isBangla: widget.isBangla, bookingData: widget.bookingData))),
            style: FilledButton.styleFrom(backgroundColor: const Color(0xFF86EFAC), foregroundColor: const Color(0xFF166534), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}
