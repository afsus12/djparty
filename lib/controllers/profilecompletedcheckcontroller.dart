import 'package:djmusic/global/authservice.dart';
import 'package:djmusic/screens/MenuScreen.dart';
import 'package:djmusic/screens/profilecreationscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class checkcompletedController extends GetxController {
  var isComplete = false.obs;
  var isDone = false.obs;
  @override
  void onInit() async {
    isComplete.value = await handleCreatedState();
    print(isComplete.value);
    isDone.value = true;
    super.onInit();
  }
}

handleCreatedState() async {
  final ref = FirebaseDatabase.instance.ref();
  final userid = FirebaseAuth.instance.currentUser!.uid;
  final snapshot = await ref.child('users/$userid').get();
  print(userid);
  if (snapshot.exists) {
    print("data");
    return true;
  } else {
    print("no data");
    return false;
  }
}
