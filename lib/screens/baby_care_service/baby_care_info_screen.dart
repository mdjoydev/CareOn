import 'package:flutter/material.dart';
import 'baby_care_booking_utils.dart';
import 'baby_care_review_screen.dart';

class BabyCareInfoScreen extends StatefulWidget {
  final bool isBangla;
  final BabyCareBookingData bookingData;
  const BabyCareInfoScreen({super.key, required this.isBangla, required this.bookingData});

  @override
  State<BabyCareInfoScreen> createState() => _BabyCareInfoScreenState();
}

class _BabyCareInfoScreenState extends State<BabyCareInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  
  final _nameController = TextEditingController();
  String _selectedGender = 'Male';
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  String _patientType = 'Bangladeshi';
  final _countryController = TextEditingController();
  final _contactController = TextEditingController();
  final _emergencyContactController = TextEditingController();
  final _addressController = TextEditingController();
  String? _genderPreference;
  String? _languagePreference;
  final _importantInfoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.bookingData.babyName ?? '';
    _selectedGender = widget.bookingData.gender ?? 'Male';
    _ageController.text = widget.bookingData.age ?? '';
    _heightController.text = widget.bookingData.height ?? '';
    _weightController.text = widget.bookingData.weight ?? '';
    _patientType = widget.bookingData.patientType;
    _countryController.text = widget.bookingData.country ?? '';
    _contactController.text = widget.bookingData.contact ?? '';
    _emergencyContactController.text = widget.bookingData.emergencyContact ?? '';
    _addressController.text = widget.bookingData.address ?? '';
    _genderPreference = widget.bookingData.genderPreference;
    _languagePreference = widget.bookingData.languagePreference;
    _importantInfoController.text = widget.bookingData.importantInfo ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _countryController.dispose();
    _contactController.dispose();
    _emergencyContactController.dispose();
    _addressController.dispose();
    _importantInfoController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_formKey.currentState!.validate()) {
      widget.bookingData.babyName = _nameController.text;
      widget.bookingData.gender = _selectedGender;
      widget.bookingData.age = _ageController.text;
      widget.bookingData.height = _heightController.text;
      widget.bookingData.weight = _weightController.text;
      widget.bookingData.patientType = _patientType;
      widget.bookingData.country = _countryController.text;
      widget.bookingData.contact = _contactController.text;
      widget.bookingData.emergencyContact = _emergencyContactController.text;
      widget.bookingData.address = _addressController.text;
      widget.bookingData.genderPreference = _genderPreference;
      widget.bookingData.languagePreference = _languagePreference;
      widget.bookingData.importantInfo = _importantInfoController.text;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => BabyCareReviewScreen(
            isBangla: widget.isBangla,
            bookingData: widget.bookingData,
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
          widget.isBangla ? 'শিশুর তথ্য' : 'Baby Information',
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          BabyCareStepIndicator(currentStep: 4),
          Expanded(
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  _buildTextField(
                    label: widget.isBangla ? 'শিশুর নাম *' : 'Baby Name *',
                    controller: _nameController,
                    hint: widget.isBangla ? 'শিশুর নাম লিখুন' : 'Enter baby name',
                    validator: (v) => v!.isEmpty ? (widget.isBangla ? 'নাম লিখুন' : 'Enter name') : null,
                  ),
                  const SizedBox(height: 24),

                  _buildSectionTitle(widget.isBangla ? 'লিঙ্গ *' : 'Gender *'),
                  Row(
                    children: [
                      Expanded(child: _buildSelectionChip('Male', widget.isBangla ? 'ছেলে' : 'Male', _selectedGender == 'Male', (v) => setState(() => _selectedGender = 'Male'))),
                      const SizedBox(width: 8),
                      Expanded(child: _buildSelectionChip('Female', widget.isBangla ? 'মেয়ে' : 'Female', _selectedGender == 'Female', (v) => setState(() => _selectedGender = 'Female'))),
                    ],
                  ),
                  const SizedBox(height: 24),

                  _buildTextField(
                    label: widget.isBangla ? 'বয়স *' : 'Age *',
                    controller: _ageController,
                    hint: widget.isBangla ? 'বয়স' : 'Age',
                    keyboardType: TextInputType.text,
                    validator: (v) => v!.isEmpty ? (widget.isBangla ? 'বয়স লিখুন' : 'Enter age') : null,
                  ),
                  const SizedBox(height: 24),

                  _buildTextField(
                    label: widget.isBangla ? 'উচ্চতা * (ঐচ্ছিক)' : 'Height * (Optional)',
                    controller: _heightController,
                    hint: widget.isBangla ? 'যেমন: ২ ফুট' : 'e.g., 2 ft',
                  ),
                  const SizedBox(height: 24),

                  _buildTextField(
                    label: widget.isBangla ? 'ওজন * (ঐচ্ছিক)' : 'Weight * (Optional)',
                    controller: _weightController,
                    hint: widget.isBangla ? 'ওজন' : 'Weight',
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 24),

                  _buildSectionTitle(widget.isBangla ? 'জাতীয়তা *' : 'Nationality *'),
                  Row(
                    children: [
                      Expanded(child: _buildSelectionChip('Bangladeshi', widget.isBangla ? 'বাংলাদেশী' : 'Bangladeshi', _patientType == 'Bangladeshi', (v) => setState(() => _patientType = 'Bangladeshi'))),
                      const SizedBox(width: 12),
                      Expanded(child: _buildSelectionChip('Foreigner', widget.isBangla ? 'বিদেশী' : 'Foreigner', _patientType == 'Foreigner', (v) => setState(() => _patientType = 'Foreigner'))),
                    ],
                  ),
                  if (_patientType == 'Foreigner') ...[
                    const SizedBox(height: 24),
                    _buildTextField(
                      label: widget.isBangla ? 'দেশ' : 'Country',
                      controller: _countryController,
                      hint: widget.isBangla ? 'দেশের নাম লিখুন' : 'Enter country name',
                      validator: (v) => _patientType == 'Foreigner' && v!.isEmpty ? (widget.isBangla ? 'দেশের নাম লিখুন' : 'Enter country name') : null,
                    ),
                  ],
                  const SizedBox(height: 24),

                  _buildTextField(
                    label: widget.isBangla ? 'যোগাযোগ নম্বর *' : 'Contact Number *',
                    controller: _contactController,
                    hint: '+880 1XXX-XXXXXX',
                    keyboardType: TextInputType.phone,
                    validator: (v) => v!.isEmpty ? (widget.isBangla ? 'নম্বর লিখুন' : 'Enter contact') : null,
                  ),
                  const SizedBox(height: 24),

                  _buildTextField(
                    label: widget.isBangla ? 'জরুরী যোগাযোগ নম্বর *' : 'Emergency Contact *',
                    controller: _emergencyContactController,
                    hint: '+880 1XXX-XXXXXX',
                    keyboardType: TextInputType.phone,
                    validator: (v) => v!.isEmpty ? (widget.isBangla ? 'জরুরী নম্বর লিখুন' : 'Enter emergency contact') : null,
                  ),
                  const SizedBox(height: 24),

                  _buildTextField(
                    label: widget.isBangla ? 'পুরো ঠিকানা *' : 'Full Address *',
                    controller: _addressController,
                    hint: widget.isBangla ? 'বাসা/ফ্ল্যাট নম্বর, রাস্তা, ব্লক' : 'House/Flat number, Road, Block',
                    maxLines: 2,
                    validator: (v) => v!.isEmpty ? (widget.isBangla ? 'ঠিকানা লিখুন' : 'Enter address') : null,
                  ),
                  const SizedBox(height: 24),

                  _buildSectionTitle(widget.isBangla ? 'ন্যানি পছন্দ' : 'Nanny Preference'),
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      _buildSelectionChip('Male', widget.isBangla ? 'পুরুষ' : 'Male', _genderPreference == 'Male', (v) => setState(() => _genderPreference = 'Male')),
                      _buildSelectionChip('Female', widget.isBangla ? 'মহিলা' : 'Female', _genderPreference == 'Female', (v) => setState(() => _genderPreference = 'Female')),
                    ],
                  ),
                  const SizedBox(height: 24),

                  _buildSectionTitle(widget.isBangla ? 'ভাষা পছন্দ' : 'Language Preference'),
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      _buildSelectionChip('Bengali', widget.isBangla ? 'বাংলা' : 'Bengali', _languagePreference == 'Bengali', (v) => setState(() => _languagePreference = 'Bengali')),
                      _buildSelectionChip('English', widget.isBangla ? 'ইংরেজি' : 'English', _languagePreference == 'English', (v) => setState(() => _languagePreference = 'English')),
                      _buildSelectionChip('Both', widget.isBangla ? 'উভয়' : 'Both', _languagePreference == 'Both', (v) => setState(() => _languagePreference = 'Both')),
                    ],
                  ),
                  const SizedBox(height: 24),

                  _buildTextField(
                    label: widget.isBangla ? 'গুরুত্বপূর্ণ তথ্য (যদি থাকে)' : 'Important Information (if any)',
                    controller: _importantInfoController,
                    hint: widget.isBangla ? 'অ্যালার্জি, নির্দিষ্ট রুটিন বা প্রয়োজনীয়তা...' : 'Allergies, specific routine or requirements...',
                    maxLines: 3,
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(
                      widget.isBangla ? 'পেছনে' : 'Back',
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FilledButton(
                    onPressed: _onNext,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
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
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF374151), fontSize: 14),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF374151), fontSize: 14)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
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
          border: Border.all(color: isSelected ? const Color(0xFF059669) : const Color(0xFFF3F4F6)),
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
}
