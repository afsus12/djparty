import 'package:djmusic/controllers/profilecompletedcheckcontroller.dart';
import 'package:djmusic/screens/MenuScreen.dart';
import 'package:djmusic/screens/profilecreationscreen.dart';
import 'package:djmusic/screens/profilescreen.dart';
import 'package:djmusic/utils/myColors.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Checker extends GetView<checkcompletedController> {
  @override
  Widget build(BuildContext context) {
    Get.put(checkcompletedController());

    return Obx(() => Container(
        child: controller.isDone == false
            ? Dialog(
                backgroundColor: Colors.black.withOpacity(0.3),
                child: Center(child: CircularProgressIndicator()),
              )
            : controller.isComplete.value == true
                ? MenuScreen()
                : ProfileCreationScreen()));
  }
}
