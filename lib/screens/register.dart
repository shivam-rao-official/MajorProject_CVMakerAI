import 'package:cvmaker_app_sarah_proj/services/api_services/UserService.dart';
import 'package:cvmaker_app_sarah_proj/widgets/genericBtn.dart';
import 'package:cvmaker_app_sarah_proj/widgets/textBtn.dart';
import 'package:cvmaker_app_sarah_proj/widgets/textFields.dart';
import 'package:cvmaker_app_sarah_proj/widgets/toast_msg.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _registerFormKey = GlobalKey<FormState>();
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
            key: _registerFormKey,
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
                      onPressed: () async {
                        if (_registerFormKey.currentState!.validate() ||
                            emailController.text.isNotEmpty) {
                          print("hello");
                          var generatedOtp = await UserService()
                              .generateOtp(emailController.text);
                          if (generatedOtp != null) {
                            ToastMsg().successToast(
                                "Your OTP is ${generatedOtp.toString()}");
                          } else {
                            ToastMsg().errorToast(
                                "Error Occurred");
                          }
                        }
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
                    onPressed: () async {
                      if (_registerFormKey.currentState!.validate()) {
                        Map<String, String> reqBody = {
                          "name": nameController.text,
                          "phnNumber": phoneNumController.text,
                          "email": emailController.text
                        };

                        var resp = await UserService().registerUser(otpController.text, reqBody);
                        if(resp == "OK"){
                          ToastMsg().successToast("User created successfully");
                          Navigator.of(context).pushReplacementNamed("/login");
                        }else{
                          ToastMsg().errorToast(resp);
                        }
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
