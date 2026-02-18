import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Color(0xff0C6BBC),
                      size: 20,
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Privacy Policy',
                        style: TextStyle(
                          color: Color(0xff0C6BBC),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20), // balance center title
                ],
              ),
            ),

            /// ===== Body =====
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Last updated: March 2024',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff6B7280),
                        ),
                      ),

                      SizedBox(height: 20),

                      _SectionTitle('1. Introduction'),
                      _SectionBody(
                        'This Privacy Policy explains how our e-commerce application '
                        'collects, uses, and protects your personal information when you use our app.',
                      ),

                      _SectionTitle('2. Information We Collect'),
                      _SectionBody(
                        'We may collect personal data such as name, email address, phone number, '
                        'shipping address, billing address, payment information, order history, '
                        'and app usage data.',
                      ),

                      _SectionTitle('3. How We Use Your Information'),
                      _SectionBody(
                        'We use your information to process orders, deliver products, improve our services, '
                        'communicate with you, and provide customer support.',
                      ),

                      _SectionTitle('4. Data Security'),
                      _SectionBody(
                        'We take appropriate security measures to protect your personal data against '
                        'unauthorized access, alteration, or disclosure.',
                      ),

                      _SectionTitle('5. Third-Party Services'),
                      _SectionBody(
                        'We may use trusted third-party services such as payment gateways and analytics tools, '
                        'which have their own privacy policies.',
                      ),

                      _SectionTitle('6. Your Rights'),
                      _SectionBody(
                        'You have the right to access, update, or request deletion of your personal information, '
                        'and you may opt out of promotional messages at any time.',
                      ),

                      _SectionTitle('7. Changes to This Policy'),
                      _SectionBody(
                        'We may update this Privacy Policy from time to time. '
                        'Any changes will be available inside the app.',
                      ),

                      _SectionTitle('8. Contact Us'),
                      _SectionBody(
                        'If you have any questions about this Privacy Policy, '
                        'please contact us through the app support section.',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// =====================
/// Section Title
/// =====================
class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xff0C6BBC),
        ),
      ),
    );
  }
}

/// =====================
/// Section Body
/// =====================
class _SectionBody extends StatelessWidget {
  final String text;
  const _SectionBody(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        height: 1.7,
        color: Color(0xff1E1E1E),
      ),
    );
  }
}
