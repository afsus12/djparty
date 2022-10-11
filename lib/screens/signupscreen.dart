import 'package:djmusic/controllers/djcontroller.dart';
import 'package:djmusic/controllers/signupcontroller.dart';
import 'package:djmusic/global/authservice.dart';
import 'package:djmusic/global/global.dart';
import 'package:djmusic/screens/MenuScreen.dart';
import 'package:djmusic/screens/checker.dart';
import 'package:djmusic/screens/landingscreen.dart';
import 'package:djmusic/screens/profilecreationscreen.dart';
import 'package:djmusic/screens/verifyemailscreen.dart';
import 'package:djmusic/widgets/big_text.dart';
import 'package:djmusic/widgets/inputfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:email_validator/email_validator.dart';

import 'package:flutter/material.dart';

import '../utils/myColors.dart';
import '../widgets/buttonwithicon.dart';

class SignupScreen extends GetView<SignUpController> {
  const SignupScreen({Key? key}) : super(key: key);

  validateForm() async {}

  @override
  Widget build(BuildContext context) {
    double screenWidht = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    Get.put(SignUpController());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidht * .05),
          child: SingleChildScrollView(
              child: Obx(
            () => Form(
              key: controller.SignUpKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenHeight * .14,
                  ),
                  BigText(
                    text: "Sign Up",
                    color: Colors.black,
                    textAlign: TextAlign.left,
                    size: screenHeight * 0.06,
                  ),
                  SizedBox(
                    height: screenWidht * 0.06,
                  ),
                  SizedBox(
                    height: screenWidht * 0.02,
                  ),
                  SizedBox(
                      width: screenWidht * 0.90,
                      child: Myinput(
                        labelText: "Email",
                        controller: controller.email.value,
                        onChanged: (value) {
                          final val = TextSelection.collapsed(
                              offset: controller.email.value.text.length);
                          controller.email.value.selection = val;
                        },
                        validate: (v) =>
                            v != null && !EmailValidator.validate(v)
                                ? 'Enter a valid email'
                                : null,
                        icon: Icons.mail,
                      )),
                  SizedBox(
                    height: screenWidht * 0.02,
                  ),
                  SizedBox(
                      width: screenWidht * 0.90,
                      child: Myinput(
                        labelText: "Password",
                        onChanged: (value) {
                          final val = TextSelection.collapsed(
                              offset: controller.password.value.text.length);
                          controller.password.value.selection = val;
                        },
                        controller: controller.password.value,
                        validate: (v) => controller.validatePasswordlen(v!),
                        obscureText: controller.passwtoggl.value,
                        icon: Icons.lock,
                        Suffixicon: Icons.visibility,
                        Suffixiconoff: Icons.visibility_off,
                        suffixiconfun: () {
                          controller.passwtoggl.value =
                              !controller.passwtoggl.value;
                        },
                      )),
                  SizedBox(
                    height: screenWidht * 0.02,
                  ),
                  SizedBox(
                      width: screenWidht * 0.90,
                      child: Myinput(
                        obscureText: controller.passwtogg2.value,
                        labelText: "Re-type Password",
                        controller: controller.confirmpaswword.value,
                        validate: (v) => controller.validatePassword(
                            controller.password.value.text, v!),
                        onChanged: (v) {
                          final val = TextSelection.collapsed(
                              offset:
                                  controller.confirmpaswword.value.text.length);
                          controller.confirmpaswword.value.selection = val;
                        },
                        icon: Icons.lock,
                        Suffixicon: Icons.visibility,
                        Suffixiconoff: Icons.visibility_off,
                        suffixiconfun: () {
                          controller.passwtogg2.value =
                              !controller.passwtogg2.value;
                        },
                      )),
                  SizedBox(
                    height: screenWidht * 0.04,
                  ),
                  ButtonWithIcon(
                    onPressed: () async {
                      print(controller.email.value.text);
                      bool isValidate =
                          controller.SignUpKey.currentState!.validate();

                      if (isValidate) {
                        try {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: controller.email.value.text,
                                  password: controller.password.value.text);
                          Get.offAll(VerifyPage());
                        } on FirebaseAuthException catch (e) {
                          Get.snackbar(e.code.toString(), e.message.toString(),
                              snackPosition: SnackPosition.BOTTOM);
                        }
                      }
                    },
                    text: "Sign Up",
                    mainColor: MyColors.ButtonSignin,
                    fontSize: 18,
                    textcolor: Colors.white,
                    height: screenWidht * 0.15,
                  ),
                  SizedBox(
                    height: screenWidht * 0.02,
                  ),
                  Row(children: <Widget>[
                    Expanded(
                        child: Divider(
                      color: MyColors.Strokecolor, //color of divider
                      height: 5, //height spacing of divider
                      thickness: 3, //thickness of divier line
                      indent: 25, //spacing at the start of divider
                      endIndent: 25, //spacing at the end of divider
                    )),
                    Text(
                      "or",
                      style: TextStyle(fontSize: 18),
                    ),
                    Expanded(
                        child: Divider(
                      color: MyColors.Strokecolor, //color of divider
                      height: 5, //height spacing of divider
                      thickness: 3, //thickness of divier line
                      indent: 25, //spacing at the start of divider
                      endIndent: 25, //spacing at the end of divider
                    )),
                  ]),
                  SizedBox(
                    height: screenWidht * 0.02,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () async {
                        await AuthService().signInWithGoogle();
                        await Get.offAll(Checker());
                      },
                      child: Image.asset(
                        "assets/google.png",
                        width: screenWidht * 0.07,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenWidht * 0.08,
                  ),
                  Center(
                    child: TextButton(
                        onPressed: () {
                          Get.offAll(landingpage());
                        },
                        child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Already have an account?",
                                    style:
                                        TextStyle(color: MyColors.BordersGrey),
                                  ),
                                  TextSpan(
                                      text: 'Sign in',
                                      style: TextStyle(
                                          color: MyColors.MainOrange)),
                                ]))),
                  )
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
