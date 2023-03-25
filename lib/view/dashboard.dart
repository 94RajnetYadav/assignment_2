import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nonstopioassignment/commonLoader/commonLoader.dart';
import 'package:nonstopioassignment/getxfunctionData/getapiControler.dart';
import 'package:nonstopioassignment/utils/allColors.dart';
import 'package:nonstopioassignment/view/customdrawer.dart';
import 'package:nonstopioassignment/view/googleSignInScreen.dart';
import 'package:loading_overlay/loading_overlay.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  // late scrollController = ScrollerControler();

  final CounterControler controllervalue = Get.put(CounterControler());

  // late ScrollController _controller;
  ScrollController _controller = new ScrollController();
  @override
  void initState() {
    super.initState();

    controllervalue.firstLoad();

    _controller = ScrollController()..addListener(_scroollistner);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => handleWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text("DashBoard"),
          centerTitle: true,
        ),
        drawer: customDrawerDealer(context),
        body: LoadingOverlay(
          isLoading: controllervalue.isFirstLoadRunning.value,
          opacity: 0.5,
          color: AllColor.black,
          progressIndicator: commonLoader(),
          child: Container(
            width: Get.width,
            height: Get.height,
            child: Column(
              children: [
                Obx(() => Expanded(
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: controllervalue.jsonresponse.value.length,
                        controller: _controller,
                        itemBuilder: (BuildContext context, index) {
                          return productdata(
                              controllervalue.jsonresponse.value[index]);
                        }))),
                Obx(() => controllervalue.isLoadMoreRunning.value == true
                    ? Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 40),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Container()),
                Obx(() => controllervalue.hasNextPage.value == false
                    ? Container(
                        padding: const EdgeInsets.only(top: 30, bottom: 40),
                        color: Colors.amber,
                        child: const Center(
                          child: Text('You have fetched all of the content'),
                        ),
                      )
                    : Container())
              ],
            ),
          ),
        ),
      ),
    );
  }

  productdata(Map<String, dynamic> data) {
    return Card(
      elevation: 4,
      child: ListTile(
        title: Text(
          data["name"],
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        subtitle: Text(
          data["description"].toString(),
          maxLines: 4,
        ),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(data["image_url"]),
          radius: 25,
        ),
        trailing: Text(data["first_brewed"]),
      ),
    );
  }

  _scroollistner() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      controllervalue.loadMore();
      controllervalue.isLoadMoreRunning.value;
      setState(() {});
    } else {}
  }

  Future<bool> handleWillPop(BuildContext context) async {
    commonAlertDialogForBackPressToClose(context);

    return false;
  }

  commonAlertDialogForBackPressToClose(BuildContext context) {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => WillPopScope(
              onWillPop: () async => true,
              child: SimpleDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  elevation: 0.0,
                  backgroundColor: AllColor.white,
                  title: Container(
                      width: Get.width,
                      alignment: Alignment.center,
                      child: Container(
                          child: Text(
                        "Assignment",
                        style: TextStyle(color: AllColor.black),
                      ))),
                  children: [
                    // SizedBox(
                    //   height: screenWidth * 0.01,
                    // ),
                    Container(
                        // color: AllColor.blue,
                        width: Get.width * 0.08,
                        height: Get.width * 0.08,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.exit_to_app,
                        )),
                    SizedBox(
                      height: Get.width * 0.02,
                    ),
                    Container(
                        width: Get.width,
                        alignment: Alignment.center,
                        child: Text(
                          "Are you sure you want to close this App?",
                          textAlign: TextAlign.center,
                        )),
                    SizedBox(
                      height: Get.width * 0.02,
                    ),

                    Container(
                      alignment: Alignment.center,
                      width: Get.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                                width: Get.width < 450
                                    ? Get.width * 0.3
                                    : Get.width * 0.25,
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("No"))),
                          ),
                          Center(
                            child: Container(
                                width: Get.width < 450
                                    ? Get.width * 0.3
                                    : Get.width * 0.25,

                                //screenWidth * 0.3,
                                child: ElevatedButton(
                                    onPressed: () {
                                      SystemNavigator.pop();
                                    },
                                    child: Text("Yes"))),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.width * 0.03,
                    ),
                  ]),
            ));
  }
}
