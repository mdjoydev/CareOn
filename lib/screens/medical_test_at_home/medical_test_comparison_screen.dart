import 'package:flutter/material.dart';
import 'medical_test_booking_utils.dart';
import 'medical_test_patient_info_screen.dart';

class MedicalTestComparisonScreen extends StatefulWidget {
  final bool isBangla;
  final MedicalTestBookingData bookingData;

  const MedicalTestComparisonScreen({
    super.key,
    required this.isBangla,
    required this.bookingData,
  });

  @override
  State<MedicalTestComparisonScreen> createState() => _MedicalTestComparisonScreenState();
}

class _MedicalTestComparisonScreenState extends State<MedicalTestComparisonScreen> {
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
          MedicalTestStepIndicator(currentStep: 2),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.isBangla ? 'ল্যাব এবং মূল্য তুলনা করুন' : 'Compare Labs & Prices',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.isBangla 
                      ? 'ল্যাব জুড়ে নির্বাচিত টেস্টের মূল্য তুলনা করুন এবং চালিয়ে যেতে একটি ল্যাব চয়ন করুন' 
                      : 'Compare selected test prices across labs and choose one lab to continue',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
                  ),
                  const SizedBox(height: 16),
                  
                  // Comparison Table - Fixed horizontal scroll and alignment
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade100),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DataTable(
                        columnSpacing: 24,
                        headingRowHeight: 40,
                        dataRowMinHeight: 40,
                        dataRowMaxHeight: 50,
                        horizontalMargin: 12,
                        headingTextStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.black),
                        columns: [
                          DataColumn(label: Text(widget.isBangla ? 'টেস্ট' : 'Test')),
                          ...labPartners.map((lab) => DataColumn(
                            label: Text(lab.name, textAlign: TextAlign.center),
                          )),
                        ],
                        rows: [
                          ...widget.bookingData.selectedTests.map((test) => DataRow(
                            cells: [
                              DataCell(Text(test.name, style: const TextStyle(fontSize: 11))),
                              ...labPartners.map((lab) => DataCell(
                                Text('৳ ${test.labPrices[lab.id]}', style: const TextStyle(fontSize: 11)),
                              )),
                            ],
                          )),
                          // Tests Total Row
                          DataRow(
                            cells: [
                              DataCell(Text(widget.isBangla ? 'টেস্ট মোট' : 'Tests Total', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                              ...labPartners.map((lab) {
                                final total = widget.bookingData.selectedTests.fold(0, (sum, test) => sum + (test.labPrices[lab.id] ?? 0));
                                return DataCell(Text('৳ $total', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)));
                              }),
                            ],
                          ),
                          // Lab Charge Row
                          DataRow(
                            cells: [
                              DataCell(Text(widget.isBangla ? 'ল্যাব চার্জ' : 'Lab Charge', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                              ...labPartners.map((lab) => DataCell(
                                Text('৳ ${lab.baseCharge}', style: const TextStyle(fontSize: 11)),
                              )),
                            ],
                          ),
                          // Grand Total Row
                          DataRow(
                            cells: [
                              DataCell(Text(widget.isBangla ? 'সর্বমোট' : 'Grand Total', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: primaryGreen))),
                              ...labPartners.map((lab) {
                                final testTotal = widget.bookingData.selectedTests.fold(0, (sum, test) => sum + (test.labPrices[lab.id] ?? 0));
                                final grandTotal = testTotal + lab.baseCharge;
                                return DataCell(Text('৳ $grandTotal', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: primaryGreen)));
                              }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  Text(
                    widget.isBangla ? 'আপনার পছন্দের ল্যাব নির্বাচন করুন' : 'Choose Your Preferred Lab',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.isBangla 
                      ? 'নির্বাচিত টেস্টগুলোর জন্য আপনি শুধুমাত্র একটি ডায়াগনস্টিক সেন্টার বা হাসপাতাল নির্বাচন করতে পারেন।' 
                      : 'You can select only one Diagnostic Center or Hospital for the selected tests.',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
                  ),
                  const SizedBox(height: 16),
                  
                  // Lab Selection Cards - Fixed overflow by using mainAxisExtent
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 85, // Increased height to prevent overflow
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: labPartners.length,
                    itemBuilder: (context, index) {
                      final lab = labPartners[index];
                      final isSelected = widget.bookingData.selectedLab?.id == lab.id;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.bookingData.selectedLab = lab;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: isSelected ? primaryGreen : Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(12),
                            color: isSelected ? primaryGreen.withValues(alpha: 0.5) : Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                lab.name,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                isSelected ? (widget.isBangla ? 'নির্বাচিত' : 'Selected') : (widget.isBangla ? 'এই ল্যাবটি নির্বাচন করতে ক্লিক করুন' : 'Click to select this lab'),
                                style: TextStyle(
                                  color: isSelected ? primaryGreen : Colors.grey.shade500,
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
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
                    onPressed: widget.bookingData.selectedLab == null 
                      ? null 
                      : () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (_) => MedicalTestPatientInfoScreen(isBangla: widget.isBangla, bookingData: widget.bookingData))
                        );
                      },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.isBangla ? 'চালিয়ে যান' : 'Continue', style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward, size: 18),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
