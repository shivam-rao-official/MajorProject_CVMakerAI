import 'package:cvmaker_app_sarah_proj/widgets/genericBtn.dart';
import 'package:cvmaker_app_sarah_proj/widgets/textBtn.dart';
import 'package:cvmaker_app_sarah_proj/widgets/textFields.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController phoneNumController = TextEditingController();
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
                      "REGISTER",
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff343434),
                      ),
                    ),
                  ),
                  const SizedBox(height: 61),
                  CustomTextFields(
                    controller: nameController,
                    icon: Icons.person_2_outlined,
                    hintText: "Enter Your Name Here",
                    keyBoardType: TextInputType.text,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Name is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  CustomTextFields(
                    controller: phoneNumController,
                    icon: Icons.phone_outlined,
                    hintText: "Enter Phone Number Here",
                    keyBoardType: TextInputType.phone,
                    maxLength: 10,
                    validator: (val) {
                      if (val == null || val.isEmpty || val.length != 10) {
                        return "Phone number is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  CustomTextFields(
                    controller: emailController,
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
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomTextFields(
                    controller: otpController,
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
                    btnLabel: "REGISTER",
                  ),
                  const SizedBox(height: 30),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already registered."),
                      CustomTextButton(
                        btnLabel: "Login",
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed("/login");
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
