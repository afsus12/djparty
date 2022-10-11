import 'dart:io';

import 'package:djmusic/controllers/profilecreationcontroller.dart';
import 'package:djmusic/screens/MenuScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/myColors.dart';
import '../widgets/big_text.dart';
import '../widgets/buttonwithicon.dart';
import '../widgets/inputfield.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProfileCreationScreen extends GetView<ProfileCreationController> {
  const ProfileCreationScreen({Key? key}) : super(key: key);
  Widget build(BuildContext context) {
    double screenWidht = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    Get.put(ProfileCreationController());
    void pickUploadProfilePic() async {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 512,
        maxWidth: 512,
        imageQuality: 90,
      );
      var uid = FirebaseAuth.instance.currentUser!.uid;
      Reference ref =
          FirebaseStorage.instance.ref().child("$uid/profilepic.jpg");

      await ref.putFile(File(image!.path));

      ref.getDownloadURL().then((value) async {
        controller.profilePicLink.value = value;
      });
    }

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidht * .05),
        child: SingleChildScrollView(
          child: Obx(() => Form(
              key: controller.creationKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenHeight * .06,
                  ),
                  BigText(
                    text: "Create Your Profile",
                    color: Colors.black,
                    textAlign: TextAlign.left,
                    size: screenHeight * 0.04,
                  ),
                  SizedBox(
                    height: screenHeight * .02,
                  ),
                  Center(
                    child: GestureDetector(
                        onTap: () {
                          pickUploadProfilePic();
                        },
                        child: controller.profilePicLink.value == ""
                            ? CircleAvatar(
                                backgroundColor: MyColors.inputcolorfill,
                                radius: screenWidht * 0.2,
                                child: Icon(
                                  Icons.upload,
                                  size: screenWidht * 0.12,
                                  color: Colors.white,
                                ),
                              )
                            : CircleAvatar(
                                backgroundColor: MyColors.inputcolorfill,
                                radius: screenWidht * 0.2,
                                foregroundImage: NetworkImage(
                                    controller.profilePicLink.value))),
                  ),
                  SizedBox(
                    height: screenWidht * 0.06,
                  ),
                  SizedBox(
                    width: screenWidht * 0.90,
                    child: Myinput(
                        controller: controller.fname.value,
                        onChanged: (value) {
                          final val = TextSelection.collapsed(
                              offset: controller.fname.value.text.length);
                          controller.fname.value.selection = val;
                        },
                        validate: (v) => controller.validateThese(v!),
                        labelText: "First Name",
                        icon: Icons.person),
                  ),
                  SizedBox(
                    height: screenWidht * 0.02,
                  ),
                  SizedBox(
                      width: screenWidht * 0.90,
                      child: Myinput(
                        labelText: "Last Name",
                        controller: controller.lname.value,
                        onChanged: (value) {
                          final val = TextSelection.collapsed(
                              offset: controller.lname.value.text.length);
                          controller.lname.value.selection = val;
                        },
                        validate: (v) => controller.validateThese(v!),
                        icon: Icons.person,
                      )),
                  SizedBox(
                    height: screenWidht * 0.02,
                  ),
                  SizedBox(
                      width: screenWidht * 0.90,
                      child: Myinput(
                        controller: controller.birthdate.value,
                        validate: (v) => controller.validateThese(v!),
                        labelText: "Birthdate",
                        icon: Icons.calendar_month,
                        keyboardType: TextInputType.datetime,
                        ontap: () async {
                          DateTime? pickdate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1920),
                              lastDate: DateTime.now());
                          if (pickdate != null) {
                            controller.birthdate.value.text =
                                DateFormat("yyyy-MM-dd").format(pickdate);
                          }
                        },
                      )),
                  SizedBox(
                    height: screenWidht * 0.02,
                  ),
                  SizedBox(
                      width: screenWidht * 0.90,
                      child: Myinput(
                        controller: controller.phone.value,
                        onChanged: (v) {
                          final val = TextSelection.collapsed(
                              offset: controller.phone.value.text.length);
                          controller.phone.value.selection = val;
                        },
                        keyboardType: TextInputType.phone,
                        validate: (v) => controller.validateThese(v!),
                        labelText: "Phone Number",
                        icon: Icons.phone,
                      )),
                  SizedBox(
                    height: screenWidht * 0.02,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidht * 0.01),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Gender",
                              style: TextStyle(
                                  fontSize: 17, fontFamily: "Roboto-Regular")),
                          SizedBox(
                            height: screenHeight * 0.07,
                            child: ToggleButtons(
                              borderRadius: BorderRadius.circular(14),
                              isSelected: controller.isSelected2,
                              selectedColor: Colors.white,
                              color: Colors.black,
                              fillColor: MyColors.MainOrange,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Center(
                                    child: Text('  Male  ',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Roboto-Regular")),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Center(
                                    child: Text('Female',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Roboto-Regular")),
                                  ),
                                ),
                              ],
                              onPressed: (int index) {
                                controller.isSelected2[index] = true;
                                if (index == 0) {
                                  controller.gender.value.text = "Male";
                                  controller.isSelected2[1] = false;
                                } else {
                                  controller.gender.value.text = "Female";
                                  controller.isSelected2[0] = false;
                                }
                              },
                            ),
                          )
                        ]),
                  ),
                  CountryListPick(
                      appBar: AppBar(
                        backgroundColor: Colors.white,
                        title: Text(
                          'Choose your country',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      pickerBuilder: (context, CountryCode? countryCode) {
                        return SizedBox(
                          width: screenWidht * 0.90,
                          height: screenHeight * 0.07,
                          child: Row(
                            children: [
                              Image.asset(
                                countryCode!.flagUri!,
                                package: 'country_list_pick',
                                width: screenHeight * 0.06,
                              ),
                              SizedBox(
                                width: screenWidht * 0.03,
                              ),
                              Text(
                                countryCode.name!,
                                style: TextStyle(
                                    fontSize: 17, color: Colors.black),
                              ),
                            ],
                          ),
                        );
                      },

                      // To disable option set to false
                      theme: CountryTheme(
                        isShowFlag: true,
                        isShowTitle: true,
                        isShowCode: false,
                        isDownIcon: false,
                        showEnglishName: true,
                      ),
                      // Set default value

                      // or
                      initialSelection: 'US',
                      onChanged: (CountryCode? code) {
                        print(code!.name);
                        controller.countryValue.value = code.name.toString();
                        print(controller.countryValue.value);
                        print(code.code);
                        print(code.dialCode);
                        print(code.flagUri);
                      },
                      // Whether to allow the widget to set a custom UI overlay
                      useUiOverlay: true,
                      // Whether the country list should be wrapped in a SafeArea
                      useSafeArea: true),
                  SizedBox(
                      width: screenWidht * 0.90,
                      child: Myinput(
                        controller: controller.stateValue.value,
                        onChanged: (v) {
                          final val = TextSelection.collapsed(
                              offset: controller.stateValue.value.text.length);
                          controller.stateValue.value.selection = val;
                        },
                        keyboardType: TextInputType.streetAddress,
                        validate: (v) => controller.validateThese(v!),
                        labelText: "State",
                        icon: Icons.location_city,
                      )),
                  SizedBox(
                    height: screenWidht * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: screenWidht * 0.43,
                          child: Myinput(
                            controller: controller.cityValue.value,
                            onChanged: (v) {
                              final val = TextSelection.collapsed(
                                  offset:
                                      controller.cityValue.value.text.length);
                              controller.cityValue.value.selection = val;
                            },
                            keyboardType: TextInputType.streetAddress,
                            validate: (v) => controller.validateThese(v!),
                            labelText: "City",
                            icon: Icons.location_city,
                          )),
                      SizedBox(
                          width: screenWidht * 0.43,
                          child: Myinput(
                            controller: controller.zip.value,
                            onChanged: (v) {
                              final val = TextSelection.collapsed(
                                  offset: controller.zip.value.text.length);
                              controller.zip.value.selection = val;
                            },
                            keyboardType: TextInputType.number,
                            validate: (v) => controller.validateZip(v!),
                            labelText: "Zip",
                            icon: Icons.location_city,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: screenWidht * 0.02,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidht * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Sign up as?",
                            style: TextStyle(
                                fontSize: 17, fontFamily: "Roboto-Regular")),
                        SizedBox(
                          height: screenHeight * 0.07,
                          child: ToggleButtons(
                            borderRadius: BorderRadius.circular(12),
                            isSelected: controller.isSelected4,
                            selectedColor: Colors.white,
                            color: Colors.black,
                            fillColor: MyColors.MainOrange,
                            children: const [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: Center(
                                  child: Text('  Client ',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "Roboto-Regular")),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 5),
                                child: Center(
                                  child: Text('    Dj     ',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "Roboto-Regular")),
                                ),
                              ),
                            ],
                            onPressed: (int index) {
                              controller.isSelected4[index] = true;
                              if (index == 0) {
                                controller.isDj.value = false;
                                controller.isSelected4[1] = false;
                              } else {
                                controller.isDj.value = true;
                                controller.isSelected4[0] = false;
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenWidht * 0.05,
                  ),
                  ButtonWithIcon(
                    onPressed: () async {
                      bool isValid =
                          controller.creationKey.currentState!.validate();
                      if (isValid) {
                        final uid = FirebaseAuth.instance.currentUser!.uid;
                        final email = FirebaseAuth.instance.currentUser!.email;

                        DatabaseReference ref =
                            FirebaseDatabase.instance.ref("users/$uid");

                        print("sssssssssssss");
                        print(controller.fname.value.text);
                        print(controller.lname.value.text);
                        print(controller.birthdate.value.text);

                        await ref
                            .set({
                              "id": uid,
                              "fname": controller.fname.value.text,
                              "lname": controller.lname.value.text,
                              "email": email,
                              "birthdate": controller.birthdate.value.text,
                              "phonenumber": controller.phone.value.text,
                              "gender": controller.gender.value.text,
                              "country": controller.countryValue.value,
                              "state": controller.stateValue.value.text,
                              "city": controller.cityValue.value.text,
                              "zip": controller.zip.value.text,
                              "isDj": controller.isDj.toString()
                            })
                            .then((value) => Get.to(() => MenuScreen()))
                            .catchError((onError) {
                              print(onError);
                            });
                      }
                    },
                    text: "Continue",
                    mainColor: MyColors.ButtonSignin,
                    fontSize: 18,
                    textcolor: Colors.white,
                    height: screenWidht * 0.15,
                  ),
                  SizedBox(
                    height: screenWidht * 0.05,
                  ),
                ],
              ))),
        ),
      )),
    );
  }
}
