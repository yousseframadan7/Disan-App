import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// ===== Back Button =====
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Color(0xff0C6BBC),
                    size: 20,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// ===== Logo =====
              const Icon(
                Icons.shopping_bag_outlined,
                size: 70,
                color: Color(0xff0C6BBC),
              ),

              const SizedBox(height: 16),

              /// ===== Welcome Text =====
              const Text(
                'Welcome to Disan!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff0C6BBC),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Your trusted online shopping destination.',
                style: TextStyle(fontSize: 14, color: Color(0xff6B7280)),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              /// ===== Card Content =====
              Container(
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
                      'Who We Are',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff0C6BBC),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Disan is a modern e-commerce platform designed to make online shopping simple, secure, and enjoyable. '
                      'We provide high-quality products at competitive prices.',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.7,
                        color: Color(0xff1E1E1E),
                      ),
                    ),

                    SizedBox(height: 24),

                    Text(
                      'Our Mission',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff0C6BBC),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Our mission is to deliver exceptional service, secure payments, '
                      'fast shipping, and a smooth shopping experience for every customer.',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.7,
                        color: Color(0xff1E1E1E),
                      ),
                    ),

                    SizedBox(height: 24),

                    Text(
                      'Why Choose Disan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff0C6BBC),
                      ),
                    ),
                    SizedBox(height: 12),

                    _BulletPoint('Secure and reliable payments'),
                    _BulletPoint('Fast delivery'),
                    _BulletPoint('Quality products'),
                    _BulletPoint('Friendly customer support'),

                    SizedBox(height: 30),

                    Center(
                      child: Text(
                        'Thank you for choosing Disan.',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff0C6BBC),
                        ),
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
}

class _BulletPoint extends StatelessWidget {
  final String text;
  const _BulletPoint(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(fontSize: 16, color: Color(0xff0C6BBC)),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                height: 1.6,
                color: Color(0xff1E1E1E),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
