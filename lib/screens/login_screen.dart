import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/data/network_caller.dart';
import 'package:task_manager/data/network_response.dart';
import 'package:task_manager/screens/forgot_password_screen.dart';
import 'package:task_manager/screens/main_bottom_nav_screen.dart';
import 'package:task_manager/screens/sign_up_screen.dart';
import 'package:task_manager/widget/body_background.dart';
import 'package:task_manager/widget/snack_messege.dart';

import '../controller/auth_controller.dart';
import '../data/user_models.dart';
import '../data/utility/urls.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _loginInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BodyBackground(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Get Start With',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailTEController,
                    decoration: InputDecoration(hintText: 'Email'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter valid Email';
                      }
                      return null;
                    },
                  ),

                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Enter Your Password'),
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter Your Password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                      width: double.infinity,

                      child: Visibility(
                        visible: _loginInProgress == false,
                        child: ElevatedButton(
                            onPressed: login,
                            child: Icon(Icons.arrow_circle_right_outlined)),
                      )),
                  Center(
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPasswordScreen()));
                        },
                        child: Text('Forgot Password?')),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't Have Accoount?",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 16),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
  Future<void> login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _loginInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller().postRequest(Urls.login, body: {
      'email' : _emailTEController.text.trim(),
      'password' : _passwordTEController.text,
    });
    _loginInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      // await AuthController.saveUserInformation(
      //     response.jsonResponse['token'], UserModel.fromJson(response.jsonResponse['data']));
      if (mounted) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MainBottomNavScreen()));
      }
    } else {
      if (response.statusCode == 401) {
        if (mounted) {
          showSnackMessage(context, 'Please check email/password');
        }
      } else {
        if (mounted) {
          showSnackMessage(context, 'Login failed. Try again');
        }
      }
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}