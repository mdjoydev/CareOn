import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../core/state/user_session.dart';
import '../core/state/language_provider.dart';
// import '../main.dart';
import 'login_screen.dart';
import 'support_screen.dart';

class ProfileScreen extends StatelessWidget {
  final VoidCallback? onLanguageToggle;

  const ProfileScreen({
    super.key,
    this.onLanguageToggle,
  });

/*       Future<void> _showNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'care_on_channel_id',
      'CareOn Notifications',
      channelDescription: 'Notifications for CareOn app',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'CareOn Notification',
      'This is a test notification from your CareOn app!',
      notificationDetails,
    );
  }       */                  //  This is the test notification button    >>>>>Commenting this section for now as it's not implemented yet<<<<

/*     void _clearCache(BuildContext context, bool isBangla) {
    // Show a loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const CircularProgressIndicator(color: Color(0xFF059669)),
        ),
      ),
    );

    // Simulate cache clearing
    Future.delayed(const Duration(seconds: 2), () {
      if (!context.mounted) return;
      Navigator.pop(context); // Close loading dialog

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isBangla ? 'ক্যাশে সফলভাবে পরিষ্কার করা হয়েছে!' : 'Cache cleared successfully!'),
          backgroundColor: const Color(0xFF059669),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    });
  }       */                 //  This is clear cash button    >>>>>Commenting this section for now as it's not implemented yet<<<<

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LanguageProvider>(context);
    final isBangla = provider.isBangla;

    final session = Provider.of<UserSession>(context);
    final name = session.name?.trim();
    final phone = session.phone?.trim();

    final displayName = name != null && name.isNotEmpty
        ? name
        : (isBangla ? 'জয় চৌধুরী' : 'Joy Chowder');
    final displayPhone = phone != null && phone.isNotEmpty
        ? phone
        : '+880 1712 345678';

    return Material(
      color: const Color(0xFFF9FAFB),
      child: Column(
        children: [
          // Header Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 40),
            decoration: const BoxDecoration(
              color: Color(0xFF059669),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 38,
                    backgroundColor: const Color(0xFFDCFCE7),
                    backgroundImage: session.photoPath != null
                        ? FileImage(File(session.photoPath!))
                        : null,
                    child: session.photoPath == null
                        ? const Icon(
                      Icons.person_outline_rounded,
                      color: Color(0xFF059669),
                      size: 40,
                    )
                        : null,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayName,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        displayPhone,
                        style: GoogleFonts.inter(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      builder: (_) => const _EditProfileSheet(),
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.edit_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content Section
          Expanded(
            child: Transform.translate(
              offset: const Offset(0, -20),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: ListView(
                  padding: const EdgeInsets.all(24),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          /*    _buildProfileTile(
                            icon: Icons.calendar_today_outlined,
                            title: isBangla ? 'আমার বুকিং' : 'My Bookings',
                            iconColor: const Color(0xFF3B82F6),
                            bgColor: const Color(0xFFEFF6FF),
                            onTap: () {},
                          ),  */                    //  This is the my booking button    >>>>>Commenting this section for now as it's not implemented yet<<<<
                          _buildDivider(),
                          _buildLanguageTile(isBangla: isBangla),
                          _buildDivider(),
                          /*       _buildProfileTile(
                            icon: Icons.cleaning_services_rounded,
                            title: isBangla ? 'ক্যাশে পরিষ্কার করুন' : 'Clear Cache',
                            iconColor: const Color(0xFF8B5CF6),
                            bgColor: const Color(0xFFF5F3FF),
                            onTap: () => _clearCache(context, isBangla),
                          ),
                          _buildDivider(),
                          _buildProfileTile(
                            icon: Icons.notifications_active_outlined,
                            title: isBangla ? 'টেস্ট নোটিফিকেশন' : 'Test Notification',
                            iconColor: const Color(0xFFEC4899),
                            bgColor: const Color(0xFFFDF2F8),
                            onTap: _showNotification,
                          ),
                          _buildDivider(),
                          _buildProfileTile(
                            icon: Icons.person_outline_rounded,
                            title: isBangla ? 'পরিবারের সদস্য' : 'Family Members',
                            iconColor: const Color(0xFF10B981),
                            bgColor: const Color(0xFFECFDF5),
                            onTap: () {},
                          ),
                          _buildDivider(),
                          _buildProfileTile(
                            icon: Icons.location_on_outlined,
                            title: isBangla ? 'সংরক্ষিত ঠিকানা' : 'Saved Addresses',
                            iconColor: const Color(0xFF0EA5E9),
                            bgColor: const Color(0xFFF0F9FF),
                            onTap: () {},
                          ),
                          _buildDivider(),
                          _buildProfileTile(
                            icon: Icons.payment_outlined,
                            title: isBangla ? 'পেমেন্ট পদ্ধতি' : 'Payment Methods',
                            iconColor: const Color(0xFFF59E0B),
                            bgColor: const Color(0xFFFFFBEB),
                            onTap: () {},
                          ),                 */                     //  This are some other buttons    >>>>>Commenting this section for now as it's not implemented yet<<<<
                          _buildDivider(),
                          _buildProfileTile(
                            icon: Icons.help_outline_rounded,
                            title: isBangla ? 'সাপোর্ট ও সহায়তা' : 'Support & Help',
                            iconColor: const Color(0xFFF43F5E),
                            bgColor: const Color(0xFFFFF1F2),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => SupportScreen(isBangla: isBangla),
                                ),
                              );
                            },
                            isLast: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    GestureDetector(
                      onTap: () async {
                        await UserSession.instance.clearSession();
                        if (!context.mounted) return;
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                          (route) => false,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF1F2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.logout_rounded,
                              color: Color(0xFFE11D48),
                              size: 22,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              isBangla ? 'লগআউট' : 'Logout',
                              style: GoogleFonts.inter(
                                color: const Color(0xFFE11D48),
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageTile({required bool isBangla}) {
    return InkWell(
      onTap: onLanguageToggle,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Row(
          children: [
            const Icon(Icons.language_rounded, color: Color(0xFF0EA5E9), size: 20),
            const SizedBox(width: 16),
            Text(
              isBangla ? 'ভাষা পরিবর্তন করুন' : 'Change Language',
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1F2937),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDF4),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFDCFCE7)),
              ),
              child: RichText(
                text: TextSpan(
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF15803D),
                  ),
                  children: [
                    TextSpan(
                      text: isBangla ? 'বাং' : 'EN',
                    ),
                    const TextSpan(
                      text: ' / ',
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextSpan(
                      text: isBangla ? 'EN' : 'বাং',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileTile({
    required IconData icon,
    required String title,
    required Color iconColor,
    required Color bgColor,
    required VoidCallback onTap,
    bool isLast = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: isLast
          ? const BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24))
          : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1F2937),
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFFD1D5DB),
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Divider(
        height: 1,
        color: Color(0xFFF3F4F6),
      ),
    );
  }
}

class _EditProfileSheet extends StatefulWidget {
  const _EditProfileSheet();

  @override
  State<_EditProfileSheet> createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends State<_EditProfileSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  String? _photoPath;

  @override
  void initState() {
    super.initState();
    final session = UserSession.instance;
    _nameController = TextEditingController(text: session.name);
    _phoneController = TextEditingController(text: session.phone);
    _emailController = TextEditingController(text: session.email);
    _photoPath = session.photoPath;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (picked == null) return;
    setState(() {
      _photoPath = picked.path;
    });
  }

  Future<void> _save() async {
    final session = UserSession.instance;
    await session.saveSession(
      name: _nameController.text.trim().isEmpty ? null : _nameController.text.trim(),
      phone: _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
      email: _emailController.text.trim().isEmpty ? null : _emailController.text.trim(),
      photoPath: _photoPath,
    );
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              Text(
                'Edit profile',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 32,
                      backgroundColor: const Color(0xFFDCFCE7),
                      backgroundImage: _photoPath != null ? FileImage(File(_photoPath!)) : null,
                      child: _photoPath == null
                          ? const Icon(Icons.camera_alt_rounded, color: Color(0xFF059669))
                          : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: _pickImage,
                    child: Text(
                      'Change photo',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF059669),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full name',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone number',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email address',
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _save,
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
