import 'package:flutter/material.dart';
import '../../main.dart';
import 'doctor_visit_booking_utils.dart';
import 'doctor_visit_success_screen.dart';

class DoctorVisitBookingScreen extends StatefulWidget {
  final bool isBangla;
  const DoctorVisitBookingScreen({super.key, required this.isBangla});

  @override
  State<DoctorVisitBookingScreen> createState() => _DoctorVisitBookingScreenState();
}

class _DoctorVisitBookingScreenState extends State<DoctorVisitBookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final DoctorVisitBookingData _bookingData = DoctorVisitBookingData();

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _problemController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _problemController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (date != null) {
      setState(() {
        _bookingData.appointmentDate = date;
      });
    }
  }

  Future<void> _selectTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        _bookingData.appointmentTime = time;
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      if (_bookingData.appointmentDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select appointment date')),
        );
        return;
      }

      if (_bookingData.appointmentTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select appointment time')),
        );
        return;
      }

      _bookingData.patientName = _nameController.text;
      _bookingData.patientAge = _ageController.text;
      _bookingData.email = _emailController.text;
      _bookingData.mobileNumber = _mobileController.text;
      _bookingData.problem = _problemController.text;
      _bookingData.additionalNotes = _notesController.text;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => DoctorVisitSuccessScreen(
            isBangla: widget.isBangla,
            bookingData: _bookingData,
          ),
        ),
      );
    }
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
          widget.isBangla ? 'ডাক্তারের ভিজিট' : 'Doctor Visit At Home',
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const DoctorVisitStepIndicator(currentStep: 1),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.isBangla ? 'ডাক্তারের ভিজিট' : 'Doctor Visit At Home',
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.isBangla ? 'সাধারণ/বিশেষায়িত ডাক্তার' : 'General/Specialized Doctors',
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      widget.isBangla ? 'ডাক্তারের ভিজিট শিডিউল করুন' : 'Schedule Doctor Visit At Home',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.isBangla ? 'তারকা (*) চিহ্নিত ফিল্ডগুলো পূরণ করা আবশ্যিক।' : 'Fields marked with * are required.',
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                    const SizedBox(height: 24),

                    _buildSectionTitle(widget.isBangla ? 'বুকিং এর জন্য *' : 'Booking For *'),
                    Row(
                      children: [
                        Expanded(child: _buildSelectionChip('Self', widget.isBangla ? 'নিজের জন্য' : 'Self', _bookingData.isForSelf, (v) => setState(() => _bookingData.isForSelf = true))),
                        const SizedBox(width: 12),
                        Expanded(child: _buildSelectionChip('Someone Else', widget.isBangla ? 'অন্যের জন্য' : 'Someone Else', !_bookingData.isForSelf, (v) => setState(() => _bookingData.isForSelf = false))),
                      ],
                    ),
                    const SizedBox(height: 24),

                    _buildSectionTitle(widget.isBangla ? 'আপনার সমস্যা *' : 'Your Problem *'),
                    _buildTextField(
                      label: '',
                      controller: _problemController,
                      hint: widget.isBangla ? 'সমস্যার বিবরণ লিখুন' : 'Describe your problem',
                      maxLines: 3,
                    ),
                    const SizedBox(height: 24),

                    _buildSectionTitle(widget.isBangla ? 'কনসাল্টেশন ডিটেইলস' : 'Consultation Details'),
                    
                    _buildSectionTitle(widget.isBangla ? 'বিশেষায়িত *' : 'Specialization *'),
                    DropdownButtonFormField<String>(
                      decoration: _inputDecoration(widget.isBangla ? 'বিশেষায়িত নির্বাচন করুন' : 'Select specialization'),
                      items: [
                        'General Physician',
                        'Cardiologist',
                        'Dermatologist',
                        'Pediatrician',
                        'Gynecologist',
                        'Orthopedic',
                        'Neurologist',
                        'Psychiatrist',
                        'ENT Specialist',
                        'Urologist',
                        'Endocrinologist',
                        'Gastroenterologist',
                      ].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                      onChanged: (val) => setState(() => _bookingData.specialization = val),
                      validator: (val) => val == null ? widget.isBangla ? 'বিশেষায়িত নির্বাচন করুন' : 'Please select specialization' : null,
                    ),
                    const SizedBox(height: 16),

                    _buildSectionTitle(widget.isBangla ? 'অ্যাপয়েন্টমেন্ট তারিখ *' : 'Appointment Date *'),
                    InkWell(
                      onTap: _selectDate,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today, color: CareOnApp.careOnGreen, size: 20),
                            const SizedBox(width: 12),
                            Text(
                              _bookingData.appointmentDate == null
                                  ? widget.isBangla ? 'তারিখ নির্বাচন করুন' : 'Select Date'
                                  : '${_bookingData.appointmentDate!.day}/${_bookingData.appointmentDate!.month}/${_bookingData.appointmentDate!.year}',
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    _buildSectionTitle(widget.isBangla ? 'অ্যাপয়েন্টমেন্ট সময় *' : 'Appointment Time *'),
                    InkWell(
                      onTap: _selectTime,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.access_time, color: CareOnApp.careOnGreen, size: 20),
                            const SizedBox(width: 12),
                            Text(
                              _bookingData.appointmentTime == null
                                  ? widget.isBangla ? 'সময় নির্বাচন করুন' : 'Select Time'
                                  : '${_bookingData.appointmentTime!.hour}:${_bookingData.appointmentTime!.minute.toString().padLeft(2, '0')}',
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    _buildSectionTitle(widget.isBangla ? 'রোগীর তথ্য' : 'Patient Information'),
                    _buildTextField(label: widget.isBangla ? 'রোগীর নাম *' : 'Patient Name *', controller: _nameController, hint: widget.isBangla ? 'রোগীর পূর্ণ নাম লিখুন' : 'Enter patient\'s full name'),
                    const SizedBox(height: 16),
                    _buildTextField(label: widget.isBangla ? 'রোগীর বয়স *' : 'Patient Age *', controller: _ageController, hint: widget.isBangla ? 'বয়স লিখুন (যেমন: ৩২)' : 'Enter age (e.g. 32)', keyboardType: TextInputType.number),
                    const SizedBox(height: 16),

                    _buildSectionTitle(widget.isBangla ? 'লিঙ্গ *' : 'Gender *'),
                    DropdownButtonFormField<String>(
                      decoration: _inputDecoration(widget.isBangla ? 'একটি নির্বাচন করুন' : 'Select one'),
                      items: [
                        widget.isBangla ? 'পুরুষ' : 'Male',
                        widget.isBangla ? 'মহিলা' : 'Female',
                        widget.isBangla ? 'অন্যান্য' : 'Others'
                      ].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                      onChanged: (val) => setState(() => _bookingData.gender = val),
                      validator: (val) => val == null ? widget.isBangla ? 'লিঙ্গ নির্বাচন করুন' : 'Please select gender' : null,
                    ),
                    const SizedBox(height: 16),

                    _buildSectionTitle(widget.isBangla ? 'জাতীয়তা *' : 'Nationality *'),
                    DropdownButtonFormField<String>(
                      decoration: _inputDecoration(widget.isBangla ? 'একটি নির্বাচন করুন' : 'Select one'),
                      items: [
                        widget.isBangla ? 'বাংলাদেশী' : 'Bangladeshi',
                        widget.isBangla ? 'অ-বাংলাদেশী' : 'Non-Bangladeshi'
                      ].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                      onChanged: (val) => setState(() => _bookingData.nationality = val),
                      validator: (val) => val == null ? widget.isBangla ? 'জাতীয়তা নির্বাচন করুন' : 'Please select nationality' : null,
                    ),
                    const SizedBox(height: 16),

                    _buildTextField(label: widget.isBangla ? 'মোবাইল নম্বর *' : 'Mobile Number *', controller: _mobileController, hint: '+880 XXXXXXXX', keyboardType: TextInputType.phone),
                    const SizedBox(height: 16),
                    _buildTextField(label: widget.isBangla ? 'ইমেইল *' : 'Email *', controller: _emailController, hint: 'your@email.com', keyboardType: TextInputType.emailAddress),
                    const SizedBox(height: 24),

                    _buildSectionTitle(widget.isBangla ? 'অতিরিক্ত তথ্য (যদি থাকে)' : 'Additional Notes (if any)'),
                    _buildTextField(label: '', controller: _notesController, hint: widget.isBangla ? 'যেকোনো বিশেষ নির্দেশনা' : 'Any special instructions', maxLines: 3, isRequired: false),
                    const SizedBox(height: 40),

                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: _submit,
                        style: FilledButton.styleFrom(
                          backgroundColor: CareOnApp.careOnGreen,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text(widget.isBangla ? 'বুকিং নিশ্চিত করুন' : 'Confirm Booking', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    if (title.isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF374151), fontSize: 14),
      ),
    );
  }

  Widget _buildTextField({required String label, required TextEditingController controller, required String hint, TextInputType? keyboardType, int maxLines = 1, bool isRequired = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) _buildSectionTitle(label),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: _inputDecoration(hint),
          validator: isRequired ? (v) => v!.isEmpty ? widget.isBangla ? 'এই ফিল্ডটি পূরণ করা আবশ্যিক' : 'This field is required' : null : null,
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
      filled: true,
      fillColor: const Color(0xFFF9FAFB),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  Widget _buildSelectionChip(String value, String label, bool isSelected, Function(String) onTap) {
    return GestureDetector(
      onTap: () => onTap(value),
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? CareOnApp.careOnGreen.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? CareOnApp.careOnGreen : Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isSelected ? CareOnApp.careOnGreen : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: isSelected ? CareOnApp.careOnGreen : Colors.grey.shade300),
              ),
              child: Center(
                child: Text(
                  value == 'Self' ? 'S' : 'O',
                  style: TextStyle(
                    color: isSelected ? Colors.white : CareOnApp.careOnGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: isSelected ? Colors.black : Colors.black87,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}