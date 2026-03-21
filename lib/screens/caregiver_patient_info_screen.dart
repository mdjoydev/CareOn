import 'package:flutter/material.dart';
import 'caregiver_booking_utils.dart';
import '../main.dart';
import 'caregiver_address_screen.dart';

class CaregiverPatientInfoScreen extends StatefulWidget {
  final bool isBangla;
  final String location;
  final BookingData bookingData;
  const CaregiverPatientInfoScreen({super.key, required this.isBangla, required this.location, required this.bookingData});

  @override
  State<CaregiverPatientInfoScreen> createState() => _CaregiverPatientInfoScreenState();
}

class _CaregiverPatientInfoScreenState extends State<CaregiverPatientInfoScreen> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  String _selectedGender = 'Male';
  String _selectedRelation = 'Parent';

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_nameController.text.isEmpty || _ageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(widget.isBangla ? 'অনুগ্রহ করে সব তথ্য পূরণ করুন' : 'Please fill all details')),
      );
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CaregiverAddressScreen(
          isBangla: widget.isBangla,
          bookingData: widget.bookingData,
        ),
      ),
    );
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
          widget.isBangla ? 'রোগীর তথ্য' : 'Patient Information',
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                _buildTextField(
                  label: widget.isBangla ? 'রোগীর নাম' : 'Patient Name',
                  controller: _nameController,
                  hint: widget.isBangla ? 'নাম লিখুন' : 'Enter full name',
                ),
                const SizedBox(height: 24),
                _buildTextField(
                  label: widget.isBangla ? 'বয়স' : 'Age',
                  controller: _ageController,
                  hint: widget.isBangla ? 'বয়স লিখুন' : 'Enter age',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 24),
                Text(
                  widget.isBangla ? 'লিঙ্গ' : 'Gender',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF374151)),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildSelectionChip('Male', widget.isBangla ? 'পুরুষ' : 'Male'),
                    const SizedBox(width: 12),
                    _buildSelectionChip('Female', widget.isBangla ? 'মহিলা' : 'Female'),
                    const SizedBox(width: 12),
                    _buildSelectionChip('Other', widget.isBangla ? 'অন্যান্য' : 'Other'),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  widget.isBangla ? 'সম্পর্ক' : 'Relationship',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF374151)),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _buildRelationChip('Parent', widget.isBangla ? 'বাবা/মা' : 'Parent'),
                    _buildRelationChip('Spouse', widget.isBangla ? 'স্বামী/স্ত্রী' : 'Spouse'),
                    _buildRelationChip('Self', widget.isBangla ? 'নিজে' : 'Self'),
                    _buildRelationChip('Other', widget.isBangla ? 'অন্যান্য' : 'Other'),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: FilledButton(
              onPressed: _onNext,
              child: Text(widget.isBangla ? 'পরবর্তী' : 'Next Step'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({required String label, required TextEditingController controller, required String hint, TextInputType? keyboardType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF374151))),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectionChip(String value, String label) {
    final isSelected = _selectedGender == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedGender = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFECFDF5) : const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? CareOnApp.careOnGreen : const Color(0xFFF3F4F6)),
        ),
        child: Text(
          label,
          style: TextStyle(color: isSelected ? const Color(0xFF065F46) : const Color(0xFF374151), fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
        ),
      ),
    );
  }

  Widget _buildRelationChip(String value, String label) {
    final isSelected = _selectedRelation == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedRelation = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFECFDF5) : const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? CareOnApp.careOnGreen : const Color(0xFFF3F4F6)),
        ),
        child: Text(
          label,
          style: TextStyle(color: isSelected ? const Color(0xFF065F46) : const Color(0xFF374151), fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
        ),
      ),
    );
  }
}
