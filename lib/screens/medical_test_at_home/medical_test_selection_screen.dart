import 'package:flutter/material.dart';
import 'medical_test_booking_utils.dart';
import 'medical_test_comparison_screen.dart';

class MedicalTestSelectionScreen extends StatefulWidget {
  final bool isBangla;
  final MedicalTestBookingData bookingData;

  const MedicalTestSelectionScreen({
    super.key,
    required this.isBangla,
    required this.bookingData,
  });

  @override
  State<MedicalTestSelectionScreen> createState() => _MedicalTestSelectionScreenState();
}

class _MedicalTestSelectionScreenState extends State<MedicalTestSelectionScreen> {
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  List<MedicalTest> get filteredTests {
    if (searchQuery.isEmpty) return availableTests;
    return availableTests
        .where((test) => test.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  void _toggleTest(MedicalTest test) {
    setState(() {
      if (widget.bookingData.selectedTests.contains(test)) {
        widget.bookingData.selectedTests.remove(test);
      } else {
        widget.bookingData.selectedTests.add(test);
      }
    });
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
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          MedicalTestStepIndicator(currentStep: 1),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  MedicalTestHeader(isBangla: widget.isBangla),
                  
                  // Choose Diagnostic Tests Header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.isBangla ? 'ডায়াগনস্টিক টেস্ট বেছে নিন' : 'Choose Diagnostic Tests',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.isBangla ? '${availableTests.length}টি টেস্ট উপলব্ধ' : '${availableTests.length} Tests available',
                          style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Search Bar
                  TextField(
                    controller: _searchController,
                    onChanged: (val) => setState(() => searchQuery = val),
                    decoration: InputDecoration(
                      hintText: widget.isBangla ? 'টেস্ট খুঁজুন...' : 'Search tests...',
                      prefixIcon: const Icon(Icons.search, size: 22, color: Colors.grey),
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Test Grid - Fixed overflow by using mainAxisExtent: 110
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 110, // Increased to prevent overflow (fixes 7.2 pixels issue)
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: filteredTests.length,
                    itemBuilder: (context, index) {
                      final test = filteredTests[index];
                      final isSelected = widget.bookingData.selectedTests.contains(test);
                      return GestureDetector(
                        onTap: () => _toggleTest(test),
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
                                test.name,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                maxLines: 2,
                                overflow: TextOverflow.visible,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                isSelected ? (widget.isBangla ? 'নির্বাচিত' : 'Selected') : (widget.isBangla ? 'নির্বাচন করতে ক্লিক করুন' : 'Click to select this test'),
                                style: TextStyle(
                                  color: isSelected ? primaryGreen : Colors.grey.shade500,
                                  fontSize: 9,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 24),
                  // Pagination
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(onPressed: () {}, child: Text(widget.isBangla ? 'পূর্ববর্তী' : 'PREV', style: TextStyle(color: Colors.grey.shade400, fontSize: 12, fontWeight: FontWeight.bold))),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(color: Colors.cyan.shade100, borderRadius: BorderRadius.circular(6)),
                        child: const Text('1', style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold)),
                      ),
                      TextButton(onPressed: () {}, child: Text(widget.isBangla ? 'পরবর্তী' : 'NEXT', style: TextStyle(color: Colors.grey.shade400, fontSize: 12, fontWeight: FontWeight.bold))),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Center(child: Text(widget.isBangla ? '৫টির মধ্যে ১ থেকে ৫টি দেখাচ্ছে' : 'Showing 1 to 5 of 5', style: TextStyle(color: Colors.grey.shade500, fontSize: 11))),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          
          // Bottom Navigation
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.bookingData.selectedTests.isEmpty 
                  ? null 
                  : () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (_) => MedicalTestComparisonScreen(isBangla: widget.isBangla, bookingData: widget.bookingData))
                    );
                  },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  disabledBackgroundColor: Colors.grey.shade200,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.isBangla ? 'চালিয়ে যান' : 'Continue', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward, size: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
