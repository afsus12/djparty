import 'package:djmusic/controllers/forgotpasscontroller.dart';
import 'package:djmusic/screens/landingscreen.dart';
import 'package:djmusic/screens/signinscreen.dart';
import 'package:djmusic/utils/myColors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/inputfield.dart';

class ForgotPasswordScreen extends GetView<ForgotPassController> {
  const ForgotPasswordScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double screenWidht = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    Get.put(ForgotPassController());
    return Scaffold(
      backgroundColor: MyColors.inputcolorfill,
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blueAccent,
          title: Text('Reset Password')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: screenWidht * 0.9,
            child: Text(
              'Receive an email to reset your password.',
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          Center(
            child: SizedBox(
                width: screenWidht * 0.90,
                child: Myinput(
                  labelText: "Email",
                  controller: controller.email.value,
                  icon: Icons.mail,
                  validate: (v) => v != null && !EmailValidator.validate(v)
                      ? 'Enter a valid email'
                      : null,
                  onChanged: (value) {
                    final val = TextSelection.collapsed(
                        offset: controller.email.value.text.length);
                    controller.email.value.selection = val;
                  },
                )),
          ),
          SizedBox(
            height: 24,
          ),
          SizedBox(
            width: screenWidht * 0.90,
            child: ElevatedButton.icon(
              onPressed: () {
                verifyemail(controller.email.value.text);
              },
              style: ElevatedButton.styleFrom(
                primary: MyColors.ButtonSignin,
                minimumSize: Size.fromHeight(50),
              ),
              icon: Icon(
                Icons.email,
                size: 32,
                color: Colors.white,
              ),
              label: Text(
                'Resend Email',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future verifyemail(mail) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: mail);
    Get.snackbar("", "Password Reset Email Sent ",
        colorText: Colors.white,
        backgroundColor: MyColors.MainOrange,
        snackPosition: SnackPosition.BOTTOM);
    Get.to(SignInScreen());
  } on FirebaseAuthException catch (e) {
    Get.snackbar("", e.message.toString(),
        colorText: Colors.white,
        backgroundColor: MyColors.MainOrange,
        snackPosition: SnackPosition.BOTTOM);
  }
}
