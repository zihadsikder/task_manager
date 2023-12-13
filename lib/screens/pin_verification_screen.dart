import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/controller/pin_verfication_controller.dart';
import 'package:task_manager/screens/login_screen.dart';
import 'package:task_manager/screens/reset_password_screen.dart';
import 'package:task_manager/widget/body_background.dart';

import '../data/network_caller.dart';
import '../data/utility/urls.dart';
import '../widget/snack_messege.dart';

class PinVerificationScreen extends StatefulWidget {

  final String email;

  PinVerificationScreen({super.key,  this.email = ''});

  static get get => null;

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {

  final otpController = TextEditingController();

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
                    'Pin Verification',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    'A 6 digit OTP will be sent to your email address',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  PinCodeTextField(
                    controller: otpController,
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      activeColor: Colors.green,
                      selectedFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    onCompleted: (v) {
                      print("Completed");
                    },
                    onChanged: (value) {},
                    beforeTextPaste: (text) {
                      return true;
                    },
                    appContext: context,
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter valid OTP';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: GetBuilder<PinVerificationController>(
                      builder: (pinVerficationController) {
                        return ElevatedButton(
                          onPressed: CreateOTP,
                          child: const Text('Verify'),
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
  Future<void> CreateOTP ()async {
    String val = otpController.text.trim();
    //widget.showProgress(true);
    final response = await NetworkCaller()
        .getRequest('${Urls.recoveryVerifyOTP}/${widget.email}/$val');
    if (response.isSuccess) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>  ResetPasswordScreen(email: val, otp: val,),
        ),
      );
    }
    else{
      showSnackMessage(context, 'Error : ${response.statusCode}', true);
      return;
    }
    // widget.showProgress(false);
  }
}