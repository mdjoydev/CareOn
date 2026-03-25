import 'package:flutter/material.dart';

class PhysiotherapyBookingData {
  String? serviceName = 'Physiotherapy at Home';
  String? area;
  String careLevel = 'Standard Care'; // Basic, Standard, Critical
  String packageType = 'Daily'; // Daily, Monthly
  
  // Patient Info & Address
  bool isForSelf = false;
  String? patientName;
  String? gender;
  String? age;
  String? height;
  String? weight;
  String patientType = 'Bangladeshi';
  String? country;
  String? contact;
  String? emergencyContact;
  String? address;
  String? genderPreference;
  String? languagePreference;
  String? importantInfo;
  
  String? paymentMethod;
  int price = 1600;

  PhysiotherapyBookingData();
}

class PhysiotherapyStepIndicator extends StatelessWidget {
  final int currentStep;
  const PhysiotherapyStepIndicator({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final steps = ['Location', 'Address', 'Review', 'Payment'];
    const primaryGreen = Color(0xFF00A66C);

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: List.generate(steps.length, (index) {
              final stepNum = index + 1;
              final isActive = stepNum <= currentStep;
              final isLast = index == steps.length - 1;

              return Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: isActive ? primaryGreen : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isActive ? primaryGreen : Colors.grey.shade300,
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '$stepNum',
                          style: TextStyle(
                            color: isActive ? Colors.white : Colors.grey.shade500,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          height: 2,
                          color: stepNum < currentStep ? primaryGreen : Colors.grey.shade200,
                        ),
                      ),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: steps.map((step) {
              final index = steps.indexOf(step);
              final isActive = (index + 1) <= currentStep;
              return Expanded(
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    color: isActive ? Colors.black87 : Colors.grey.shade400,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
