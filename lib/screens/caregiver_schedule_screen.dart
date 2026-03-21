import 'package:flutter/material.dart';
import 'caregiver_booking_utils.dart';
import 'caregiver_address_screen.dart';

class CaregiverScheduleScreen extends StatefulWidget {
  final bool isBangla;
  final BookingData bookingData;
  const CaregiverScheduleScreen({super.key, required this.isBangla, required this.bookingData});

  @override
  State<CaregiverScheduleScreen> createState() => _CaregiverScheduleScreenState();
}

class _CaregiverScheduleScreenState extends State<CaregiverScheduleScreen> {
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null) setState(() => widget.bookingData.date = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 12, minute: 0),
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Schedule', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          BookingStepIndicator(currentStep: 3),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const Text('Schedule', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Choose your preferred schedule', style: TextStyle(color: Color(0xFF6B7280))),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Preferred Date *', style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          _buildPickerBox(
                            value: widget.bookingData.date == null ? 'Select preferred date' : '${widget.bookingData.date!.day}/${widget.bookingData.date!.month}/${widget.bookingData.date!.year}',
                            onTap: _pickDate,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Preferred Time *', style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          _buildPickerBox(
                            value: widget.bookingData.time == null ? 'Select preferred time (AM/PM)' : widget.bookingData.time!.format(context),
                            onTap: _pickTime,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _buildBottomNav(),
        ],
      ),
    );
  }

  Widget _buildPickerBox({required String value, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(
          value,
          style: TextStyle(color: value.contains('Select') ? Colors.grey : Colors.black, fontSize: 13),
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
            onPressed: () {
              if (widget.bookingData.date == null || widget.bookingData.time == null) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select both date and time')));
                return;
              }
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => CaregiverAddressScreen(isBangla: widget.isBangla, bookingData: widget.bookingData)));
            },
            style: FilledButton.styleFrom(backgroundColor: const Color(0xFF86EFAC), foregroundColor: const Color(0xFF166534), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}
