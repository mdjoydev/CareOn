import 'package:flutter/material.dart';
import '../../main.dart';
import 'ambulance_booking_utils.dart';
import 'ambulance_success_screen.dart';

class AmbulanceBookingScreen extends StatefulWidget {
  final bool isBangla;
  const AmbulanceBookingScreen({super.key, required this.isBangla});

  @override
  State<AmbulanceBookingScreen> createState() => _AmbulanceBookingScreenState();
}

class _AmbulanceBookingScreenState extends State<AmbulanceBookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final AmbulanceBookingData _bookingData = AmbulanceBookingData();
  
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactPersonController = TextEditingController();
  final _mobileController = TextEditingController();
  final _pickupController = TextEditingController();
  final _destinationController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _contactPersonController.dispose();
    _mobileController.dispose();
    _pickupController.dispose();
    _destinationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (time != null) {
        setState(() {
          _bookingData.pickupDateTime = DateTime(
            date.year, date.month, date.day, time.hour, time.minute
          );
        });
      }
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      if (_bookingData.pickupDateTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select pickup date and time')),
        );
        return;
      }
      
      _bookingData.patientName = _nameController.text;
      _bookingData.patientAge = _ageController.text;
      _bookingData.email = _emailController.text;
      _bookingData.contactPerson = _contactPersonController.text;
      _bookingData.mobileNumber = _mobileController.text;
      _bookingData.pickupAddress = _pickupController.text;
      _bookingData.destinationAddress = _destinationController.text;
      _bookingData.additionalNotes = _notesController.text;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => AmbulanceSuccessScreen(
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
          widget.isBangla ? 'অ্যাম্বুলেন্স সাপোর্ট' : 'Ambulance Support',
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const AmbulanceStepIndicator(currentStep: 1),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ambulance Support',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'ICU / NICU / AIR / Freezer Van / AC / Non-AC',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Hire an Ambulance',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Fields marked with * are required.',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                    const SizedBox(height: 24),

                    _buildSectionTitle('Booking For *'),
                    Row(
                      children: [
                        Expanded(child: _buildSelectionChip('Self', 'Self', _bookingData.isForSelf, (v) => setState(() => _bookingData.isForSelf = true))),
                        const SizedBox(width: 12),
                        Expanded(child: _buildSelectionChip('Someone Else', 'Someone Else', !_bookingData.isForSelf, (v) => setState(() => _bookingData.isForSelf = false))),
                      ],
                    ),
                    const SizedBox(height: 24),

                    _buildSectionTitle('Patient Information'),
                    _buildTextField(label: 'Patient Name *', controller: _nameController, hint: 'Enter patient name'),
                    const SizedBox(height: 16),
                    _buildTextField(label: 'Patient Age *', controller: _ageController, hint: 'Enter age (e.g. 32)', keyboardType: TextInputType.number),
                    const SizedBox(height: 16),
                    
                    _buildSectionTitle('Gender *'),
                    DropdownButtonFormField<String>(
                      decoration: _inputDecoration('Select one'),
                      items: ['Male', 'Female', 'Others'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                      onChanged: (val) => setState(() => _bookingData.gender = val),
                      validator: (val) => val == null ? 'Please select gender' : null,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(label: 'Email Address *', controller: _emailController, hint: 'Email Address', keyboardType: TextInputType.emailAddress),
                    const SizedBox(height: 16),
                    
                    _buildSectionTitle('Nationality *'),
                    DropdownButtonFormField<String>(
                      decoration: _inputDecoration('Select one'),
                      items: ['Bangladeshi', 'Non-Bangladeshi'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                      onChanged: (val) => setState(() => _bookingData.nationality = val),
                      validator: (val) => val == null ? 'Please select nationality' : null,
                    ),
                    const SizedBox(height: 24),

                    _buildSectionTitle('Contact Details'),
                    _buildTextField(label: 'Contact Person *', controller: _contactPersonController, hint: 'Full name'),
                    const SizedBox(height: 16),
                    _buildTextField(label: 'Mobile Number *', controller: _mobileController, hint: '+880 XXXXXXXX', keyboardType: TextInputType.phone),
                    const SizedBox(height: 24),

                    _buildSectionTitle('Pickup & Destination'),
                    _buildTextField(label: 'Pickup Address *', controller: _pickupController, hint: 'Pickup location'),
                    const SizedBox(height: 16),
                    _buildTextField(label: 'Destination Address *', controller: _destinationController, hint: 'Hospital or destination'),
                    const SizedBox(height: 24),

                    _buildSectionTitle('Ambulance Details'),
                    _buildSectionTitle('Ambulance Type *'),
                    DropdownButtonFormField<String>(
                      decoration: _inputDecoration('Select one'),
                      items: ['ICU', 'NICU', 'AC', 'Air Ambulance', 'Freezer Van', 'Non-AC'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                      onChanged: (val) => setState(() => _bookingData.ambulanceType = val),
                      validator: (val) => val == null ? 'Please select ambulance type' : null,
                    ),
                    const SizedBox(height: 16),
                    
                    _buildSectionTitle('Booking Type *'),
                    DropdownButtonFormField<String>(
                      decoration: _inputDecoration('Select one'),
                      items: [
                        DropdownMenuItem(value: 'For emergency', child: Text(widget.isBangla ? 'জরুরী প্রয়োজনে' : 'For emergency')),
                        DropdownMenuItem(value: 'For advance booking', child: Text(widget.isBangla ? 'আগাম বুকিংয়ের জন্য' : 'For advance booking')),
                      ],
                      onChanged: (val) => setState(() => _bookingData.bookingType = val),
                      validator: (val) => val == null ? 'Please select booking type' : null,
                    ),
                    const SizedBox(height: 16),

                    _buildSectionTitle('Pickup Date & Time *'),
                    InkWell(
                      onTap: _selectDateTime,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today, color: CareOnApp.careOnGreen, size: 20),
                            const SizedBox(width: 12),
                            Text(
                              _bookingData.pickupDateTime == null 
                                ? 'Select Date & Time' 
                                : '${_bookingData.pickupDateTime!.day}/${_bookingData.pickupDateTime!.month}/${_bookingData.pickupDateTime!.year} ${_bookingData.pickupDateTime!.hour}:${_bookingData.pickupDateTime!.minute}',
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    _buildSectionTitle('Additional Services (if required)'),
                    _buildAdditionalServiceRadio('CG', 'Care Giver'),
                    _buildAdditionalServiceRadio('N', 'Nurse'),
                    _buildAdditionalServiceRadio('A', 'Patient Attendant'),
                    const SizedBox(height: 24),

                    _buildSectionTitle('Additional Notes (if any)'),
                    _buildTextField(label: '', controller: _notesController, hint: 'Any special instructions', maxLines: 3, isRequired: false),
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
                        child: const Text('Confirm Booking', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
          validator: isRequired ? (v) => v!.isEmpty ? 'This field is required' : null : null,
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFECFDF5) : const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? CareOnApp.careOnGreen : const Color(0xFFF3F4F6)),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? const Color(0xFF065F46) : const Color(0xFF374151),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAdditionalServiceRadio(String code, String name) {
    final isSelected = _bookingData.selectedAdditionalService == name;
    return InkWell(
      onTap: () {
        setState(() {
          _bookingData.selectedAdditionalService = isSelected ? null : name;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? CareOnApp.careOnGreen.withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? CareOnApp.careOnGreen : Colors.grey.shade200),
        ),
        child: Row(
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
                  code,
                  style: TextStyle(
                    color: isSelected ? Colors.white : CareOnApp.careOnGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              name,
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? Colors.black : Colors.black87,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
