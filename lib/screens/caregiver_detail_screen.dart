import 'package:flutter/material.dart';
import '../main.dart';
import 'caregiver_location_screen.dart';

class CaregiverDetailScreen extends StatelessWidget {
  const CaregiverDetailScreen({super.key});

  void _openBooking(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CaregiverLocationScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text('Service Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Special Healthcare Services',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Caregiver for Elderly, Bedridden & Post-Hospital Care',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 24),
          
          _buildInfoCard(
            title: 'Care Levels',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _CareLevelTile(
                  title: 'Basic Care',
                  description:
                      'Essential daily support and assistance for elderly and bedridden patients.',
                ),
                SizedBox(height: 12),
                _CareLevelTile(
                  title: 'Standard Care',
                  description:
                      'Enhanced monitoring and support for patients needing regular medical attention.',
                ),
                SizedBox(height: 12),
                _CareLevelTile(
                  title: 'Critical Care',
                  description:
                      'High-dependency caregiving for complex or critical health conditions.',
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          _buildInfoCard(
            title: 'Available Packages',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Choose from Daily or Monthly packages with 8, 12 and 24-hours coverage.',
                  style: TextStyle(color: Colors.black87),
                ),
                const SizedBox(height: 16),
                _buildPackageList('Daily Package', ['8 Hours', '12 Hours', '24 Hours']),
                const SizedBox(height: 12),
                _buildPackageList('Monthly Package', ['8 Hours', '12 Hours', '24 Hours']),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          FilledButton(
            onPressed: () => _openBooking(context),
            child: const Text('Book This Service'),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildInfoCard({required String title, required Widget child}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 24),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildPackageList(String title, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          children: options.map((opt) => Chip(
            label: Text(opt, style: const TextStyle(fontSize: 12)),
            visualDensity: VisualDensity.compact,
            backgroundColor: Colors.grey.shade100,
            side: BorderSide.none,
          )).toList(),
        ),
      ],
    );
  }
}

class _CareLevelTile extends StatelessWidget {
  final String title;
  final String description;

  const _CareLevelTile({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.check_circle, size: 18, color: CareOnApp.careOnGreen),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              Text(description, style: const TextStyle(color: Colors.black54, fontSize: 13)),
            ],
          ),
        ),
      ],
    );
  }
}

