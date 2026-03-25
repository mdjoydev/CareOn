import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/assets.dart';
import '../../core/state/user_session.dart';
import '../../core/theme/responsive.dart';
import '../services/services_screen.dart';
import '../sos_screen.dart';
import '../booking_screen.dart';
import '../caregiver_for_elderly/caregiver_service_details_screen.dart';
import '../physiotherapy_at_home/physiotherapy_service_details_screen.dart';
import '../nursing_care_service/nursing_service_details_screen.dart';
import '../baby_care_service/baby_care_service_details_screen.dart';
import 'health_checkup_packages_screen.dart';
import 'main_app.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback? onSosTap;
  final VoidCallback? onViewAllServices;
  final VoidCallback? onViewAllCheckups;
  final VoidCallback? onLanguageToggle;

  const HomeScreen({
    super.key,
    this.onSosTap,
    this.onViewAllServices,
    this.onViewAllCheckups,
    this.onLanguageToggle,
  });

  void _onCategoryTap(BuildContext context, String label) {
    final provider = Provider.of<LanguageProvider>(context, listen: false);
    final isBangla = provider.isBangla;
    
    if (label == 'Elderly Care' || label == 'বয়স্ক সেবা') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => CaregiverServiceDetailsScreen(isBangla: isBangla),
        ),
      );
    } else if (label == 'Physiotherapy' || label == 'ফিজিওথেরাপি') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => PhysiotherapyServiceDetailsScreen(isBangla: isBangla),
        ),
      );
    } else if (label == 'Nursing Care' || label == 'নার্সিং সেবা') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => NursingServiceDetailsScreen(isBangla: isBangla),
        ),
      );
    } else if (label == 'Baby Care' || label == 'বেবি কেয়ার') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => BabyCareServiceDetailsScreen(isBangla: isBangla),
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => BookingScreen(initialService: label),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LanguageProvider>(context);
    final isBangla = provider.isBangla;

    return Material(
      color: const Color(0xFFF9FAFB),
      child: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
          },
          color: const Color(0xFF059669),
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 800),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, -20 * (1 - value)),
                        child: child,
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(
                      Responsive.scalePadding(context, 24),
                      20,
                      Responsive.scalePadding(context, 24),
                      32,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: _Header(isBangla: isBangla),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.scalePadding(context, 24),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 32),
                      _EmergencyBanner(
                        onSosTap: onSosTap,
                        isBangla: isBangla,
                      ),
                      const SizedBox(height: 40),
                      _ServiceCategoriesSection(
                        onViewAll: onViewAllServices ?? () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) => ServicesScreen(isBangla: isBangla)));
                        },
                        isBangla: isBangla,
                        onCategoryTap: (label) => _onCategoryTap(context, label),
                      ),
                      const SizedBox(height: 40),
                      _PromoBanner(isBangla: isBangla),
                      const SizedBox(height: 40),
                      _BasicHealthCheckupRow(
                        onViewAll: onViewAllCheckups ?? () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => HealthCheckupPackagesScreen(isBangla: isBangla),
                            ),
                          );
                        },
                        isBangla: isBangla,
                      ),
                      const SizedBox(height: 40),
                      _RecentActivitySection(isBangla: isBangla),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onAction;
  final bool isBangla;

  const _SectionHeader({
    required this.title,
    this.onAction,
    required this.isBangla,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: Responsive.scaleFontSize(context, 18),
              fontWeight: FontWeight.w800,
              color: const Color(0xFF111827),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (onAction != null)
          TextButton(
            onPressed: onAction,
            child: Text(
              isBangla ? 'সব দেখুন' : 'View All',
              style: const TextStyle(
                color: Color(0xFF059669),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final bool isBangla;
  const _Header({this.isBangla = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final session = UserSession.instance;
    final displayName = (session.name?.isNotEmpty ?? false)
        ? session.name!
        : (isBangla ? 'জয় চৌধুরী' : 'Joy Chowdhury');

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isBangla ? 'হ্যালো, $displayName' : 'Hello, $displayName',
                style: theme.headlineLarge?.copyWith(
                  color: const Color(0xFF111827),
                  fontSize: Responsive.scaleFontSize(context, 22),
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                isBangla ? 'স্বাস্থ্যসেবা আপনার দোরগোড়ায়' : 'Healthcare at your doorstep',
                style: theme.titleMedium?.copyWith(
                  color: const Color(0xFF6B7280),
                  fontSize: Responsive.scaleFontSize(context, 14),
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Row(
          children: [
            _buildCircularIcon(Icons.notifications_none_rounded, hasBadge: true),
            const SizedBox(width: 12),
            _buildProfileIcon(session.photoPath),
          ],
        ),
      ],
    );
  }

  Widget _buildCircularIcon(IconData icon, {bool hasBadge = false}) {
    return Container(
      height: 48,
      width: 48,
      decoration: const BoxDecoration(color: Color(0xFFF3F4F6), shape: BoxShape.circle),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(icon, color: const Color(0xFF1F2937), size: 26),
          if (hasBadge)
            Positioned(
              right: 14,
              top: 12,
              child: Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProfileIcon(String? photoPath) {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF10B981), width: 2),
      ),
      child: ClipOval(
        child: photoPath != null
            ? Image.file(File(photoPath), fit: BoxFit.cover)
            : Container(
                color: const Color(0xFFE1FBF2),
                child: const Icon(Icons.person_outline_rounded,
                    color: Color(0xFF10B981), size: 28),
              ),
      ),
    );
  }
}

class _EmergencyBanner extends StatefulWidget {
  final VoidCallback? onSosTap;
  final bool isBangla;
  const _EmergencyBanner({this.onSosTap, this.isBangla = false});

  @override
  State<_EmergencyBanner> createState() => _EmergencyBannerState();
}

class _EmergencyBannerState extends State<_EmergencyBanner> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _pulseAnimation,
      child: GestureDetector(
        onTap: widget.onSosTap ?? () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SosScreen())),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFFE11D48), Color(0xFFF43F5E)]),
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFE11D48).withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                height: 68,
                width: 68,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Icon(Icons.emergency, color: Colors.white, size: 40),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.isBangla ? 'জরুরী সহায়তা' : 'Emergency Help',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: Responsive.scaleFontSize(context, 18),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.isBangla ? 'অ্যাম্বুলেন্স / নার্স কল করুন' : 'Call Ambulance / Nurse',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.95),
                        fontSize: Responsive.scaleFontSize(context, 14),
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _ServiceCategoriesSection extends StatelessWidget {
  final VoidCallback? onViewAll;
  final Function(String) onCategoryTap;
  final bool isBangla;
  const _ServiceCategoriesSection({this.onViewAll, required this.onCategoryTap, this.isBangla = false});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'image': CareOnAssets.caregiverPng, 'label': isBangla ? 'বয়স্ক সেবা' : 'Elderly Care'},
      {'image': CareOnAssets.emergencyNursingPng, 'label': isBangla ? 'নার্সিং সেবা' : 'Nursing Care'},
      {'image': CareOnAssets.physiotherapyPng, 'label': isBangla ? 'ফিজিওথেরাপি' : 'Physiotherapy'},
      {'image': CareOnAssets.babyCarePng, 'label': isBangla ? 'বেবি কেয়ার' : 'Baby Care'},
      {'image': CareOnAssets.patientAttendantPng, 'label': isBangla ? 'রোগীর অ্যাটেনডেন্ট' : 'Patient Attendant'},
      {'image': CareOnAssets.medicalTestPng, 'label': isBangla ? 'মেডিকেল টেস্ট' : 'Medical Test'},
    ];

    return Column(
      children: [
        _SectionHeader(
          title: isBangla ? 'সেবা ক্যাটাগরি' : 'Service Categories',
          onAction: onViewAll,
          isBangla: isBangla,
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisExtent: Responsive.scale(context, 125),
            crossAxisSpacing: 16,
            mainAxisSpacing: 20,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final cat = categories[index];
            return GestureDetector(
              onTap: () => onCategoryTap(cat['label'] as String),
              child: Column(
                children: [
                  Container(
                    height: 72,
                    width: 72,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(cat['image'] as String, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    cat['label'] as String,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: Responsive.scaleFontSize(context, 11),
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF374151),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _PromoBanner extends StatelessWidget {
  final bool isBangla;
  const _PromoBanner({this.isBangla = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: const Color(0xFF059669),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF059669).withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(CareOnAssets.emergencyNursingPng, height: 200),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isBangla ? 'পেশাদার নার্সিং সেবা' : 'Professional Nursing\nCare at Home',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Responsive.scaleFontSize(context, 20),
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 18),
              _AnimatedBookNowButton(
                isBangla: isBangla,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => NursingServiceDetailsScreen(isBangla: isBangla),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BasicHealthCheckupRow extends StatelessWidget {
  final VoidCallback? onViewAll;
  final bool isBangla;
  const _BasicHealthCheckupRow({this.onViewAll, this.isBangla = false});

  @override
  Widget build(BuildContext context) {
    final cards = [
      {
        'image': CareOnAssets.physicalWellnessPng,
        'title': isBangla ? 'প্রাথমিক স্বাস্থ্য পরীক্ষা' : 'Basic health\ncheckup'
      },
      {
        'image': CareOnAssets.womenHealthPng,
        'title': isBangla ? 'নারী স্বাস্থ্য পরীক্ষা' : 'Women health\ncheckup'
      },
    ];

    return Column(
      children: [
        _SectionHeader(
          title: isBangla ? 'স্বাস্থ্য পরীক্ষা প্যাকেজ' : 'Health Checkup Packages',
          onAction: onViewAll,
          isBangla: isBangla,
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: Responsive.scale(context, 190),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: cards.length,
            separatorBuilder: (_, _) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final card = cards[index];
              return Container(
                width: Responsive.scale(context, 130),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 18,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    Expanded(
                      child: Image.asset(
                        card['image'] as String,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      child: Text(
                        card['title'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: Responsive.scaleFontSize(context, 12),
                          color: const Color(0xFF111827),
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _AnimatedBookNowButton extends StatefulWidget {
  final bool isBangla;
  final VoidCallback? onTap;
  const _AnimatedBookNowButton({this.isBangla = false, this.onTap});

  @override
  State<_AnimatedBookNowButton> createState() => _AnimatedBookNowButtonState();
}

class _AnimatedBookNowButtonState extends State<_AnimatedBookNowButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            widget.isBangla ? 'এখনই বুক করুন' : 'Book Now',
            style: const TextStyle(color: Color(0xFF059669), fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }
}

class _RecentActivitySection extends StatelessWidget {
  final bool isBangla;
  const _RecentActivitySection({this.isBangla = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          title: isBangla ? 'সাম্প্রতিক কার্যক্রম' : 'Recent Activity',
          isBangla: isBangla,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.history_rounded, color: Color(0xFF059669), size: 28),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  isBangla ? 'কোনো সাম্প্রতিক কার্যক্রম নেই' : 'No recent activities found',
                  style: const TextStyle(color: Color(0xFF6B7280), fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
