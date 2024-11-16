import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils{


 static Widget commonText(
      {String? text,
      double? fontSize,
      Color? textColor,
      FontWeight? fontWeight}){

    return Text(text??"",style: TextStyle(fontSize: fontSize,color: textColor,fontWeight: fontWeight??FontWeight.normal),);
  }
}
Future<void> launchProgress() async {
  if (Get.context != null) {
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: const Center(
          child: Material(
            color: Colors.transparent,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                strokeWidth: 0.7,
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: true,
    );
  } else {
    print('Error: Get.context is null. Dialog cannot be shown.');
  }
}

disposeProgress() {
  if (Get.isDialogOpen == true) {
    Get.back();
  }}