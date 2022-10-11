import 'package:djmusic/controllers/djcontroller.dart';
import 'package:djmusic/global/authservice.dart';
import 'package:djmusic/screens/landingscreen.dart';
import 'package:djmusic/widgets/tilewidget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/myColors.dart';

class ProfileScreen extends GetView<DjController> {
  const ProfileScreen({Key? key}) : super(key: key);
  Widget build(BuildContext context) {
    double screenWidht = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidht * .05),
      child: Column(children: [
        SizedBox(
          height: screenHeight * .14,
        ),
        Center(
          child: SvgPicture.asset(
            'assets/turntable.svg',
            width: screenWidht * 0.28,
          ),
        ),
        Divider(
          color: MyColors.Strokecolor, //color of divider
          height: 2, //height spacing of divider
          thickness: 2, //thickness of divier line
          indent: 10, //spacing at the start of divider
          endIndent: 10, //spacing at the end of divider
        ),
        TileWidget(
          name: "Edit Profile",
          icon: Icons.person_outlined,
          Iconsize: 25,
          Fontsize: 16,
        ),
        TileWidget(
          name: "Notification",
          icon: Icons.notifications_outlined,
          Iconsize: 25,
          Fontsize: 16,
        ),
        TileWidget(
          name: "Payment",
          icon: Icons.payment_outlined,
          Iconsize: 25,
          Fontsize: 16,
        ),
        TileWidget(
          name: "Settings",
          icon: Icons.settings_outlined,
          Iconsize: 25,
          Fontsize: 16,
        ),
        TileWidget(
          name: "Logout",
          icon: Icons.logout_outlined,
          Iconsize: 25,
          Fontsize: 16,
          onPressed: () async {
            GoogleSignIn _googleSignIn = GoogleSignIn();
            await _googleSignIn.disconnect();
            AuthService().signOut();

            Get.offAll(landingpage());
          },
        ),
      ]),
    ));
  }
}
