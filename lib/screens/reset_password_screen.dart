import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/reset_pass_controller.dart';
import 'package:task_manager/data/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/screens/login_screen.dart';
import 'package:task_manager/widget/body_background.dart';


class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String otp;

  const ResetPasswordScreen({super.key, required this.email, required this.otp,});


  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Text(
                    'Set Password',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    'Minimum password length should be more than 8 letters',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: _passwordTEController,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  TextFormField(
                    controller: _confirmPasswordTEController,
                    decoration: const InputDecoration(
                      hintText: 'Confirm Password',
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: GetBuilder<ResetPassController>(
                      builder: (resetPassController) {
                        return ElevatedButton(
                          onPressed: resetPass,
                          child: const Text('Confirm'),
                        );
                      }
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Have an account?",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                                  (route) => false);
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> resetPass() async {
    String val = _passwordTEController.text.trim();
    final response = await NetworkCaller()
        .postRequest(Urls.recoveryResetPass,body: {"email":widget.email,"OTP":widget.otp,"password": _passwordTEController.text},);
    if (response.isSuccess) {
      Get.offAll(const LoginScreen());
    }
  }
}