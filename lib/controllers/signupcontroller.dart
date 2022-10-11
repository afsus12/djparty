import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SignUpController extends GetxController {
  var SignUpKey = GlobalKey<FormState>();

  var email = new TextEditingController().obs;
  var password = new TextEditingController().obs;
  var passwtoggl = true.obs;
  var passwtogg2 = true.obs;

  var confirmpaswword = new TextEditingController().obs;
  String? validateThese(String c1) {
    if (c1.isEmpty || c1 == null) {
      return "This field can't be empty";
    }
    return null;
  }

  @override
  void onInit() {
    passwtoggl.value = true;
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

  String? validatePasswordlen(String c1) {
    if (c1.isEmpty || c1 == null) {
      return "This field can't be empty";
    } else if (c1.length < 6) {
      return "Minimum length is 6";
    }
    return null;
  }

  String? validatePassword(String c1, c2) {
    if (c2.isEmpty || c2 == null) {
      return "This field can't be empty";
    } else if (c1 != c2) {
      return "Password are not the same";
    }
    return null;
  }

  String? validatePhone(String c1) {
    if (!c1.isPhoneNumber) {
      return "Incorrect format";
    }
    return null;
  }
}
