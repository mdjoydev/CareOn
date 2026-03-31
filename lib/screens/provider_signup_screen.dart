import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ProviderSignupScreen extends StatefulWidget {
  final bool isBangla;
  const ProviderSignupScreen({super.key, this.isBangla = false});

  @override
  State<ProviderSignupScreen> createState() => _ProviderSignupScreenState();
}

class _ProviderSignupScreenState extends State<ProviderSignupScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _dobController = TextEditingController();
  final _nidController = TextEditingController();
  final _presentAddressController = TextEditingController();
  final _permanentAddressController = TextEditingController();
  final _qualificationController = TextEditingController();

  String? _selectedGender;
  String? _selectedCategory;
  String? _selectedExperience;
  String? _selectedStatus;
  
  final List<String> _selectedLanguages = [];
  String? _selectedAvailability;
  bool _agreedToTerms = false;

  File? _nidFile;
  File? _licenseFile;
  File? _trainingFile;
  File? _policeFile;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(String type) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        if (type == 'nid') _nidFile = File(image.path);
        if (type == 'license') _licenseFile = File(image.path);
        if (type == 'training') _trainingFile = File(image.path);
        if (type == 'police') _policeFile = File(image.path);
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _nidController.dispose();
    _presentAddressController.dispose();
    _permanentAddressController.dispose();
    _qualificationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.isBangla ? 'সেবা প্রদানকারী হিসেবে যোগ দিন' : 'Join as a Care Provider',
          style: GoogleFonts.inter(color: const Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildWhyChooseSection(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader(
                      widget.isBangla ? 'আবেদন ফর্ম' : 'Application Form',
                      widget.isBangla ? 'অনুমোদনের আগে সব তথ্য যাচাই করা হবে' : 'All information will be verified before approval',
                    ),
                    const SizedBox(height: 24),
                    
                    _buildSubHeader(widget.isBangla ? 'ব্যক্তিগত তথ্য' : 'Personal Information'),
                    const SizedBox(height: 16),
                    _buildLabel(widget.isBangla ? 'পূর্ণ নাম *' : 'Full Name*', subtitle: 'As per NID'),
                    _buildTextField(_nameController, widget.isBangla ? 'আপনার নাম' : 'John Doe'),
                    
                    _buildLabel(widget.isBangla ? 'ফোন নম্বর *' : 'Personal Number*'),
                    _buildTextField(_phoneController, '+880 1XXX-XXXXXX', keyboardType: TextInputType.phone),
                    
                    _buildLabel(widget.isBangla ? 'ইমেইল *' : 'Email*'),
                    _buildTextField(_emailController, 'example@email.com', keyboardType: TextInputType.emailAddress),
                    
                    _buildLabel(widget.isBangla ? 'জন্ম তারিখ *' : 'Date of Birth*'),
                    _buildTextField(_dobController, 'mm/dd/yyyy', isReadOnly: true, onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
                        firstDate: DateTime(1950),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _dobController.text = "${pickedDate.month}/${pickedDate.day}/${pickedDate.year}";
                        });
                      }
                    }),
                    
                    _buildLabel(widget.isBangla ? 'লিঙ্গ *' : 'Gender*'),
                    _buildDropdown(
                      value: _selectedGender,
                      items: widget.isBangla ? ['পুরুষ', 'মহিলা', 'অন্যান্য'] : ['Male', 'Female', 'Others'],
                      hint: '-- Select one --',
                      onChanged: (val) => setState(() => _selectedGender = val),
                    ),
                    
                    _buildLabel(widget.isBangla ? 'NID/জন্ম নিবন্ধন নম্বর *' : 'NID/Birth Certificate Number*'),
                    _buildTextField(_nidController, 'NID/Birth Certificate Number'),
                    
                    _buildLabel(widget.isBangla ? 'বর্তমান ঠিকানা *' : 'Present Address*'),
                    _buildTextField(_presentAddressController, '', maxLines: 3),
                    
                    _buildLabel(widget.isBangla ? 'স্থায়ী ঠিকানা *' : 'Permanent Address*'),
                    _buildTextField(_permanentAddressController, '', maxLines: 3),
                    
                    const SizedBox(height: 32),
                    _buildSubHeader(widget.isBangla ? 'পেশাগত তথ্য' : 'Professional Information'),
                    const SizedBox(height: 16),
                    
                    _buildLabel(widget.isBangla ? 'সেবা বিভাগ *' : 'Service Category *'),
                    _buildDropdown(
                      value: _selectedCategory,
                      items: widget.isBangla 
                        ? [
                            'নার্সিং কেয়ার', 
                            'ডাক্তার', 
                            'ফিজিওথেরাপি', 
                            'ন্যানি ও শিশু যত্ন', 
                            'বয়স্ক যত্ন', 
                            'রোগী সেবক', 
                            'প্যারামেডিক'
                          ] 
                        : [
                            'Nursing Care', 
                            'Doctor', 
                            'Physiotherapy', 
                            'Nanny & Baby Care', 
                            'Elderly Care', 
                            'Patient Attendant', 
                            'Paramedic'
                          ],
                      hint: '-- Select one --',
                      onChanged: (val) => setState(() => _selectedCategory = val),
                    ),
                    
                    _buildLabel(widget.isBangla ? 'অভিজ্ঞতা *' : 'Years of Experience*'),
                    _buildDropdown(
                      value: _selectedExperience,
                      items: [
                        '0-1 years',
                        '1-3 years',
                        '3-5 years',
                        '5-10 years',
                        '10+ years'
                      ],
                      hint: '-- Select one --',
                      onChanged: (val) => setState(() => _selectedExperience = val),
                    ),
                    
                    _buildLabel(widget.isBangla ? 'সর্বোচ্চ শিক্ষাগত যোগ্যতা *' : 'Highest Qualification*'),
                    _buildTextField(_qualificationController, 'e.g., B.Sc in Nursing'),
                    
                    _buildLabel('Status*'),
                    Row(
                      children: [
                        _buildRadioTile('Completed', _selectedStatus, (val) => setState(() => _selectedStatus = val)),
                        _buildRadioTile('Running', _selectedStatus, (val) => setState(() => _selectedStatus = val)),
                      ],
                    ),
                    
                    _buildLabel(widget.isBangla ? 'ভাষা *' : 'Languages Spoken *'),
                    _buildCheckboxTile('English | ইংরেজি', _selectedLanguages),
                    _buildCheckboxTile('বাংলা | Bengali', _selectedLanguages),
                    _buildCheckboxTile('Others | অন্যান্য', _selectedLanguages),
                    
                    const SizedBox(height: 32),
                    _buildSubHeader(widget.isBangla ? 'ডকুমেন্ট আপলোড' : 'Document Upload'),
                    const SizedBox(height: 16),
                    
                    _buildFileUploadTile(
                      widget.isBangla ? 'NID/জন্ম নিবন্ধন (সামনে এবং পিছনে)*' : 'NID/Birth Certificate (Front & Back)*',
                      _nidFile,
                      () => _pickImage('nid'),
                    ),
                    _buildFileUploadTile(
                      widget.isBangla ? 'রেজিস্ট্রেশন নম্বর/লাইসেন্স নম্বর (ঐচ্ছিক)' : 'Registration NO./License NO. (Optional)',
                      _licenseFile,
                      () => _pickImage('license'),
                    ),
                    _buildFileUploadTile(
                      widget.isBangla ? 'প্রশিক্ষণ সার্টিফিকেট (ঐচ্ছিক)' : 'Training Certificates (Optional)',
                      _trainingFile,
                      () => _pickImage('training'),
                    ),
                    _buildFileUploadTile(
                      widget.isBangla ? 'পুলিশ ক্লিয়ারেন্স (ঐচ্ছিক)' : 'Police Clearance (Optional)',
                      _policeFile,
                      () => _pickImage('police'),
                    ),
                    
                    const SizedBox(height: 32),
                    _buildSubHeader(widget.isBangla ? 'সময়সূচী' : 'Availability'),
                    const SizedBox(height: 8),
                    Text(
                      widget.isBangla ? 'কখন আপনি সেবা দিতে পারবেন?' : 'When can you provide services?',
                      style: GoogleFonts.inter(fontSize: 14, color: const Color(0xFF64748B)),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      children: [
                        _buildSingleSelectChip(widget.isBangla ? 'পূর্ণকালীন' : 'Full-time'),
                        _buildSingleSelectChip(widget.isBangla ? 'খণ্ডকালীন' : 'Part-time'),
                        _buildSingleSelectChip(widget.isBangla ? 'সাপ্তাহান্তে' : 'Weekends'),
                        _buildSingleSelectChip(widget.isBangla ? 'জরুরি' : 'Emergency'),
                      ],
                    ),
                    
                    const SizedBox(height: 32),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Checkbox(
                            value: _agreedToTerms,
                            activeColor: const Color(0xFF00A66C),
                            onChanged: (val) => setState(() => _agreedToTerms = val!),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            widget.isBangla
                              ? "আমি CareOn-এর পরিষেবার শর্তাবলী, আচরণবিধি এবং গোপনীয়তা নীতিতে সম্মত। আমি বুঝি যে সমস্ত তথ্য যাচাই করা হবে এবং অতিরিক্ত ডকুমেন্টেশন বা ইন্টারভিউয়ের জন্য আমার সাথে যোগাযোগ করা হতে পারে। *"
                              : "I agree to CareOn's Terms of Service, Code of Conduct, and Privacy Policy. I understand that all information will be verified and I may be contacted for additional documentation or interviews. *",
                            style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF475569), height: 1.5),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 40),
                    _buildSubmitButton(),
                    const SizedBox(height: 16),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            widget.isBangla ? 'আবেদন প্রক্রিয়া সাধারণত ৩–৫ কর্মদিবস সময় নেয়' : 'Application processing typically takes 3–5 business days',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF64748B)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWhyChooseSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.isBangla ? 'কেন CareOn বেছে নেবেন?' : 'Why Choose CareOn?',
            style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w800, color: const Color(0xFF0F172A)),
          ),
          const SizedBox(height: 24),
          _buildBenefitItem(
            Icons.account_balance_wallet_outlined,
            widget.isBangla ? 'নমনীয় আয়' : 'Flexible Income',
            widget.isBangla ? 'আপনার প্রাপ্যতা এবং দক্ষতার উপর ভিত্তি করে উপার্জন করুন' : 'Earn based on your availability and skills',
          ),
          _buildBenefitItem(
            Icons.security_outlined,
            widget.isBangla ? 'নিরাপত্তা ও সহায়তা' : 'Safety & Support',
            widget.isBangla ? '২৪/৭ সহায়তা এবং বীমা কভারেজ' : '24/7 support and insurance coverage',
          ),
          _buildBenefitItem(
            Icons.trending_up_outlined,
            widget.isBangla ? 'পেশাগত বৃদ্ধি' : 'Professional Growth',
            widget.isBangla ? 'প্রশিক্ষণ এবং সার্টিফিকেশন সুযোগ' : 'Training and certification opportunities',
          ),
          _buildBenefitItem(
            Icons.event_available_outlined,
            widget.isBangla ? 'কর্ম-জীবন ভারসাম্য' : 'Work-Life Balance',
            widget.isBangla ? 'আপনার নিজস্ব সময়সূচী এবং কাজের চাপ চয়ন করুন' : 'Choose your own schedule and workload',
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(IconData icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: const Color(0xFFF0FDF4), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: const Color(0xFF00A66C), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A))),
                const SizedBox(height: 4),
                Text(description, style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF64748B))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w800, color: const Color(0xFF0F172A))),
        const SizedBox(height: 4),
        Text(subtitle, style: GoogleFonts.inter(fontSize: 14, color: const Color(0xFF64748B))),
      ],
    );
  }

  Widget _buildSubHeader(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1))),
      child: Row(
        children: [
          Text(title, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A))),
        ],
      ),
    );
  }

  Widget _buildLabel(String text, {String? subtitle}) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text, style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14, color: const Color(0xFF334155))),
          if (subtitle != null) ...[
            const SizedBox(height: 2),
            Text(subtitle, style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF94A3B8))),
          ],
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {TextInputType keyboardType = TextInputType.text, int maxLines = 1, bool isReadOnly = false, VoidCallback? onTap}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      readOnly: isReadOnly,
      onTap: onTap,
      style: GoogleFonts.inter(fontSize: 15, color: const Color(0xFF0F172A)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 13),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF00A66C), width: 1.5)),
      ),
    );
  }

  Widget _buildDropdown({required String? value, required List<String> items, required String hint, required Function(String?) onChanged}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFE2E8F0))),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(hint, style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 13)),
          isExpanded: true,
          items: items.map((String item) {
            return DropdownMenuItem<String>(value: item, child: Text(item, style: GoogleFonts.inter(fontSize: 15)));
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildRadioTile(String label, String? groupValue, Function(String?) onChanged) {
    return Expanded(
      child: Row(
        children: [
          // ignore: deprecated_member_use
          Radio<String>(
            value: label,
            // ignore: deprecated_member_use
            groupValue: groupValue,
            activeColor: const Color(0xFF00A66C),
            // ignore: deprecated_member_use
            onChanged: onChanged,
          ),
          Text(label, style: GoogleFonts.inter(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildCheckboxTile(String label, List<String> selectedList) {
    bool isSelected = selectedList.contains(label);
    return CheckboxListTile(
      title: Text(label, style: GoogleFonts.inter(fontSize: 14)),
      value: isSelected,
      activeColor: const Color(0xFF00A66C),
      dense: true,
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (val) {
        setState(() {
          if (val!) {
            selectedList.add(label);
          } else {
            selectedList.remove(label);
          }
        });
      },
    );
  }

  Widget _buildFileUploadTile(String label, File? selectedFile, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: selectedFile != null ? const Color(0xFF00A66C) : const Color(0xFFE2E8F0),
                style: BorderStyle.solid,
              ),
            ),
            child: Column(
              children: [
                Icon(
                  selectedFile != null ? Icons.check_circle_outline : Icons.cloud_upload_outlined,
                  color: const Color(0xFF00A66C),
                  size: 32,
                ),
                const SizedBox(height: 8),
                Text(
                  selectedFile != null
                      ? (widget.isBangla ? 'ডকুমেন্ট আপলোড হয়েছে' : 'Document Uploaded')
                      : (widget.isBangla ? 'আপলোড করতে এখানে ক্লিক করুন' : 'Click here to upload'),
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF00A66C),
                  ),
                ),
                if (selectedFile != null) ...[
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      selectedFile.path.split('/').last,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF64748B)),
                    ),
                  ),
                ] else ...[
                  const SizedBox(height: 4),
                  Text('PNG, JPG or Webp (max 5MB)', style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF94A3B8))),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSingleSelectChip(String label) {
    bool isSelected = _selectedAvailability == label;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (val) {
        setState(() {
          _selectedAvailability = val ? label : null;
        });
      },
      selectedColor: const Color(0xFF00A66C).withValues(alpha: 0.1),
      labelStyle: GoogleFonts.inter(
        fontSize: 13,
        color: isSelected ? const Color(0xFF00A66C) : const Color(0xFF475569),
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: isSelected ? const Color(0xFF00A66C) : const Color(0xFFE2E8F0)),
      ),
      showCheckmark: false,
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00A66C).withValues(alpha: 0.2),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Submit logic
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(widget.isBangla ? 'আবেদন জমা দেওয়া হয়েছে!' : 'Application Submitted!'),
                backgroundColor: const Color(0xFF00A66C),
              ),
            );
            Navigator.pop(context);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00A66C),
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 58),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
        child: Text(
          widget.isBangla ? 'আবেদন জমা দিন' : 'Submit Application',
          style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
