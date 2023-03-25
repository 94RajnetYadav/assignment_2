import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nonstopioassignment/main.dart';
import 'package:nonstopioassignment/utils/allColors.dart';
import 'package:nonstopioassignment/utils/shearpreferance/shearPreferance.dart';

import 'dashboard.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  googleLogin() async {
    print("googleLogin method Called");
    GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      var reslut = await _googleSignIn.signIn();
      if (reslut == null) {
        return;
      }

      final userData = await reslut.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: userData.accessToken, idToken: userData.idToken);
      var finalResult =
          await FirebaseAuth.instance.signInWithCredential(credential);

      reslut == null ? "" : Get.off(DashBoard());
      sharedPreferences!.setString(
          AllSharedPreferencesKey.name, reslut.displayName.toString());
      sharedPreferences!
          .setString(AllSharedPreferencesKey.email, reslut.email.toString());

      print("Result $reslut");
      print(reslut.displayName);
      print(reslut.email);
      print(reslut.photoUrl);
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: Get.width * 0.6,
          child: ElevatedButton(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                        width: Get.width * 0.1,
                        height: Get.width * 0.1,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                              "assets/images/google.png",
                            ),
                          ),
                          color: AllColor.white,
                        )),
                  ),
                  Text('Sign in with Google'),
                ],
              ),
              onPressed: googleLogin),
        ),
      ),
    );
  }
}
