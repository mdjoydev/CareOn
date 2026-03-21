import 'package:flutter/material.dart';

/// Shared data model to carry booking information across all services.
class BookingData {
  final String serviceName;
  String? area;
  String packageType = 'Daily'; 
  String careLevel = 'Standard Care'; 
  String hours = '12 Hours';
  int price = 0;
  DateTime? date;
  TimeOfDay? time;
  
  // Patient Details
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

  BookingData({required this.serviceName});
}

/// Progress indicator matching the reference images.
class BookingStepIndicator extends StatelessWidget {
  final int currentStep;
  const BookingStepIndicator({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final steps = ['Location', 'Package', 'Schedule', 'Address', 'Review', 'Payment'];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(steps.length, (index) {
          final stepNum = index + 1;
          final isActive = stepNum <= currentStep;
          return Expanded(
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: isActive ? const Color(0xFF059669) : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isActive ? const Color(0xFF059669) : Colors.grey.shade300,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '$stepNum',
                      style: TextStyle(
                        color: isActive ? Colors.white : Colors.grey.shade500,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                if (MediaQuery.of(context).size.width > 450)
                  Text(
                    steps[index],
                    style: TextStyle(
                      fontSize: 10,
                      color: isActive ? Colors.black87 : Colors.grey.shade400,
                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                if (index < steps.length - 1)
                  Expanded(
                    child: Container(
                      height: 1,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      color: Colors.grey.shade200,
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
