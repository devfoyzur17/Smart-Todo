import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelperFunction {
  static void showErrorMessage(String message,) {
    Get.snackbar(
      "Error:",
      message,
      snackPosition: SnackPosition.BOTTOM
    );
  }

  static void showSuccessMessage(String message) {
    Get.snackbar("Success:", message,snackPosition: SnackPosition.BOTTOM);
  }
}
