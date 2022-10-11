import 'package:djmusic/screens/MenuScreen.dart';
import 'package:djmusic/screens/checker.dart';
import 'package:djmusic/screens/landingscreen.dart';
import 'package:djmusic/screens/profilecreationscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return Checker();
          } else {
            return const landingpage();
          }
        });
  }

  handleCreatedState() async {
    final ref = FirebaseDatabase.instance.ref();
    final userid = FirebaseAuth.instance.currentUser!.uid;
    final snapshot = await ref.child('users/$userid').get();
    if (snapshot.exists) {
      return true;
    } else {
      print('No data available.');
      return false;
    }
  }

  signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>["email"]).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }
}
