import 'package:disan/core/components/custom_elevated_button.dart';
import 'package:disan/core/components/custom_text_form_field_with_title.dart';
import 'package:disan/core/components/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ResetPasswordOtpScreen extends StatefulWidget {
  final String email;

  const ResetPasswordOtpScreen({super.key, required this.email});

  @override
  State<ResetPasswordOtpScreen> createState() => _ResetPasswordOtpScreenState();
}

class _ResetPasswordOtpScreenState extends State<ResetPasswordOtpScreen> {
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> _verifyAndChangePassword() async {
    final otp = otpController.text.trim();
    final newPassword = passwordController.text.trim();

    if (otp.isEmpty || newPassword.isEmpty) {
      showToast("Enter code and new password");
      return;
    }

    setState(() => isLoading = true);

    try {
      // verify otp
      await Supabase.instance.client.auth.verifyOTP(
        email: widget.email,
        token: otp,
        type: OtpType.email,
      );

      // update password
      await Supabase.instance.client.auth.updateUser(
        UserAttributes(password: newPassword),
      );

      showToast("Password changed successfully");

      Navigator.pop(context);
      Navigator.pop(context);
    } catch (e) {
      showToast("Invalid code or error");
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reset Password")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomTextFormFieldWithTitle(
              controller: otpController,
              hintText: "Enter code from email",
              title: "OTP Code",
            ),
            const SizedBox(height: 20),
            CustomTextFormFieldWithTitle(
              controller: passwordController,
              hintText: "Enter new password",
              title: "New Password",
            ),
            const SizedBox(height: 40),
            CustomElevatedButton(
              name: isLoading ? "Loading..." : "Change Password",
              onPressed: isLoading ? null : _verifyAndChangePassword,
            ),
          ],
        ),
      ),
    );
  }
}
