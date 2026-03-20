import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HealthTipsScreen extends StatefulWidget {
  final bool isBangla;
  const HealthTipsScreen({super.key, this.isBangla = false});

  @override
  State<HealthTipsScreen> createState() => _HealthTipsScreenState();
}

class _HealthTipsScreenState extends State<HealthTipsScreen> {
  late String _selectedCategory;
  late List<String> _categories;

  @override
  void initState() {
    super.initState();
    _initCategories();
  }

  @override
  void didUpdateWidget(HealthTipsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isBangla != widget.isBangla) {
      _initCategories();
    }
  }

  void _initCategories() {
    _categories = widget.isBangla
        ? ['সব', 'বয়স্ক', 'শিশু', 'সার্জারি']
        : ['All', 'Elderly', 'Baby', 'Surgery'];
    _selectedCategory = _categories[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.isBangla
                        ? 'স্বাস্থ্য টিপস এবং পরামর্শ'
                        : 'Health Tips & Advice',
                    style: GoogleFonts.inter(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Categories Row
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: _categories.map((category) {
                        final isActive = _selectedCategory == category;
                        return GestureDetector(
                          onTap: () =>
                              setState(() => _selectedCategory = category),
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? const Color(0xFF059669)
                                  : const Color(0xFFF3F4F6),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              category,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: isActive ? Colors.white : const Color(
                                    0xFF6B7280),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            // Tips List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24),
                physics: const BouncingScrollPhysics(),
                children: [
                  _buildTipCard(
                    category: widget.isBangla
                        ? 'বয়স্কদের যত্ন'
                        : 'ELDERLY CARE',
                    title: widget.isBangla
                        ? 'বাড়িতে বয়স্ক বাবা-মায়ের যত্ন নেওয়ার ৫টি টিপস'
                        : '5 Tips to Care for Elderly Parents at Home',
                    author: widget.isBangla ? 'ডাঃ সারা' : 'Dr. Sarah',
                    readTime: widget.isBangla ? '৫ মিনিট পড়া' : '5 min read',
                    bgColor: const Color(0xFFECFDF5),
                    iconColor: const Color(0xFF10B981),
                  ),
                  const SizedBox(height: 20),
                  _buildTipCard(
                    category: widget.isBangla ? 'শিশুর যত্ন' : 'BABY CARE',
                    title: widget.isBangla
                        ? 'নবজাতকের পুষ্টি: একটি নির্দেশিকা'
                        : 'Nutrition for Newborns: A Guide',
                    author: widget.isBangla ? 'পুষ্টিবিদ আহমেদ' : 'Nutr. Ahmed',
                    readTime: widget.isBangla ? '৮ মিনিট পড়া' : '8 min read',
                    bgColor: const Color(0xFFEFF6FF),
                    iconColor: const Color(0xFF3B82F6),
                  ),
                  const SizedBox(height: 20),
                  _buildTipCard(
                    category: widget.isBangla
                        ? 'সার্জারি পরবর্তী যত্ন'
                        : 'SURGERY RECOVERY',
                    title: widget.isBangla
                        ? 'সার্জারি পরবর্তী যত্ন: প্রয়োজনীয় পদক্ষেপ'
                        : 'Post-Surgery Care: Essential Steps',
                    author: widget.isBangla ? 'ডাঃ ইয়াসমিন' : 'Dr. Yasmin',
                    readTime: widget.isBangla ? '৬ মিনিট পড়া' : '6 min read',
                    bgColor: const Color(0xFFFFF7ED),
                    iconColor: const Color(0xFFF97316),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipCard({
    required String category,
    required String title,
    required String author,
    required String readTime,
    required Color bgColor,
    required Color iconColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFF3F4F6)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Placeholder Section
          Container(
            height: 160,
            width: double.infinity,
            color: bgColor,
            child: Center(
              child: Icon(
                Icons.monitor_heart_rounded,
                size: 64,
                color: iconColor.withValues(alpha: 0.3),
              ),
            ),
          ),
          // Content Section
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    category,
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: iconColor,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1F2937),
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: iconColor.withValues(alpha: 0.2),
                      child: Text(
                        author.isNotEmpty ? author[0] : '?',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: iconColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      author,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.access_time_rounded, size: 14,
                        color: Color(0xFF9CA3AF)),
                    const SizedBox(width: 4),
                    Text(
                      readTime,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
