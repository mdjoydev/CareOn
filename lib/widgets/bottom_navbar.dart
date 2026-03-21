import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
    this.onSosTap,
    this.isBangla = false,
  });

  final int currentIndex;
  final ValueChanged<int> onTabSelected;
  final VoidCallback? onSosTap;
  final bool isBangla;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _BottomNavItem(
                icon: Icons.home_outlined,
                activeIcon: Icons.home_rounded,
                label: isBangla ? 'হোম' : 'Home',
                isActive: currentIndex == 0,
                onTap: () => onTabSelected(0),
              ),
              _BottomNavItem(
                icon: Icons.search_rounded,
                activeIcon: Icons.search_rounded,
                label: isBangla ? 'সেবা' : 'Services',
                isActive: currentIndex == 1,
                onTap: () => onTabSelected(1),
              ),
              // Spacer for SOS button
              const SizedBox(width: 65),
              _BottomNavItem(
                icon: Icons.favorite_border_rounded,
                activeIcon: Icons.favorite_rounded,
                label: isBangla ? 'পরামর্শ' : 'Tips',
                isActive: currentIndex == 3,
                onTap: () => onTabSelected(3),
              ),
              _BottomNavItem(
                icon: Icons.person_outline_rounded,
                activeIcon: Icons.person_rounded,
                label: isBangla ? 'প্রোফাইল' : 'Profile',
                isActive: currentIndex == 4,
                onTap: () => onTabSelected(4),
              ),
            ],
          ),
          // Floating SOS Button effect (50% out)
          Positioned(
            top: -25, // Adjust this value to control how much it pops out
            child: GestureDetector(
              onTap: onSosTap,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE11D48),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFE11D48).withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.call_rounded, color: Colors.white, size: 28),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isBangla ? 'জরুরি' : 'SOS',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFE11D48),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? const Color(0xFF059669) : const Color(0xFF94A3B8);

    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: SizedBox(
        width: 65,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color: color,
              size: 26,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
