import 'package:floaty_bird/utils/global_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/general_config_controller.dart';
import 'ara_theme.dart';

void showLoader() {
  if (!generalConfigController.isLoaderActive.value) {
    Get.dialog(
      barrierDismissible: false,
      WillPopScope(
        onWillPop: () => Future.value(false),
        child: const Dialog(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          child: GlobalLoaderWidget(),
        ),
      ),
    );
    generalConfigController.isLoaderActive.value = true;
  }
}

void hideLoader() {
  if (generalConfigController.isLoaderActive.value) {
    generalConfigController.isLoaderActive.value = false;
    Get.back();
  }
}

void showGeneralToastMessage(
    {String? message, Duration? duration, SnackPosition? snackPosition}) {
  hideLoader();
  if (Get.isSnackbarOpen) {
    return;
  }
  Get.showSnackbar(
    GetSnackBar(
      isDismissible: false,
      snackStyle: SnackStyle.FLOATING,
      snackPosition: snackPosition ?? SnackPosition.TOP,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      borderRadius: 10.0,
      duration: duration ?? const Duration(seconds: 2),
      animationDuration: const Duration(milliseconds: 800),
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      reverseAnimationCurve: Curves.easeOutCubic,
      backgroundColor: Styles.primaryGreenColor,
      messageText: Text(
        message ?? "",
        style: Get.textTheme.bodyMedium?.copyWith(color: Styles.whiteColor),
      ),
    ),
  );
}
