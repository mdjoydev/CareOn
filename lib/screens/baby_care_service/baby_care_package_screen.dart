import 'package:flutter/material.dart';
import 'baby_care_booking_utils.dart';
import 'baby_care_schedule_screen.dart';

class BabyCarePackageScreen extends StatefulWidget {
  final bool isBangla;
  final BabyCareBookingData bookingData;
  const BabyCarePackageScreen({super.key, required this.isBangla, required this.bookingData});

  @override
  State<BabyCarePackageScreen> createState() => _BabyCarePackageScreenState();
}

class _BabyCarePackageScreenState extends State<BabyCarePackageScreen> {
  final Map<String, Map<String, Map<String, int>>> _prices = {
    'Daily': {
      'Basic Care': {'8 Hours': 800, '12 Hours': 1200, '24 Hours': 1600},
      'Standard Care': {'8 Hours': 2000, '12 Hours': 2600, '24 Hours': 3200},
      'Critical Care': {'8 Hours': 4000, '12 Hours': 4800, '24 Hours': 5600},
    },
    'Monthly': {
      'Basic Care': {'8 Hours': 5000, '12 Hours': 8000, '24 Hours': 12000},
      'Standard Care': {'8 Hours': 8000, '12 Hours': 14000, '24 Hours': 18000},
      'Critical Care': {'8 Hours': 20000, '12 Hours': 24000, '24 Hours': 27000},
    }
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
          widget.isBangla ? 'প্যাকেজ নির্বাচন' : 'Select Package',
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            BabyCareStepIndicator(currentStep: 2),
            const Divider(height: 1),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.isBangla ? 'প্যাকেজ এবং যত্নের ধরণ' : 'Select Package & Care Type',
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.isBangla 
                        ? 'দৈনিক বা মাসিক, সময় এবং যত্নের স্তর নির্বাচন করুন' 
                        : 'Choose daily or monthly, hours, and care level',
                      style: const TextStyle(color: Color(0xFF6B7280), fontSize: 14),
                    ),
                    const SizedBox(height: 24),
                    
                    // Daily/Monthly Toggle
                    Container(
                      decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        children: [
                          Expanded(child: _buildTypeToggle(widget.isBangla ? 'দৈনিক' : 'Daily', 'Daily')),
                          Expanded(child: _buildTypeToggle(widget.isBangla ? 'মাসিক' : 'Monthly', 'Monthly')),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      widget.isBangla ? 'যত্নের ধরণ এবং সময় নির্বাচন করুন' : 'Select Care Type & Hours',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF111827)),
                    ),
                    const SizedBox(height: 20),
                    
                    _buildCareSection(widget.isBangla ? 'বেসিক কেয়ার' : 'Basic Care', 'Basic Care'),
                    const SizedBox(height: 24),
                    _buildCareSection(widget.isBangla ? 'স্ট্যান্ডার্ড কেয়ার' : 'Standard Care', 'Standard Care'),
                    const SizedBox(height: 24),
                    _buildCareSection(widget.isBangla ? 'ক্রিটিক্যাল কেয়ার' : 'Critical Care', 'Critical Care'),
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
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => BabyCareScheduleScreen(
                            isBangla: widget.isBangla, 
                            bookingData: widget.bookingData
                          ),
                        ),
                      ),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: const Color(0xFF059669),
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

  Widget _buildTypeToggle(String label, String value) {
    final isSelected = widget.bookingData.packageType == value;
    return GestureDetector(
      onTap: () => setState(() => widget.bookingData.packageType = value),
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF059669) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(label, style: TextStyle(color: isSelected ? Colors.white : Colors.grey.shade600, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildCareSection(String displayTitle, String internalValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(displayTitle, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF374151))),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildHourCard(internalValue, '8 Hours'),
            const SizedBox(width: 12),
            _buildHourCard(internalValue, '12 Hours'),
            const SizedBox(width: 12),
            _buildHourCard(internalValue, '24 Hours'),
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
                              color: isSelected ? const Color(0xFFF0FDF4) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? const Color(0xFF059669) : Colors.grey.shade200, width: 1.5),
          ),
          child: Column(
            children: [
              Text(hour, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              const SizedBox(height: 4),
              Text(
                widget.bookingData.packageType == 'Daily' 
                  ? (widget.isBangla ? 'প্রতিদিন' : 'Per Day') 
                  : (widget.isBangla ? 'প্রতি মাস' : 'Per Month'), 
                style: const TextStyle(fontSize: 9, color: Colors.grey)
              ),
              const SizedBox(height: 4),
              Text('৳ $price', style: const TextStyle(color: Color(0xFF059669), fontWeight: FontWeight.bold, fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }
}
