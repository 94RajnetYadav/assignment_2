import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nonstopioassignment/utils/allColors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

commonLoader() {
  return Center(
      child: Container(
    padding: EdgeInsets.all(Get.width * 0.03),
    width: Get.width * 0.4,
    height: Get.width * 0.4,
    child: SpinKitSpinningLines(
      size: Get.width * 0.1,
      color: AllColor.black,
    ),
  ));
}
