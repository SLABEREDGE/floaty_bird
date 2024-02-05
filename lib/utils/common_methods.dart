import 'package:floaty_bird/utils/global_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/general_config_controller.dart';
import 'ara_theme.dart';
import 'custom_dialog_widget.dart';

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

Future<void> showDialogWithMessage({
  required String message,
  String? title,
  bool onWillPop = false,

  ///if no text is pass it will be a okay button
  String? firstButtonText,

  ///if no text is pass it will be a cancel button
  String? secondButtonText,

  ///if no text is pass it will be a okay button
  Function? onTapFirstButton,

  /// if no text is pass it will be a cancel button
  Function? onTapSecondButton,
  GlobalKey<NavigatorState>? navigatorKey,
  bool barrierDismissable = false,
  final Color? firstButtonTextColor,
  final double? firstButtonHeight,
  final Color? firstButtonColor,
  final Color? secondButtonTextColor,
  final double? secondButtonHeight,
  final Color? secondButtonColor,
  final Widget? titleWidget,
  bool isSecondButtonVisibile = false,
  bool firstBorderEnable = false,
  bool isButtonVertical = true,
  bool secondBorderEnable = false,
  bool backgroundBlur = true,
  final EdgeInsetsGeometry? contentPadding,
  final EdgeInsetsGeometry? titlePadding,
  final EdgeInsetsGeometry? actionsPadding,
  final IconData? firstButtonLeftIcon,
  final IconData? firstButtonRightIcon,
  final double? firstButtonSpaceFromLeft,
  final double? firstButtonSpaceFromRight,
  final Color? firstButtonIconColor,
  final double? firstButtonIconSize,
  final IconData? secondButtonLeftIcon,
  final IconData? secondButtonRightIcon,
  final double? secondButtonSpaceFromLeft,
  final double? secondButtonSpaceFromRight,
  final Color? secondButtonIconColor,
  final double? secondButtonIconSize,
  final bool willPopScope = false,
  // final bool isSimilarShowDialog = false,
  final bool autoCloseDialogOnFirstButtonTap = true,
  final bool autoCloseDialogOnSecondButtonTap = true,
  final bool autoCloseDialogOnThirdButtonTap = true,
}) async {
  hideLoader();
  await Dialogs.twoButtonDialog(
    // isSimilarShowDialog: isSimilarShowDialog,
    willPopScope: willPopScope,
    canPop: onWillPop,
    actionsPadding: actionsPadding,
    contentPadding: contentPadding,
    titlePadding: titlePadding,
    backgroundBlur: backgroundBlur,
    firstButtonColor: firstButtonColor,
    secondButtonColor: secondButtonColor,
    firstButtonHeight: firstButtonHeight,
    secondButtonHeight: secondButtonHeight,
    firstButtonTextColor: firstButtonTextColor,
    secondButtonTextColor: secondButtonTextColor,
    firstBorderEnable: firstBorderEnable,
    isButtonVertical: isButtonVertical,
    secondBorderEnable: secondBorderEnable,
    message: message,
    title: title,
    titleWidget: titleWidget,
    firstButtonIconColor: firstButtonIconColor,
    firstButtonIconSize: firstButtonIconSize,
    firstButtonLeftIcon: firstButtonLeftIcon,
    firstButtonRightIcon: firstButtonRightIcon,
    firstButtonSpaceFromLeft: firstButtonSpaceFromLeft,
    firstButtonSpaceFromRight: firstButtonSpaceFromRight,
    autoCloseDialogOnFirstButtonTap: autoCloseDialogOnFirstButtonTap,
    autoCloseDialogOnSecondButtonTap: autoCloseDialogOnSecondButtonTap,
    autoCloseDialogOnThirdButtonTap: autoCloseDialogOnThirdButtonTap,
    onTapFirstButton: () {
      if (onTapFirstButton != null) onTapFirstButton();
    },
    firstButtonText: firstButtonText ?? "Okay",
    secondButtonIconColor: secondButtonIconColor,
    secondButtonIconSize: secondButtonIconSize,
    secondButtonLeftIcon: secondButtonLeftIcon,
    secondButtonRightIcon: secondButtonRightIcon,
    secondButtonSpaceFromLeft: secondButtonSpaceFromLeft,
    secondButtonSpaceFromRight: secondButtonSpaceFromRight,
    onTapSecondButton: () {
      if (onTapSecondButton != null) onTapSecondButton();
    },
    secondButtonText: secondButtonText ?? "Cancel",
    barrierDismissible: barrierDismissable,

    isSecondButtonVisible: isSecondButtonVisibile,
  );
}
