import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SignInController extends GetxController {
  var SignInKey = GlobalKey<FormState>();
  var email = new TextEditingController().obs;
  var password = new TextEditingController().obs;
  var showError = false.obs;
  var errormsg = "Bad Credentials".obs;
  var passwtogg2 = true.obs;

  String? validateThese(String c1) {
    if (c1.isEmpty || c1 == null) {
      return "This field can't be empty";
    }
    return null;
  }

  @override
  void onInit() {
    passwtogg2.value = true;
    super.onInit();
  }

  String? validateEmail(String c1) {
    if (c1.isEmpty || c1 == null) {
      return "This field can't be empty";
    } else if (c1.contains("@") == false) {
      return "Verify email field";
    }
    return null;
  }
}
