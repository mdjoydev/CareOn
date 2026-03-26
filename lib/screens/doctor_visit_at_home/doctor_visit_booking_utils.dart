import 'package:flutter/material.dart';

class DoctorVisitBookingData {
  String serviceName = 'Doctor Visit At Home';
  bool isForSelf = true;
  String? patientName;
  String? patientAge;
  String? gender;
  String? email;
  String? nationality;
  String? mobileNumber;
  String? problem;
  String? specialization;
  DateTime? appointmentDate;
  TimeOfDay? appointmentTime;
  String? additionalNotes;

  DoctorVisitBookingData();
}

class DoctorVisitStepIndicator extends StatelessWidget {
  final int currentStep;
  const DoctorVisitStepIndicator({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final steps = ['Booking', 'Confirmed'];
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
                      width: 160,
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