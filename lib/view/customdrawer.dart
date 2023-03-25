import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nonstopioassignment/main.dart';

import 'package:nonstopioassignment/utils/allColors.dart';
import 'package:nonstopioassignment/utils/shearpreferance/shearPreferance.dart';
import 'package:nonstopioassignment/view/googleSignInScreen.dart';
import 'package:nonstopioassignment/view/profile.dart';

customDrawerDealer(
  BuildContext context,
) =>
    SafeArea(
      child: Drawer(
        child: Container(
          color: AllColor.white,
          child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
              tileColor: AllColor.primaryColor,
              dense: true,
              title: GestureDetector(
                onTap: () {
                  Get.back();
                  Get.to(ProfileUI2());
                },
                child: Container(
                  // width: Get.width * 0.5,
                  // color: AllColor.red,
                  child: Row(
                    children: [
                      Container(
                          width: Get.width * 0.7,
                          height: Get.height * 0.3,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                "assets/images/nonstopoi.jpeg",
                              ),
                            ),
                            color: AllColor.white,
                          )),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
              ),
              subtitle: Container(
                color: AllColor.white,
                width: Get.width,
                height: Get.height,
                child: Wrap(runSpacing: 0, children: [
                  Container(
                    height: Get.width * 0.5,
                    child: ListTile(
                      leading: Icon(
                        Icons.logout,
                        size: Get.width * 0.06,
                        color: AllColor.black,
                      ),
                      title: Text(
                        "Logout",
                        style: TextStyle(color: AllColor.black),
                      ),
                      onTap: () {
                        sharedPreferences!
                            .setString(AllSharedPreferencesKey.name, "");
                        sharedPreferences!
                            .setString(AllSharedPreferencesKey.email, "");
                        GoogleSignIn().disconnect();
                        FirebaseAuth.instance.signOut();
                        Get.off(LoginScreen());
                        // Future<void> logout() async {
                        //   await GoogleSignIn().disconnect();
                        //   FirebaseAuth.instance.signOut();
                        //   Get.off(LoginScreen());
                        // }
                      },
                    ),
                  ),
                ]),
              )),
        ),
      ),
    );
