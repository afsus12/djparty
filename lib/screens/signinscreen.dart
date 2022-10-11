import 'package:djmusic/controllers/signincontroller.dart';
import 'package:djmusic/global/authservice.dart';
import 'package:djmusic/screens/MenuScreen.dart';
import 'package:djmusic/screens/checker.dart';
import 'package:djmusic/screens/forgetpasswordscreen.dart';
import 'package:djmusic/screens/signupscreen.dart';
import 'package:djmusic/widgets/buttonwithicon.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../utils/myColors.dart';
import '../widgets/big_text.dart';
import '../widgets/inputfield.dart';

class SignInScreen extends GetView<SignInController> {
  const SignInScreen({Key? key}) : super(key: key);
  Widget build(BuildContext context) {
    double screenWidht = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    Get.put(SignInController());
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidht * .05),
      child: SingleChildScrollView(
        child: Obx(() => Form(
            key: controller.SignInKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight * .14,
                ),
                BigText(
                  text: "Sign In",
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
                      icon: Icons.mail,
                      validate: (v) => v != null && !EmailValidator.validate(v)
                          ? 'Enter a valid email'
                          : null,
                      onChanged: (value) {
                        controller.showError.value = false;
                        final val = TextSelection.collapsed(
                            offset: controller.email.value.text.length);
                        controller.email.value.selection = val;
                      },
                    )),
                SizedBox(
                  height: screenWidht * 0.02,
                ),
                SizedBox(
                    width: screenWidht * 0.90,
                    child: Myinput(
                      labelText: "Password",
                      controller: controller.password.value,
                      obscureText: controller.passwtogg2.value,
                      icon: Icons.lock,
                      Suffixicon: Icons.visibility,
                      validate: (v) => controller.validateThese(v!),
                      Suffixiconoff: Icons.visibility_off,
                      suffixiconfun: () {
                        controller.passwtogg2.value =
                            !controller.passwtogg2.value;
                      },
                      onChanged: (value) {
                        controller.showError.value = false;
                        final val = TextSelection.collapsed(
                            offset: controller.password.value.text.length);
                        controller.password.value.selection = val;
                      },
                    )),
                SizedBox(
                  height: screenWidht * 0.04,
                ),
                Visibility(
                  visible: controller.showError.value,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                      controller.errormsg.value,
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    )),
                  ),
                ),
                ButtonWithIcon(
                  onPressed: () {
                    bool valid = controller.SignInKey.currentState!.validate();
                    if (valid) {
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: controller.email.value.text,
                              password: controller.password.value.text)
                          .then((value) {
                        Get.offAll(Checker());
                      }).onError((error, stackTrace) {
                        controller.showError.value = true;

                        print("error " +
                            error.toString() +
                            stackTrace.toString());
                      });
                    }
                  },
                  text: "Sign In",
                  mainColor: MyColors.ButtonSignin,
                  fontSize: 18,
                  textcolor: Colors.white,
                  height: screenWidht * 0.15,
                ),
                SizedBox(
                  height: screenWidht * 0.03,
                ),
                Center(
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            children: [
                              TextSpan(
                                text: "Forgot Password?",
                                style: TextStyle(
                                  color: MyColors.BordersGrey,
                                ),
                              ),
                              TextSpan(
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap =
                                        () => Get.to(ForgotPasswordScreen()),
                                  text: ' Reset Password',
                                  style: TextStyle(
                                      color: MyColors.MainOrange,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline)),
                            ]))),
                SizedBox(
                  height: screenWidht * 0.05,
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
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                              text: "Don't have an account??",
                              style: TextStyle(color: MyColors.BordersGrey),
                            ),
                            TextSpan(
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () => Get.offAll(SignupScreen()),
                                text: 'Sign up',
                                style: TextStyle(color: MyColors.MainOrange)),
                          ])),
                )
              ],
            ))),
      ),
    )));
  }
}
