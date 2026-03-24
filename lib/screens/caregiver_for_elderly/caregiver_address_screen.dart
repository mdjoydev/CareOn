import 'package:flutter/material.dart';
import '../../main.dart';
import 'caregiver_booking_utils.dart';
import 'caregiver_review_screen.dart';

class CaregiverAddressScreen extends StatefulWidget {
  final bool isBangla;
  final BookingData bookingData;

  const CaregiverAddressScreen({
    super.key,
    required this.isBangla,
    required this.bookingData,
  });

  @override
  State<CaregiverAddressScreen> createState() => _CaregiverAddressScreenState();
}

class _CaregiverAddressScreenState extends State<CaregiverAddressScreen> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _countryController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emergencyController = TextEditingController();
  final _addressController = TextEditingController();
  final _infoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.bookingData.patientName ?? '';
    _ageController.text = widget.bookingData.age ?? '';
    _heightController.text = widget.bookingData.height ?? '';
    _weightController.text = widget.bookingData.weight ?? '';
    _countryController.text = widget.bookingData.country ?? '';
    _phoneController.text = widget.bookingData.contact ?? '';
    _emergencyController.text = widget.bookingData.emergencyContact ?? '';
    _addressController.text = widget.bookingData.address ?? '';
    _infoController.text = widget.bookingData.importantInfo ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _countryController.dispose();
    _phoneController.dispose();
    _emergencyController.dispose();
    _addressController.dispose();
    _infoController.dispose();
    super.dispose();
  }

  void _onNext() {
    widget.bookingData.patientName = _nameController.text;
    widget.bookingData.age = _ageController.text;
    widget.bookingData.height = _heightController.text;
    widget.bookingData.weight = _weightController.text;
    widget.bookingData.country = _countryController.text;
    widget.bookingData.contact = _phoneController.text;
    widget.bookingData.emergencyContact = _emergencyController.text;
    widget.bookingData.address = _addressController.text;
    widget.bookingData.importantInfo = _infoController.text;

    if (widget.bookingData.patientName!.isEmpty || widget.bookingData.contact!.isEmpty || widget.bookingData.address!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(widget.isBangla ? 'অনুগ্রহ করে সব তথ্য পূরণ করুন' : 'Please fill mandatory fields'))
      );
      return;
    }

    Navigator.of(context).push(MaterialPageRoute(builder: (_) => CaregiverReviewScreen(isBangla: widget.isBangla, bookingData: widget.bookingData)));
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
        title: const Text('Address', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          BookingStepIndicator(currentStep: 5),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const Text('Complete Address', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text('Provide detailed address information', style: TextStyle(color: Colors.grey, fontSize: 13)),
                const SizedBox(height: 24),
                
                _buildRadioSection('Booking For *', ['Self', 'Someone Else'], (val) => setState(() => widget.bookingData.isForSelf = val == 'Self')),
                const SizedBox(height: 20),
                
                Row(
                  children: [
                    Expanded(child: _buildInput('Patient Name *', _nameController, 'Enter patient name')),
                    const SizedBox(width: 16),
                    Expanded(child: _buildGender('Gender *')),
                  ],
                ),
                const SizedBox(height: 20),
                
                Row(
                  children: [
                    Expanded(child: _buildInput('Age *', _ageController, 'Age')),
                    const SizedBox(width: 16),
                    Expanded(child: _buildInput('Height * (Enter in feet and inches)', _heightController, 'e.g., 5 ft 8 in')),
                    const SizedBox(width: 16),
                    Expanded(child: _buildInput('Weight *', _weightController, 'Weight')),
                  ],
                ),
                const SizedBox(height: 20),
                
                Row(
                  children: [
                    Expanded(child: _buildSelect('Patient Type *', ['Bangladeshi', 'Foreigner'], (val) => setState(() => widget.bookingData.patientType = val))),
                    const SizedBox(width: 16),
                    Expanded(child: _buildInput('Country (If foreigner, please enter your country name)', _countryController, 'Enter country name')),
                  ],
                ),
                const SizedBox(height: 20),
                
                Row(
                  children: [
                    Expanded(child: _buildInput('Patient Contact *', _phoneController, '+880 1XXX-XXXXXX')),
                    const SizedBox(width: 16),
                    Expanded(child: _buildInput('Emergency Contact *', _emergencyController, '+880 1XXX-XXXXXX')),
                  ],
                ),
                const SizedBox(height: 20),
                
                _buildInput('Full Address *', _addressController, 'House/Flat number, Road, Block', maxLines: 2),
                const SizedBox(height: 20),
                
                Row(
                  children: [
                    Expanded(child: _buildSelect('Gender Preference', ['Male Nurse', 'Female Nurse'], (val) => setState(() => widget.bookingData.genderPreference = val))),
                    const SizedBox(width: 16),
                    Expanded(child: _buildSelect('Language Preference', ['Bengali', 'English', 'Both'], (val) => setState(() => widget.bookingData.languagePreference = val))),
                  ],
                ),
                const SizedBox(height: 20),
                
                _buildInput('Important Information (if any)', _infoController, 'Any medical conditions, allergies, or specific requirements...', maxLines: 3),
                const SizedBox(height: 40),
              ],
            ),
          ),
          _buildBottomNav(),
        ],
      ),
    );
  }

  Widget _buildInput(String label, TextEditingController controller, String hint, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
        ),
      ],
    );
  }

  Widget _buildRadioSection(String label, List<String> options, Function(String) onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        Row(
          children: options.map((opt) {
            return Row(
              children: [
                Radio<String>(
                  value: opt,
                  groupValue: widget.bookingData.isForSelf ? 'Self' : 'Someone Else',
                  activeColor: CareOnApp.careOnGreen,
                  onChanged: (val) {
                    if (val != null) onSelect(val);
                  },
                ),
                Text(opt, style: const TextStyle(fontSize: 13)),
                const SizedBox(width: 20),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildGender(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        const SizedBox(height: 8),
        Row(
          children: ['Male', 'Female', 'Others'].map((g) {
            final isSelected = widget.bookingData.gender == g;
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => widget.bookingData.gender = g),
                child: Container(
                  margin: const EdgeInsets.only(right: 4),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: isSelected ? CareOnApp.careOnGreen : Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(child: Text(g, style: TextStyle(fontSize: 11, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal))),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSelect(String label, List<String> options, Function(String) onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        const SizedBox(height: 8),
        Row(
          children: options.map((opt) {
            final isSelected = (label.contains('Preference') ? (label.contains('Gender') ? widget.bookingData.genderPreference : widget.bookingData.languagePreference) : widget.bookingData.patientType) == opt;
            return Expanded(
              child: GestureDetector(
                onTap: () => onSelect(opt),
                child: Container(
                  margin: const EdgeInsets.only(right: 4),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: isSelected ? CareOnApp.careOnGreen : Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(child: Text(opt, style: TextStyle(fontSize: 11, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal))),
                ),
              ),
            );
          }).toList(),
        ),
      ],
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
            onPressed: _onNext,
            style: FilledButton.styleFrom(backgroundColor: const Color(0xFF86EFAC), foregroundColor: const Color(0xFF166534), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}
