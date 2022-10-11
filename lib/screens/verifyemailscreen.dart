import 'package:djmusic/controllers/signupcontroller.dart';
import 'package:djmusic/screens/MenuScreen.dart';
import 'package:djmusic/screens/profilecreationscreen.dart';
import 'package:djmusic/screens/profilescreen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/verifyemailcontroller.dart';

class VerifyPage extends GetView<Verifyemailcontroller> {
  @override
  Widget build(BuildContext context) {
    Get.put(Verifyemailcontroller());
    return Obx(() => Container(
        child: controller.isEmailverified.value == true
            ? ProfileCreationScreen()
            : Scaffold(
                appBar: AppBar(title: Text('Verify Email')),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'A verification email have been sent to your email',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    ElevatedButton.icon(
                      onPressed: controller.sendVerificationEmail,
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50),
                      ),
                      icon: Icon(
                        Icons.email,
                        size: 32,
                      ),
                      label: Text(
                        'Resend Email',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ],
                ),
              )));
  }
}
