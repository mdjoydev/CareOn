import 'package:flutter/material.dart';

class CaregiverLocationScreen extends StatefulWidget {
  const CaregiverLocationScreen({super.key});

  @override
  State<CaregiverLocationScreen> createState() => _CaregiverLocationScreenState();
}

class _CaregiverLocationScreenState extends State<CaregiverLocationScreen> {
  String _selectedLocation = 'Dhaka';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Location')),
      body: ListView(
        children: [
          RadioListTile<String>(
            title: const Text('Dhaka'),
            value: 'Dhaka',
            groupValue: _selectedLocation,
            onChanged: (val) => setState(() => _selectedLocation = val!),
          ),
          RadioListTile<String>(
            title: const Text('Chittagong'),
            value: 'Chittagong',
            groupValue: _selectedLocation,
            onChanged: (val) => setState(() => _selectedLocation = val!),
          ),
          RadioListTile<String>(
            title: const Text('Sylhet'),
            value: 'Sylhet',
            groupValue: _selectedLocation,
            onChanged: (val) => setState(() => _selectedLocation = val!),
          ),
        ],
      ),
    );
  }
}
