import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SnackBarHelper {
  static Future<void> show(String message, {isLong = false}) async {
    Fluttertoast.showToast(
        msg: message,
        toastLength: isLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }
// static void show(String title, String message) {
//   Get.snackbar(title, message,
//       snackPosition: SnackPosition.BOTTOM,
//       snackStyle: SnackStyle.FLOATING,
//       borderRadius: 6,
  //       // padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  //       margin: const EdgeInsets.all(12),
  //       backgroundColor: const Color(0xFF171717),
  //       colorText: Colors.white,
  //       animationDuration: const Duration(milliseconds: 300));
  // }
}
