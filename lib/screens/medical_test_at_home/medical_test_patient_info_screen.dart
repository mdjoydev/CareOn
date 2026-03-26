import 'package:flutter/material.dart';
import 'medical_test_booking_utils.dart';
import 'medical_test_success_screen.dart';

class MedicalTestPatientInfoScreen extends StatefulWidget {
  final bool isBangla;
  final MedicalTestBookingData bookingData;

  const MedicalTestPatientInfoScreen({
    super.key,
    required this.isBangla,
    required this.bookingData,
  });

  @override
  State<MedicalTestPatientInfoScreen> createState() => _MedicalTestPatientInfoScreenState();
}

class _MedicalTestPatientInfoScreenState extends State<MedicalTestPatientInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _nameController;
  late TextEditingController _mobileController;
  late TextEditingController _emailController;
  late TextEditingController _ageController;
  late TextEditingController _addressController;
  late TextEditingController _instructionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.bookingData.fullName);
    _mobileController = TextEditingController(text: widget.bookingData.mobileNumber);
    _emailController = TextEditingController(text: widget.bookingData.email);
    _ageController = TextEditingController(text: widget.bookingData.age);
    _addressController = TextEditingController(text: widget.bookingData.address);
    _instructionController = TextEditingController(text: widget.bookingData.specialInstructions);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    _addressController.dispose();
    _instructionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.bookingData.preferredDate ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null && picked != widget.bookingData.preferredDate) {
      setState(() {
        widget.bookingData.preferredDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF00A66C);

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
          widget.isBangla ? 'মেডিকেল টেস্ট অ্যাট হোম' : 'Medical Test At Home',
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const MedicalTestStepIndicator(currentStep: 3),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.isBangla ? 'রোগীর তথ্য' : 'Patient Information',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.isBangla ? 'অনুগ্রহ করে নিচের ফর্মটি আপনার বিস্তারিত তথ্য দিয়ে পূরণ করুন' : 'Please fill up the below form with your detail',
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
                    ),
                    const SizedBox(height: 16),
                    
                    // Booking For
                    Text(widget.isBangla ? 'বুকিং কার জন্য *' : 'Booking For *', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => widget.bookingData.isForSelf = true),
                          child: Row(
                            children: [
                              Icon(
                                widget.bookingData.isForSelf ? Icons.check_circle : Icons.circle_outlined,
                                size: 20,
                                color: primaryGreen,
                              ),
                              const SizedBox(width: 8),
                              Text(widget.isBangla ? 'নিজে' : 'Self', style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: () => setState(() => widget.bookingData.isForSelf = false),
                          child: Row(
                            children: [
                              Icon(
                                !widget.bookingData.isForSelf ? Icons.check_circle : Icons.circle_outlined,
                                size: 20,
                                color: primaryGreen,
                              ),
                              const SizedBox(width: 8),
                              Text(widget.isBangla ? 'অন্য কেউ' : 'Someone Else', style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 12),
                    // Full Name
                    _buildTextField(
                      label: widget.isBangla ? 'পুরো নাম *' : 'Full Name *',
                      controller: _nameController,
                      hint: widget.isBangla ? 'আপনার নাম লিখুন' : 'Enter full name',
                      onChanged: (val) => widget.bookingData.fullName = val,
                    ),
                    
                    const SizedBox(height: 12),
                    // Nationality & Mobile
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.isBangla ? 'জাতীয়তা *' : 'Nationality *', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: widget.bookingData.nationality,
                                    isExpanded: true,
                                    items: ['Bangladeshi', 'Other'].map((String value) {
                                      return DropdownMenuItem<String>(value: value, child: Text(value, style: const TextStyle(fontSize: 12)));
                                    }).toList(),
                                    onChanged: (val) => setState(() => widget.bookingData.nationality = val!),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildTextField(
                            label: widget.isBangla ? 'মোবাইল নম্বর *' : 'Mobile Number *',
                            controller: _mobileController,
                            hint: '01XXXXXXXXX',
                            onChanged: (val) => widget.bookingData.mobileNumber = val,
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 12),
                    // Email
                    _buildTextField(
                      label: widget.isBangla ? 'ইমেইল *' : 'Email *',
                      controller: _emailController,
                      hint: 'example@mail.com',
                      onChanged: (val) => widget.bookingData.email = val,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    
                    const SizedBox(height: 12),
                    // Age & Gender
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            label: widget.isBangla ? 'বয়স *' : 'Age *',
                            controller: _ageController,
                            hint: widget.isBangla ? 'বয়স লিখুন' : 'Enter age',
                            onChanged: (val) => widget.bookingData.age = val,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.isBangla ? 'লিঙ্গ *' : 'Gender *', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: widget.bookingData.gender,
                                    isExpanded: true,
                                    items: ['Male', 'Female', 'Other'].map((String value) {
                                      return DropdownMenuItem<String>(value: value, child: Text(value, style: const TextStyle(fontSize: 12)));
                                    }).toList(),
                                    onChanged: (val) => setState(() => widget.bookingData.gender = val!),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 12),
                    // Collection Date & Time
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.isBangla ? 'পছন্দের সংগ্রহের তারিখ *' : 'Preferred Collection Date *', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                              const SizedBox(height: 8),
                              InkWell(
                                onTap: () => _selectDate(context),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                                      const SizedBox(width: 8),
                                      Text(
                                        widget.bookingData.preferredDate == null 
                                          ? (widget.isBangla ? 'তারিখ নির্বাচন করুন' : 'Select Date')
                                          : '${widget.bookingData.preferredDate!.day}/${widget.bookingData.preferredDate!.month}/${widget.bookingData.preferredDate!.year}',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.isBangla ? 'পছন্দের সময় সীমা *' : 'Preferred Time Range *', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: widget.bookingData.preferredTimeRange,
                                    hint: Text(widget.isBangla ? '-- সময় নির্বাচন করুন --' : '-- Select time range --', style: const TextStyle(fontSize: 10)),
                                    isExpanded: true,
                                    items: ['08:00 AM - 10:00 AM', '10:00 AM - 12:00 PM', '12:00 PM - 02:00 PM', '02:00 PM - 04:00 PM'].map((String value) {
                                      return DropdownMenuItem<String>(value: value, child: Text(value, style: const TextStyle(fontSize: 10)));
                                    }).toList(),
                                    onChanged: (val) => setState(() => widget.bookingData.preferredTimeRange = val),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 12),
                    // Address
                    _buildTextField(
                      label: widget.isBangla ? 'স্যাম্পল সংগ্রহের ঠিকানা *' : 'Sample Collection Address *',
                      controller: _addressController,
                      hint: widget.isBangla ? 'ঠিকানা লিখুন' : 'Enter address',
                      onChanged: (val) => widget.bookingData.address = val,
                      maxLines: 2,
                    ),
                    
                    const SizedBox(height: 12),
                    // Special Instructions
                    _buildTextField(
                      label: widget.isBangla ? 'বিশেষ নির্দেশাবলী (ঐচ্ছিক)' : 'Special Instructions (Optional)',
                      controller: _instructionController,
                      hint: widget.isBangla ? 'অতিরিক্ত নোট' : 'Any additional notes',
                      onChanged: (val) => widget.bookingData.specialInstructions = val,
                      maxLines: 3,
                    ),
                    
                    const SizedBox(height: 24),
                    // Booking Summary Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.isBangla ? 'বুকিং সারাংশ' : 'Booking Summary',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            widget.isBangla ? 'আপনার নির্বাচিত ল্যাব এবং টেস্টগুলো পর্যালোচনা করুন' : 'Review your selected lab and tests',
                            style: TextStyle(color: Colors.grey.shade500, fontSize: 10),
                          ),
                          const Divider(height: 24),
                          Text(widget.isBangla ? 'নির্বাচিত ল্যাব' : 'SELECTED LAB', style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(widget.bookingData.selectedLab?.name ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          const Divider(height: 24),
                          Text(widget.isBangla ? 'নির্বাচিত টেস্ট' : 'SELECTED TESTS', style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          ...widget.bookingData.selectedTests.map((test) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(test.name, style: const TextStyle(fontSize: 12)),
                                Text('৳ ${test.labPrices[widget.bookingData.selectedLab?.id]}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          )),
                          const Divider(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.isBangla ? 'মোট মূল্য' : 'Total Price', style: const TextStyle(fontWeight: FontWeight.bold)),
                              Text('৳ ${widget.bookingData.grandTotal}', style: const TextStyle(fontWeight: FontWeight.bold, color: primaryGreen, fontSize: 18)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
          
          // Bottom Navigation
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    child: Text(widget.isBangla ? 'পেছনে' : 'Back', style: const TextStyle(color: Colors.black)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (_) => MedicalTestSuccessScreen(isBangla: widget.isBangla, bookingData: widget.bookingData))
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(widget.isBangla ? 'বুকিং নিশ্চিত করুন' : 'Confirm Booking', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    required Function(String) onChanged,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: const TextStyle(fontSize: 12),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 12),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return widget.isBangla ? 'এই ক্ষেত্রটি প্রয়োজন' : 'This field is required';
            }
            return null;
          },
        ),
      ],
    );
  }
}
