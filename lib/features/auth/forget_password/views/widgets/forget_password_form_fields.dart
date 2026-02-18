import 'package:disan/core/components/custom_elevated_button.dart';
import 'package:disan/core/components/custom_text_form_field_with_title.dart';
import 'package:disan/core/components/show_toast.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/auth/reset_password_otp_screen/reset_password_otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ForgetPasswordFormFields extends StatefulWidget {
  const ForgetPasswordFormFields({super.key});

  @override
  State<ForgetPasswordFormFields> createState() =>
      _ForgetPasswordFormFieldsState();
}

class _ForgetPasswordFormFieldsState extends State<ForgetPasswordFormFields> {
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      showToast("Enter your email");
      return;
    }

    setState(() => isLoading = true);

    try {
      await Supabase.instance.client.auth.resetPasswordForEmail(
        email,
        redirectTo: 'disan://reset',
      );

      showToast("OTP sent to your email");

      // روح لصفحة كتابة الكود
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ResetPasswordOtpScreen(email: email)),
      );
    } catch (e) {
      showToast("Error sending OTP");
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormFieldWithTitle(
          controller: emailController,
          hintText: "Enter your email",
          title: "Email",
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: SizeConfig.height * 0.015,
            horizontal: SizeConfig.width * 0.05,
          ),
          child: const Divider(),
        ),
        SizedBox(height: SizeConfig.height * 0.1),
        CustomElevatedButton(
          name: isLoading ? "Loading..." : "Send Code",
          onPressed: isLoading ? null : _sendOtp,
        ),
      ],
    );
  }
}
