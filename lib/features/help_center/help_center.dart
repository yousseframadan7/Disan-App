import 'package:flutter/material.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            /// ===== Fake AppBar =====
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
                        'Help Center',
                        style: TextStyle(
                          color: Color(0xff0C6BBC),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
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
                        'How can we help you?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff1E1E1E),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Find answers to common questions about orders, payments, shipping, and returns.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xff6B7280),
                        ),
                      ),

                      SizedBox(height: 24),

                      _HelpTile(
                        title: 'How can I track my order?',
                        body:
                            'Go to "My Orders" from your profile. Select the order you want to track and you will see the current shipping status and tracking details.',
                      ),

                      _HelpTile(
                        title: 'How do I cancel an order?',
                        body:
                            'You can cancel your order before it is shipped by going to "My Orders" and selecting the cancel option. Once shipped, cancellation is no longer available.',
                      ),

                      _HelpTile(
                        title: 'What payment methods are accepted?',
                        body:
                            'We accept credit cards, debit cards, and other secure online payment methods available at checkout.',
                      ),

                      _HelpTile(
                        title: 'How do I return a product?',
                        body:
                            'If you are not satisfied with your purchase, you can request a return within the allowed return period from the order details page.',
                      ),

                      _HelpTile(
                        title: 'How long does shipping take?',
                        body:
                            'Shipping times vary depending on your location. Estimated delivery time is shown during checkout and inside your order details.',
                      ),

                      _HelpTile(
                        title: 'I did not receive my order. What should I do?',
                        body:
                            'Please check your order tracking information first. If the issue continues, contact our support team for assistance.',
                      ),

                      SizedBox(height: 24),

                      Divider(),

                      SizedBox(height: 16),

                      Text(
                        'Still need help?',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff0C6BBC),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Contact our support team through the app and we will be happy to assist you.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xff6B7280),
                        ),
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

class _HelpTile extends StatelessWidget {
  final String title;
  final String body;

  const _HelpTile({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      childrenPadding: const EdgeInsets.only(bottom: 12),
      iconColor: Color(0xff0C6BBC),
      collapsedIconColor: Color(0xff0C6BBC),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xff1E1E1E),
        ),
      ),
      children: [
        Text(
          body,
          style: const TextStyle(
            fontSize: 13,
            height: 1.6,
            color: Color(0xff6B7280),
          ),
        ),
      ],
    );
  }
}
