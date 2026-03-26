import 'package:flutter/material.dart';
import '../../main.dart';
import 'emergency_nursing_booking_utils.dart';
import 'emergency_nursing_address_screen.dart';

class EmergencyNursingScheduleScreen extends StatefulWidget {
  final bool isBangla;
  final EmergencyNursingBookingData bookingData;
  const EmergencyNursingScheduleScreen({super.key, required this.isBangla, required this.bookingData});

  @override
  State<EmergencyNursingScheduleScreen> createState() => _EmergencyNursingScheduleScreenState();
}

class _EmergencyNursingScheduleScreenState extends State<EmergencyNursingScheduleScreen> {
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: widget.bookingData.date ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null) setState(() => widget.bookingData.date = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: widget.bookingData.time ?? const TimeOfDay(hour: 12, minute: 0),
    );
    if (picked != null) setState(() => widget.bookingData.time = picked);
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
          widget.isBangla ? 'সময়সূচী' : 'Schedule',
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            EmergencyNursingStepIndicator(currentStep: 3),
            const Divider(height: 1),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.isBangla ? 'পছন্দসই সময়সূচী নির্বাচন করুন' : 'Select Preferred Schedule',
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.isBangla 
                        ? 'আপনার সুবিধাজনক তারিখ এবং সময় নির্ধারণ করুন' 
                        : 'Choose your convenient date and time',
                      style: const TextStyle(color: Color(0xFF6B7280), fontSize: 14),
                    ),
                    const SizedBox(height: 32),
                    
                    Text(
                      widget.isBangla ? 'পছন্দসই তারিখ *' : 'Preferred Date *', 
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF374151))
                    ),
                    const SizedBox(height: 12),
                    _buildPickerBox(
                      value: widget.bookingData.date == null 
                        ? (widget.isBangla ? 'তারিখ নির্বাচন করুন' : 'Select preferred date') 
                        : '${widget.bookingData.date!.day}/${widget.bookingData.date!.month}/${widget.bookingData.date!.year}',
                      onTap: _pickDate,
                      icon: Icons.calendar_today_outlined,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    Text(
                      widget.isBangla ? 'পছন্দসই সময় *' : 'Preferred Time *', 
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF374151))
                    ),
                    const SizedBox(height: 12),
                    _buildPickerBox(
                      value: widget.bookingData.time == null 
                        ? (widget.isBangla ? 'সময় নির্বাচন করুন' : 'Select preferred time') 
                        : widget.bookingData.time!.format(context),
                      onTap: _pickTime,
                      icon: Icons.access_time_outlined,
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
                        if (widget.bookingData.date == null || widget.bookingData.time == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(widget.isBangla ? 'অনুগ্রহ করে তারিখ এবং সময় উভয়ই নির্বাচন করুন' : 'Please select both date and time'))
                          );
                          return;
                        }
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => EmergencyNursingAddressScreen(
                              isBangla: widget.isBangla,
                              location: widget.bookingData.area ?? '',
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

  Widget _buildPickerBox({required String value, required VoidCallback onTap, required IconData icon}) {
    final bool hasValue = !value.contains('Select') && !value.contains('নির্বাচন');
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: hasValue ? CareOnApp.careOnGreen : Colors.grey.shade200, width: 1.5),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: hasValue ? CareOnApp.careOnGreen : Colors.grey.shade400),
            const SizedBox(width: 12),
            Text(
              value,
              style: TextStyle(
                color: hasValue ? Colors.black : Colors.grey.shade500, 
                fontSize: 15,
                fontWeight: hasValue ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            const Spacer(),
            Icon(Icons.keyboard_arrow_down, size: 20, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}