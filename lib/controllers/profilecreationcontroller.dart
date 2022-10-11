import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ProfileCreationController extends GetxController {
  var creationKey = GlobalKey<FormState>();
  var fname = new TextEditingController().obs;
  var lname = new TextEditingController().obs;
  var gender = new TextEditingController().obs;
  var phone = new TextEditingController().obs;
  var isDj = false.obs;
  var birthdate = new TextEditingController().obs;
  var countryValue = "United States".obs;
  var stateValue = TextEditingController().obs;
  var cityValue = TextEditingController().obs;
  var zip = TextEditingController().obs;
  var profilePicLink = "".obs;
  RxList<bool> isSelected2 = <bool>[true, false].obs;
  RxList<bool> isSelected4 = <bool>[true, false].obs;
  String? validateThese(String c1) {
    if (c1.isEmpty || c1 == null) {
      return "This field can't be empty";
    }
    return null;
  }

  @override
  void onInit() {
    gender.value.text = "Male";

    // TODO: implement onInit
    super.onInit();
  }

  String? validatePhone(String c1) {
    if (!c1.isPhoneNumber) {
      return "Incorrect format";
    }
    return null;
  }

  String? validateZip(String c1) {
    if (!c1.isNumericOnly) {
      return "Incorrect format";
    }
    return null;
  }
}
