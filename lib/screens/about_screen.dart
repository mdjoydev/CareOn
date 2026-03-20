import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';
import '../widgets/section_header.dart';

class AboutScreen extends StatelessWidget {
  final bool isBangla;
  const AboutScreen({super.key, this.isBangla = false});

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse('https://bdtechture.com/');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: isBangla ? 'কেয়ারঅন' : 'CareOn'),
          const SizedBox(height: 12),
          Text(
            isBangla 
                ? 'কেয়ারঅন বাংলাদেশে আপনার দোরগোড়ায় পেশাদার স্বাস্থ্যসেবা প্রদান করে। নিরাপদ এবং নির্ভরযোগ্য যত্ন নিশ্চিত করতে সমস্ত প্রদানকারী যাচাইকৃত, প্রশিক্ষিত এবং ব্যাকগ্রাউন্ড-চেক করা।\n\n'
                  'সেবাগুলোর মধ্যে রয়েছে বয়স্ক এবং হাসপাতাল পরবর্তী যত্নের জন্য পরিচর্যাকারী, শিশুর যত্ন, রোগীর পরিচারক, ফিজিওথেরাপি, নার্সিং, বাড়িতে মেডিকেল টেস্ট, অ্যাম্বুলেন্স সহায়তা, বাড়িতে ডাক্তার ভিজিট এবং জরুরি নার্সিং সেবা।\n\n'
                  'যত্ন, সবসময় সচল।'
                : 'CareOn provides professional healthcare services at your doorstep in Bangladesh. '
                  'All providers are verified, trained and background-checked to ensure safe and reliable care.\n\n'
                  'Services include caregivers for elderly and post-hospital care, baby care, patient attendants, physiotherapy, '
                  'nursing, medical tests at home, ambulance support, doctor visits at home, and emergency nursing service.\n\n'
                  'Care, always on.',
            style: const TextStyle(color: Colors.black54, height: 1.4),
          ),
          const SizedBox(height: 24),
          InkWell(
            onTap: _launchUrl,
            child: Text(
              isBangla ? 'একটি টেকচার ব্র্যান্ড' : 'A Techture brand',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: CareOnApp.careOnBlue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
