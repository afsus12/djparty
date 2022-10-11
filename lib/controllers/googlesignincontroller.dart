import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInController extends GetxController {
  GoogleSignInAccount? _user;
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount get user => _user!;
  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;
    final googleAuth = await googleUser.authentication;
    final Credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(Credential);
  }

  String? validateThese(String c1) {
    if (c1.isEmpty || c1 == null) {
      return "This field can't be empty";
    }
    return null;
  }

  @override
  void onInit() {
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

  // Future<UserCredential> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth =
  //       await googleUser?.authentication;

  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );

  //   // Once signed in, return the UserCredential
  //   await FirebaseAuth.instance.authStateChanges().listen((User? user) async {
  //     if (user != null) {
  //       var Exists = await FirebaseFirestore.instance
  //           .collection("users")
  //           .doc(FirebaseAuth.instance.currentUser!.uid)
  //           .get()
  //           .then((docSnapshot) async => {
  //                 if (docSnapshot.exists)
  //                   // empty main tetbadel ken user ando  music twali ndhahrolo mymusic()
  //                   {
  //                     await FirebaseFirestore.instance
  //                         .collection("Music")
  //                         .doc(FirebaseAuth.instance.currentUser!.uid)
  //                         .get()
  //                         .then((docSnapshot) => {
  //                               if (docSnapshot.exists)
  //                                 {
  //                                   Get.off(myMusic()),
  //                                 }
  //                               else
  //                                 {Get.off(EmptyMain()), print("azsss $e")}
  //                             }),
  //                   }
  //                 else
  //                   {Get.to(signup_google())}
  //               });
  //     }
  //   });
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }
}
