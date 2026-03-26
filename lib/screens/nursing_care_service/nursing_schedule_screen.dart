import 'package:flutter/material.dart';
import '../../main.dart';
import 'nursing_booking_utils.dart';
import 'nursing_address_screen.dart';

class NursingScheduleScreen extends StatefulWidget {
  final bool isBangla;
  final NursingBookingData bookingData;
  const NursingScheduleScreen({super.key, required this.isBangla, required this.bookingData});

  @override
  State<NursingScheduleScreen> createState() => _NursingScheduleScreenState();
}

class _NursingScheduleScreenState extends State<NursingScheduleScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.bookingData.date ?? DateTime.now().add(const Duration(days: 1));
    _selectedTime = widget.bookingData.time ?? const TimeOfDay(hour: 10, minute: 0);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: CareOnApp.careOnGreen),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: CareOnApp.careOnGreen),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() => _selectedTime = picked);
    }
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
          widget.isBangla ? 'সময়সূচী' : 'Schedule',
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            NursingStepIndicator(currentStep: 3),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  Text(
                    widget.isBangla ? 'তারিখ ও সময় নির্বাচন করুন' : 'Select Date & Time',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.isBangla 
                      ? 'আপনার সুবিধাজনক সময় অনুযায়ী সেবা শুরু করুন' 
                      : 'Choose when you want the service to start',
                    style: const TextStyle(color: Color(0xFF6B7280), fontSize: 14),
                  ),
                  const SizedBox(height: 32),
                  
                  _buildPickerCard(
                    title: widget.isBangla ? 'তারিখ' : 'Starting Date',
                    value: _selectedDate == null ? (widget.isBangla ? 'তারিখ পছন্দ করুন' : 'Select Date') : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
                    icon: Icons.calendar_today_outlined,
                    onTap: () => _selectDate(context),
                  ),
                  const SizedBox(height: 20),
                  _buildPickerCard(
                    title: widget.isBangla ? 'সময়' : 'Preferred Time',
                    value: _selectedTime == null ? (widget.isBangla ? 'সময় পছন্দ করুন' : 'Select Time') : _selectedTime!.format(context),
                    icon: Icons.access_time_outlined,
                    onTap: () => _selectTime(context),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, -5))]),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14), side: BorderSide(color: Colors.grey.shade300), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                      child: Text(widget.isBangla ? 'পিছনে' : 'Back', style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        widget.bookingData.date = _selectedDate;
                        widget.bookingData.time = _selectedTime;
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => NursingAddressScreen(isBangla: widget.isBangla, bookingData: widget.bookingData)));
                      },
                      style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14), backgroundColor: CareOnApp.careOnGreen, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                      child: Text(widget.isBangla ? 'পরবর্তী' : 'Next', style: const TextStyle(fontWeight: FontWeight.bold)),
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

  Widget _buildPickerCard({required String title, required String value, required IconData icon, required VoidCallback onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF374151))),
        const SizedBox(height: 12),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                Icon(icon, color: CareOnApp.careOnGreen, size: 20),
                const SizedBox(width: 12),
                Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF1F2937))),
                const Spacer(),
                const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
