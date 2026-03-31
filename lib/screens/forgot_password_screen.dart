import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final bool isBangla;
  const ForgotPasswordScreen({super.key, this.isBangla = false});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.isBangla
                          ? 'আপনার পাসওয়ার্ড ভুলে গেছেন? সমস্যা নেই। শুধু আমাদের আপনার ইমেল ঠিকানাটি জানান এবং আমরা আপনাকে একটি পাসওয়ার্ড রিসেট লিঙ্ক পাঠাব যা আপনাকে একটি নতুন চয়ন করতে দিবে।'
                          : 'Forgot your password? No problem. Just let us know your email address and we will email you a password reset link that will allow you to choose a new one.',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: const Color(0xFF475569),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildLabel(widget.isBangla ? 'ইমেল *' : 'Email *'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _emailController,
                      hintText: widget.isBangla ? 'ইমেল লিখুন' : 'Enter Email',
                    ),
                    const SizedBox(height: 24),
                    Align(
                      alignment: Alignment.centerRight,
                      child: _buildPrimaryButton(
                        widget.isBangla ? 'পাসওয়ার্ড রিসেট লিঙ্ক ইমেল করুন' : 'Email Password Reset Link',
                        () {
                          // Handle reset password logic
                          if (_emailController.text.isNotEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(widget.isBangla 
                                  ? 'পাসওয়ার্ড রিসেট লিঙ্ক আপনার ইমেলে পাঠানো হয়েছে।' 
                                  : 'Password reset link sent to your email.'),
                                backgroundColor: const Color(0xFF00A66C),
                              ),
                            );
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
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
  }) {
    return TextField(
      controller: controller,
      style: GoogleFonts.inter(fontSize: 15, color: const Color(0xFF0F172A)),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 13),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF2DD4BF), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF2DD4BF), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF00A66C), width: 1.5),
        ),
      ),
    );
  }

  Widget _buildPrimaryButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0F172A),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );
  }
}
