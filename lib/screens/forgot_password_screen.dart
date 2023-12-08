import 'package:flutter/material.dart';
import 'package:task_manager/screens/pin_verification_screen.dart';
import 'package:task_manager/widget/body_background.dart';

import '../data/network_caller.dart';
import '../data/utility/urls.dart';
import '../widget/snack_messege.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final emailInputController = TextEditingController();

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
                    'Your Email Address',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    'A 6 digit OTP will be sent to your email address',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: emailInputController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async{

                        String val = emailInputController.text.trim();

                        if(val.isEmpty){
                          showSnackMessage(context, 'enter a valid email', true);
                          return;
                        }

                        //widget.showProgress(true);
                        final response = await NetworkCaller()
                            .getRequest('${Urls.recoveryVerifyEmail}/$val');
                        if (response.isSuccess) {

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  PinVerificationScreen(email: val,),

                            ),
                          );
                        }else{
                          showSnackMessage(context, 'Error : ${response.statusCode}', true);
                          return;
                        }
                       // widget.showProgress(false);



                      },
                      child: const Icon(Icons.arrow_circle_right_outlined),
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Have an account?", style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54
                      ),),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
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
}