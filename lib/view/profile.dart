import 'package:flutter/material.dart';
import 'package:nonstopioassignment/main.dart';
import 'package:nonstopioassignment/utils/shearpreferance/shearPreferance.dart';

class ProfileUI2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("profile"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/nonstopoi.jpeg",
                    ),
                    fit: BoxFit.cover)),
            child: Container(
              width: double.infinity,
              height: 200,
              child: Container(
                alignment: Alignment(0.0, 2.5),
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    "assets/images/nonstopoi.jpeg",
                  ),
                  radius: 60.0,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Text(
            sharedPreferences!
                .getString(AllSharedPreferencesKey.name)
                .toString(),
            style: TextStyle(
                fontSize: 25.0,
                color: Colors.blueGrey,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            sharedPreferences!
                .getString(AllSharedPreferencesKey.email)
                .toString(),
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.black45,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w300),
          ),
        ]),
      ),
    );
  }
}
