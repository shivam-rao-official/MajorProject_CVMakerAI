import 'package:cvmaker_app_sarah_proj/utils/otp_timer.dart';
import 'package:cvmaker_app_sarah_proj/widgets/genericBtn.dart';
import 'package:cvmaker_app_sarah_proj/widgets/textBtn.dart';
import 'package:cvmaker_app_sarah_proj/widgets/textFields.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 33.0, vertical: 33),
          child: Form(
            key: _loginFormKey,
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "LOGIN",
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff343434),
                      ),
                    ),
                  ),
                  const SizedBox(height: 127),
                  CustomTextFields(
                    controller: _emailController,
                    icon: Icons.alternate_email_outlined,
                    hintText: "Enter Email Here",
                    keyBoardType: TextInputType.emailAddress,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Email is required";
                      }
                      return null;
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: CustomTextButton(
                      btnLabel: "Get OTP",
                      onPressed: () {
                        // Navigator.of(context).pushReplacementNamed("/register");
                        // const OtpTimer(otpTimer: 30,);
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomTextFields(
                    controller: _otpController,
                    icon: Icons.numbers_outlined,
                    hintText: "Enter OTP Here",
                    keyBoardType: TextInputType.number,
                    maxLength: 4,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "OTP is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    onPressed: () {
                      if (_loginFormKey.currentState!.validate()) {
                        Navigator.of(context).pushReplacementNamed("/home");
                      }
                    },
                    btnLabel: "LOGIN",
                  ),
                  const SizedBox(height: 30),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Not registered yet?"),
                      CustomTextButton(
                        btnLabel: "Register",
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed("/register");
                        },
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
