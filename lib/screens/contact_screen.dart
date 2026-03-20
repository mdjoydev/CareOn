import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/section_header.dart';

class ContactScreen extends StatefulWidget {
  final bool isBangla;
  const ContactScreen({super.key, this.isBangla = false});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  String? _feedbackService;
  String? _feedbackRating;
  late String _selectedHelpType;

  @override
  void initState() {
    super.initState();
    _selectedHelpType = widget.isBangla ? 'সাধারণ জিজ্ঞাসা' : 'General Inquiry';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: widget.isBangla ? 'যোগাযোগ করুন' : 'Get in Touch'),
          const SizedBox(height: 8),
          Text(
            widget.isBangla 
                ? 'আমরা সাহায্য করতে এখানে আছি। সহায়তা, প্রতিক্রিয়া বা কাস্টম পরিষেবার অনুরোধের জন্য আমাদের সাথে যোগাযোগ করুন।'
                : 'We\'re here to help. Reach out for support, feedback, or custom service requests.',
            style: const TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.call, color: theme.colorScheme.primary),
                      const SizedBox(width: 8),
                      const Text(
                        '+880 131 955 2222',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.isBangla ? '২৪/৭ সহায়তা উপলব্ধ' : '24/7 Support Available',
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.chat_outlined, color: theme.colorScheme.primary),
                      const SizedBox(width: 8),
                      const Text(
                        'WhatsApp: +880 131 955 2222',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.email_outlined, color: theme.colorScheme.primary),
                      const SizedBox(width: 8),
                      const Text('info@careon.me'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          widget.isBangla 
                              ? 'বাসা ০৬, রোড ০২, ব্লক এল, বনানী, ঢাকা ১২১৩, বাংলাদেশ'
                              : 'House 06, Road 02, Block L, Banani, Dhaka 1213, Bangladesh',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.isBangla 
                        ? 'জরুরি অবস্থার জন্য ২৪/৭ · অফিস সকাল ৯টা - রাত ৮টা'
                        : '24/7 for emergencies · Office 9 AM - 8 PM',
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          SectionHeader(title: widget.isBangla ? 'আমরা আপনাকে কীভাবে সাহায্য করতে পারি?' : 'What can we help you with?'),
          const SizedBox(height: 12),
          Row(
            children: [
              ChoiceChip(
                label: const Text('General Inquiry'),
                selected: _selectedHelpType == 'General Inquiry',
                onSelected: (selected) {
                  if (selected) {
                    setState(() => _selectedHelpType = 'General Inquiry');
                  }
                },
              ),
              const SizedBox(width: 8),
              ChoiceChip(
                label: const Text('Feedback'),
                selected: _selectedHelpType == 'Feedback',
                onSelected: (selected) {
                  if (selected) {
                    setState(() => _selectedHelpType = 'Feedback');
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_selectedHelpType == 'General Inquiry') ...[
            TextField(
              decoration: InputDecoration(
                labelText: 'Full Name *',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Mobile Number *',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email Address *',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                labelText: 'Subject *',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Message *',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CareOnApp.careOnGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Message sent. We will respond within 24 hours.'),
                    ),
                  );
                },
                child: const Text('Send Message'),
              ),
            ),
          ] else ...[
            TextField(
              decoration: InputDecoration(
                labelText: 'Full Name *',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Mobile Number *',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email Address *',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _feedbackService,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: 'Which service did you use?',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              items: const [
                'Caregiver for Elderly, Bedridden & Post-Hospital Care',
                'Medical Test At Home',
                'Ambulance Support',
                'Doctor Visit At Home',
                'Baby Care / Nanny Service',
                "Patient's Attendant Service",
                'Physiotherapy at Home',
                'Emergency Nursing Service',
                'Nursing Care Service',
              ].map((service) {
                return DropdownMenuItem<String>(
                  value: service,
                  child: Text(
                    service,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14),
                  ),
                );
              }).toList(),
              onChanged: (value) => setState(() => _feedbackService = value),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _feedbackRating,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: 'Rating *',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              items: const [
                '⭐⭐⭐⭐⭐ Excellent',
                '⭐⭐⭐⭐ Good',
                '⭐⭐ Average',
                '⭐ Poor',
                '⭐ Very Poor',
              ].map((rating) {
                return DropdownMenuItem<String>(
                  value: rating,
                  child: Text(rating),
                );
              }).toList(),
              onChanged: (value) => setState(() => _feedbackRating = value),
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                labelText: 'Subject *',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Message *',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CareOnApp.careOnGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Feedback submitted. Thank you for your response.'),
                    ),
                  );
                },
                child: const Text('Submit Feedback'),
              ),
            ),
          ],
          const SizedBox(height: 24),
          const Text(
            'Note: For urgent medical assistance, please call our 24/7 helpline.',
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
