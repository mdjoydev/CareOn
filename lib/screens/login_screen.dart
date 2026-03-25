import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/assets.dart';
import '../core/state/user_session.dart';
import 'home/home_screen.dart';
import 'otp_verification_screen.dart';

class LoginScreen extends StatefulWidget {
  final bool initialIsBangla;
  const LoginScreen({super.key, this.initialIsBangla = false});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isSignIn = true;
  bool _rememberMe = false;
  late bool _isBangla;

  final _signInEmailController = TextEditingController();
  final _signInPasswordController = TextEditingController();

  final _signUpNameController = TextEditingController();
  final _signUpPhoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isBangla = widget.initialIsBangla;
  }

  @override
  void dispose() {
    _signInEmailController.dispose();
    _signInPasswordController.dispose();
    _signUpNameController.dispose();
    _signUpPhoneController.dispose();
    super.dispose();
  }

  void _toggleLanguage() {
    setState(() {
      _isBangla = !_isBangla;
    });
  }

  void _goToHome() {
    final email = _signInEmailController.text.trim();
    final password = _signInPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isBangla 
            ? 'দয়া করে আপনার ইমেল/ফোন এবং পাসওয়ার্ড দিন।' 
            : 'Please enter your email/phone and password.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    final session = UserSession.instance;
    if (session.name == null || session.name!.isEmpty) {
      session.name = email.split('@')[0];
    }

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => HomeScreen(isBangla: _isBangla)),
      (route) => false,
    );
  }

  void _getVerificationCode() {
    final name = _signUpNameController.text.trim();
    final phone = _signUpPhoneController.text.trim();

    if (name.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_isBangla 
          ? 'দয়া করে আপনার নাম এবং ফোন নম্বর দিন।' 
          : 'Please fill in your name and phone number.')),
      );
      return;
    }

    final session = UserSession.instance;
    session.name = name;
    session.phone = phone;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => OtpVerificationScreen(phoneNumber: phone),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 16),
                // Language Switcher
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: _toggleLanguage,
                    child: Container(
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
                          ),
                          children: [
                            TextSpan(
                              text: 'EN',
                              style: TextStyle(color: !_isBangla ? const Color(0xFF15803D) : Colors.grey),
                            ),
                            const TextSpan(
                              text: ' / ',
                              style: TextStyle(color: Colors.grey),
                            ),
                            TextSpan(
                              text: 'বাং',
                              style: TextStyle(color: _isBangla ? const Color(0xFF15803D) : Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Logo
                Image.asset(
                  CareOnAssets.logoPng,
                  height: 100,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 12),
                Text(
                  _isBangla ? 'কেয়ার-অন এ স্বাগতম' : 'Welcome to CareOn',
                  style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF0F172A),
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _isBangla 
                    ? 'সেবা বুক করতে সাইন ইন করুন বা অ্যাকাউন্ট তৈরি করুন' 
                    : 'Sign in or create an account to book services',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: const Color(0xFF64748B),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 32),
                // Tabs
                Container(
                  height: 54,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      _buildTabButton(_isBangla ? 'সাইন ইন' : 'Sign In', _isSignIn, () {
                        setState(() => _isSignIn = true);
                      }),
                      _buildTabButton(_isBangla ? 'সাইন আপ' : 'Sign Up', !_isSignIn, () {
                        setState(() => _isSignIn = false);
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // Form
                _isSignIn ? _buildSignInForm() : _buildSignUpForm(),
                const SizedBox(height: 32),
                // Divider
                Row(
                  children: [
                    const Expanded(child: Divider(color: Color(0xFFE2E8F0))),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        _isBangla ? 'অথবা এর মাধ্যমে' : 'OR SIGN IN WITH',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF94A3B8),
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider(color: Color(0xFFE2E8F0))),
                  ],
                ),
                const SizedBox(height: 24),
                // Google Login
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 56),
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      backgroundColor: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.network(
                          'https://www.gstatic.com/images/branding/product/2x/googleg_48dp.png',
                          height: 24,
                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.g_mobiledata, color: Colors.blue, size: 24),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Google',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF334155),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // Bottom Professional Banner
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0FDF4),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFDCFCE7)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        _isBangla 
                          ? 'আপনি কি স্বাস্থ্যসেবা পেশাদার?' 
                          : 'Are you a healthcare professional?',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: const Color(0xFF475569),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                          children: [
                            TextSpan(
                              text: _isBangla ? 'সেবা প্রদানকারী হিসেবে যোগ দিন' : 'Join as a Care Provider',
                              style: const TextStyle(color: Color(0xFF00A66C)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton(String label, bool isActive, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    )
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: isActive ? const Color(0xFF00A66C) : const Color(0xFF94A3B8),
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(_isBangla ? 'ইমেল অথবা ফোন' : 'Email or Phone'),
        const SizedBox(height: 8),
        _buildTextField(
          controller: _signInEmailController,
          hintText: _isBangla ? 'আপনার ইমেল' : 'your@email.com',
        ),
        const SizedBox(height: 20),
        _buildLabel(_isBangla ? 'পাসওয়ার্ড' : 'Password'),
        const SizedBox(height: 8),
        _buildTextField(
          controller: _signInPasswordController,
          hintText: '••••••••',
          isPassword: true,
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 22,
                  width: 22,
                  child: Checkbox(
                    value: _rememberMe,
                    activeColor: const Color(0xFF00A66C),
                    onChanged: (v) => setState(() => _rememberMe = v!),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    side: const BorderSide(color: Color(0xFFCBD5E1), width: 1.5),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  _isBangla ? 'আমাকে মনে রাখুন' : 'Remember me',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF64748B),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                _isBangla ? 'পাসওয়ার্ড ভুলে গেছেন?' : 'Forgot password?',
                style: GoogleFonts.inter(
                  color: const Color(0xFF00A66C),
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        _buildPrimaryButton(_isBangla ? 'সাইন ইন' : 'Sign In', _goToHome),
      ],
    );
  }

  Widget _buildSignUpForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(_isBangla ? 'পুরো নাম *' : 'Full Name *'),
        const SizedBox(height: 8),
        _buildTextField(controller: _signUpNameController, hintText: _isBangla ? 'আপনার নাম' : 'John Doe'),
        const SizedBox(height: 20),
        _buildLabel(_isBangla ? 'ফোন নম্বর *' : 'Phone Number *'),
        const SizedBox(height: 8),
        _buildTextField(controller: _signUpPhoneController, hintText: '+880 1XXX...'),
        const SizedBox(height: 32),
        _buildPrimaryButton(_isBangla ? 'ভেরিফিকেশন কোড পান' : 'Get verification code', _getVerificationCode),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: const Color(0xFF334155),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: GoogleFonts.inter(fontSize: 15, color: const Color(0xFF0F172A)),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 13),
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFF1F5F9)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFF1F5F9)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF00A66C), width: 1.5),
        ),
      ),
    );
  }

  Widget _buildPrimaryButton(String text, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00A66C).withValues(alpha: 0.2),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00A66C),
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 58),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 0,
        ),
        child: Text(
          text,
          style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
