import 'package:flutter/material.dart';

class MedicalTest {
  final String id;
  final String name;
  final String description;
  final Map<String, int> labPrices;

  MedicalTest({
    required this.id,
    required this.name,
    required this.description,
    required this.labPrices,
  });
}

class LabPartner {
  final String id;
  final String name;
  final String imagePath;
  final int baseCharge;

  LabPartner({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.baseCharge,
  });
}

class MedicalTestBookingData {
  List<MedicalTest> selectedTests = [];
  LabPartner? selectedLab;
  
  bool isForSelf = true;
  String? fullName;
  String nationality = 'Bangladeshi';
  String? mobileNumber;
  String? email;
  String? age;
  String gender = 'Male';
  DateTime? preferredDate;
  String? preferredTimeRange;
  String? address;
  String? specialInstructions;

  int get testsTotal {
    if (selectedLab == null) return 0;
    return selectedTests.fold(0, (sum, test) => sum + (test.labPrices[selectedLab!.id] ?? 0));
  }

  int get grandTotal {
    if (selectedLab == null) return 0;
    return testsTotal + selectedLab!.baseCharge;
  }
}

final List<LabPartner> labPartners = [
  LabPartner(id: 'amarlab', name: 'AmarLab', imagePath: 'assets/Medical Care Services/medical-test-at-home-1769334463-9266.webp', baseCharge: 151),
  LabPartner(id: 'popular', name: 'Popular Diagnostic Center', imagePath: 'assets/Medical Care Services/medical-test-at-home-1769334463-9266.webp', baseCharge: 500),
  LabPartner(id: 'thyrocare', name: 'Thyrocare Bangladesh Ltd', imagePath: 'assets/Medical Care Services/medical-test-at-home-1769334463-9266.webp', baseCharge: 300),
  LabPartner(id: 'drlal', name: 'Dr Lal Pathlabs Bangladesh', imagePath: 'assets/Medical Care Services/medical-test-at-home-1769334463-9266.webp', baseCharge: 200),
  LabPartner(id: 'united', name: 'United Hospital Ltd', imagePath: 'assets/Medical Care Services/medical-test-at-home-1769334463-9266.webp', baseCharge: 200),
];

final List<MedicalTest> availableTests = [
  MedicalTest(
    id: 'ada',
    name: 'ADA',
    description: 'Click to select this test',
    labPrices: {'amarlab': 900, 'popular': 850, 'thyrocare': 900, 'drlal': 750, 'united': 800},
  ),
  MedicalTest(
    id: 'cbc',
    name: 'CBC',
    description: 'Click to select this test',
    labPrices: {'amarlab': 400, 'popular': 450, 'thyrocare': 400, 'drlal': 400, 'united': 400},
  ),
  MedicalTest(
    id: 'cbc_esr',
    name: 'CBC with ESR',
    description: 'Click to select this test',
    labPrices: {'amarlab': 400, 'popular': 400, 'thyrocare': 400, 'drlal': 400, 'united': 400},
  ),
  MedicalTest(
    id: 'blood_group',
    name: 'Blood Group & RH Factor',
    description: 'Click to select this test',
    labPrices: {'amarlab': 300, 'popular': 400, 'thyrocare': 500, 'drlal': 500, 'united': 400},
  ),
  MedicalTest(
    id: 'xray_ankle',
    name: 'X-Ray of Ankle',
    description: 'Click to select this test',
    labPrices: {'amarlab': 3000, 'popular': 2900, 'thyrocare': 2900, 'drlal': 2800, 'united': 3100},
  ),
];

class MedicalTestStepIndicator extends StatelessWidget {
  final int currentStep;
  const MedicalTestStepIndicator({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final steps = ['Select Tests', 'Compare & Lab', 'Patient Info', 'Confirm'];
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
                      width: 24,
                      height: 24,
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
                          height: 1.5,
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

class MedicalTestHeader extends StatelessWidget {
  final bool isBangla;
  const MedicalTestHeader({super.key, required this.isBangla});

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF00A66C);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: primaryGreen.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            isBangla ? 'মেডিকেল কেয়ার সার্ভিস' : 'Medical Care Services',
            style: const TextStyle(color: primaryGreen, fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          isBangla ? 'মেডিকেল টেস্ট অ্যাট হোম' : 'Medical Test At Home',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
        ),
        const SizedBox(height: 4),
        Text(
          isBangla 
            ? 'অনুমোদিত প্যারামেডিক/নার্স দ্বারা সব ধরনের প্যাথলজিক্যাল স্যাম্পল সংগ্রহ' 
            : 'All types of pathological sample collection by authorized paramedics/nurses',
          style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
        ),
        const SizedBox(height: 24),
        Center(
          child: Text(
            isBangla ? 'বিশ্বস্ত ল্যাব পার্টনার' : 'Trusted Lab Partners',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          isBangla
            ? 'বাসা থেকে আপনার মেডিকেল ল্যাব টেস্ট করান। কেয়ারঅন অমরল্যাব-এর সাথে অংশীদারিত্ব করে শীর্ষস্থানীয় হাসপাতাল এবং ডায়াগনস্টিক সেন্টারগুলোর জন্য নিরাপদ এবং মানসম্মত মেডিকেল স্যাম্পল সংগ্রহ পরিষেবা প্রদান করে।'
            : 'Get your medical lab tests done from home. CareOn partners with AmarLab to provide safe and compliant medical sample collection services for leading hospitals and diagnostic centers.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: labPartners.map((lab) => Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(lab.imagePath, height: 40, errorBuilder: (context, error, stackTrace) => Text(lab.name, style: const TextStyle(fontSize: 10))),
            )).toList(),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
