import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';

class BookingScreen extends StatefulWidget {
  final String? initialService;

  const BookingScreen({super.key, this.initialService});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  
  static const _services = [
    'Caregiver for Elderly, Bedridden & Post-Hospital Care',
    'Baby Care / Nanny Service',
    "Patient's Attendant Service",
    'Physiotherapy at Home',
    'Nursing Care Service',
    'Medical Test At Home',
    'Ambulance Support',
    'Doctor Visit At Home',
    'Emergency Nursing Service',
  ];

  String? _selectedService;
  bool _isAsap = true;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedShift;

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialService != null && _services.contains(widget.initialService)) {
      _selectedService = widget.initialService;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 90)),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) setState(() => _selectedTime = picked);
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    
    if (!_isAsap && (_selectedDate == null || _selectedTime == null)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both date and time')),
      );
      return;
    }

    final schedule = _isAsap 
        ? 'ASAP' 
        : '${_selectedDate!.toLocal().toString().split(' ')[0]} at ${_selectedTime!.format(context)}';
    
    final message = '''
New Booking Request:
Service: $_selectedService
Schedule: $schedule
Shift: ${_selectedShift ?? 'Not specified'}

Client Details:
Name: ${_nameController.text}
Phone: ${_phoneController.text}
Address: ${_addressController.text}
Notes: ${_noteController.text}
''';

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'info@careon.me',
      query: 'subject=Booking Request - $_selectedService&body=$message',
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch email client')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Check if the screen can be popped (meaning it's not the root of the current navigator)
    final bool canPop = Navigator.of(context).canPop();

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: canPop ? AppBar(
        title: const Text('Book a Service'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ) : null,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              if (!canPop) ...[
                const Text(
                  'Book a Service',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
              ],
              Text(
                'Complete the form below and we will contact you shortly to confirm your booking.',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
              const SizedBox(height: 24),
              
              _buildSectionTitle('1. Select Service'),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _selectedService,
                isExpanded: true,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.medical_services_outlined, color: CareOnApp.careOnGreen),
                  hintText: 'Choose a service',
                ),
                items: _services.map((s) => DropdownMenuItem(
                  value: s, 
                  child: Text(
                    s, 
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14),
                  )
                )).toList(),
                onChanged: (val) => setState(() => _selectedService = val),
                validator: (val) => val == null ? 'Please select a service' : null,
              ),
              
              const SizedBox(height: 24),
              _buildSectionTitle('2. Schedule'),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    _buildCustomRadioTile(
                      title: 'ASAP (As soon as possible)',
                      value: true,
                      isSelected: _isAsap == true,
                      onTap: () => setState(() => _isAsap = true),
                    ),
                    _buildCustomRadioTile(
                      title: 'Schedule for later',
                      value: false,
                      isSelected: _isAsap == false,
                      onTap: () => setState(() => _isAsap = false),
                    ),
                    if (!_isAsap) ...[
                      const Divider(height: 1),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: _pickDate,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          _selectedDate == null ? 'Date' : '${_selectedDate!.toLocal()}'.split(' ')[0],
                                          style: TextStyle(
                                            color: _selectedDate == null ? Colors.grey : Colors.black,
                                            fontSize: 12,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: InkWell(
                                onTap: _pickTime,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.access_time, size: 16, color: Colors.grey),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          _selectedTime == null ? 'Time' : _selectedTime!.format(context),
                                          style: TextStyle(
                                            color: _selectedTime == null ? Colors.grey : Colors.black,
                                            fontSize: 12,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _selectedShift,
                isExpanded: true,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.timer_outlined, color: CareOnApp.careOnGreen),
                  hintText: 'Shift Duration (Optional)',
                ),
                items: ['8 Hours', '12 Hours', '24 Hours']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s, style: const TextStyle(fontSize: 14))))
                    .toList(),
                onChanged: (val) => setState(() => _selectedShift = val),
              ),
              
              const SizedBox(height: 24),
              _buildSectionTitle('3. Personal Information'),
              const SizedBox(height: 12),
              TextFormField(
                controller: _nameController,
                style: const TextStyle(fontSize: 14),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline, color: CareOnApp.careOnGreen),
                  labelText: 'Full Name',
                ),
                validator: (val) => val!.isEmpty ? 'Please enter your name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(fontSize: 14),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.phone_outlined, color: CareOnApp.careOnGreen),
                  labelText: 'Phone Number',
                ),
                validator: (val) => val!.isEmpty ? 'Please enter your phone' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                maxLines: 2,
                style: const TextStyle(fontSize: 14),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.location_on_outlined, color: CareOnApp.careOnGreen),
                  labelText: 'Full Address',
                ),
                validator: (val) => val!.isEmpty ? 'Please enter your address' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _noteController,
                maxLines: 3,
                style: const TextStyle(fontSize: 14),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.note_alt_outlined, color: CareOnApp.careOnGreen),
                  labelText: 'Additional Notes (Optional)',
                ),
              ),
              
              const SizedBox(height: 32),
              FilledButton(
                onPressed: _submit,
                child: const Text('Confirm Booking Request'),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () => launchUrl(Uri.parse('tel:+8801319552222')),
                icon: const Icon(Icons.support_agent),
                label: const Text('Call for Support'),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomRadioTile({
    required String title,
    required bool value,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              size: 20,
              color: CareOnApp.careOnGreen,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: isSelected ? Colors.black : Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}
