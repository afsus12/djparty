import 'package:djmusic/controllers/djcontroller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MapScreen extends GetView<DjController> {
  const MapScreen({Key? key}) : super(key: key);
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Text(
        FirebaseAuth.instance.currentUser!.email!,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
      Text(
        FirebaseAuth.instance.currentUser!.displayName!,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
      Center(
          child: Text(
        "hhhfffff",
        style: TextStyle(fontSize: 40),
      ))
    ]));
  }
}
