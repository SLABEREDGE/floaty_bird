import 'package:floaty_bird/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../utils/ara_theme.dart';
import '../controller/general_config_controller.dart';

class CustomDialog extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  final String message;
  final String firstButtonText;
  final String secondButtonText;
  final String thirdButtonText;
  final VoidCallback? onTapFirstButton;
  final VoidCallback? onTapSecondButton;
  final VoidCallback? onTapThirdButton;

  final bool firstBorderEnable;
  final bool secondBorderEnable;
  final bool thirdBorderEnable;
  final bool isButtonVertical;
  final bool canPop;
  final Color? firstButtonTextColor;
  final double? firstButtonHeight;
  final Color? firstButtonColor;
  final Color? secondButtonTextColor;
  final double? secondButtonHeight;
  final Color? secondButtonColor;
  final Color? thirdButtonTextColor;
  final double? thirdButtonHeight;
  final double? firstButtonWidth;
  final double? secondButtonWidth;
  final double? thirdButtonWidth;
  final Color? thirdButtonColor;

  final bool isFirstButtonVisible;
  final bool isSecondButtonVisible;
  final bool isThirdButtonVisible;

  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? titlePadding;
  final EdgeInsetsGeometry? actionsPadding;

  final IconData? firstButtonLeftIcon;
  final IconData? firstButtonRightIcon;
  final double? firstButtonSpaceFromLeft;
  final double? firstButtonSpaceFromRight;
  final Color? firstButtonIconColor;
  final double? firstButtonIconSize;

  final IconData? secondButtonLeftIcon;
  final IconData? secondButtonRightIcon;
  final double? secondButtonSpaceFromLeft;
  final double? secondButtonSpaceFromRight;
  final Color? secondButtonIconColor;
  final double? secondButtonIconSize;

  final IconData? thirdButtonLeftIcon;
  final IconData? thirdButtonRightIcon;
  final double? thirdButtonSpaceFromLeft;
  final double? thirdButtonSpaceFromRight;
  final Color? thirdButtonIconColor;
  final double? thirdButtonIconSize;
  final bool autoCloseDialogOnFirstButtonTap;
  final bool autoCloseDialogOnSecondButtonTap;
  final bool autoCloseDialogOnThirdButtonTap;

  const CustomDialog({
    super.key,
    this.title,
    this.onTapFirstButton,
    this.firstButtonText = "",
    this.secondButtonText = "",
    this.onTapSecondButton,
    this.thirdButtonText = "",
    this.onTapThirdButton,
    this.message = "",
    this.isButtonVertical = false,
    this.firstBorderEnable = false,
    this.secondBorderEnable = false,
    this.thirdBorderEnable = false,
    this.canPop = false,
    this.firstButtonHeight,
    this.firstButtonColor,
    this.secondButtonHeight,
    this.secondButtonColor,
    this.thirdButtonHeight,
    this.thirdButtonColor,
    this.titleWidget,
    this.firstButtonWidth,
    this.secondButtonWidth,
    this.thirdButtonWidth,
    this.firstButtonTextColor,
    this.secondButtonTextColor,
    this.thirdButtonTextColor,
    this.isFirstButtonVisible = true,
    this.isSecondButtonVisible = true,
    this.isThirdButtonVisible = true,
    this.contentPadding,
    this.titlePadding,
    this.actionsPadding,
    this.firstButtonLeftIcon,
    this.firstButtonRightIcon,
    this.firstButtonSpaceFromLeft,
    this.firstButtonSpaceFromRight,
    this.firstButtonIconColor,
    this.firstButtonIconSize,
    this.secondButtonLeftIcon,
    this.secondButtonRightIcon,
    this.secondButtonSpaceFromLeft,
    this.secondButtonSpaceFromRight,
    this.secondButtonIconColor,
    this.secondButtonIconSize,
    this.thirdButtonLeftIcon,
    this.thirdButtonRightIcon,
    this.thirdButtonSpaceFromLeft,
    this.thirdButtonSpaceFromRight,
    this.thirdButtonIconColor,
    this.thirdButtonIconSize,
    this.autoCloseDialogOnFirstButtonTap = true,
    this.autoCloseDialogOnSecondButtonTap = true,
    this.autoCloseDialogOnThirdButtonTap = true,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = [
      if (firstButtonText.isNotEmpty)
        Flexible(
          child: CustomDialogButton(
            autoCloseDialogOnButtonTap: autoCloseDialogOnFirstButtonTap,
            buttonVisible: isFirstButtonVisible,
            width: firstButtonWidth,
            buttonColor: firstButtonColor,
            buttonHeight: firstButtonHeight,
            buttonTextColor: firstButtonTextColor,
            onTap: onTapFirstButton,
            borderEnable: firstBorderEnable,
            buttonText: firstButtonText,
            iconColor: firstButtonIconColor,
            iconSize: firstButtonIconSize,
            leftIcon: firstButtonLeftIcon,
            rightIcon: firstButtonRightIcon,
            spaceFromLeft: firstButtonSpaceFromLeft,
            spaceFromRight: firstButtonSpaceFromRight,
          ),
        ),
      if (secondButtonText.isNotEmpty)
        SizedBox(
          height: isButtonVertical ? 10 : 0,
          width: isButtonVertical ? 0 : 10,
        ),
      if (secondButtonText.isNotEmpty)
        Flexible(
          child: CustomDialogButton(
            autoCloseDialogOnButtonTap: autoCloseDialogOnSecondButtonTap,
            buttonVisible: isSecondButtonVisible,
            width: secondButtonWidth,
            buttonColor: secondButtonColor,
            buttonHeight: secondButtonHeight,
            buttonTextColor: secondButtonTextColor,
            onTap: onTapSecondButton,
            borderEnable: secondBorderEnable,
            buttonText: secondButtonText,
            iconColor: secondButtonIconColor,
            iconSize: secondButtonIconSize,
            leftIcon: secondButtonLeftIcon,
            rightIcon: secondButtonRightIcon,
            spaceFromLeft: secondButtonSpaceFromLeft,
            spaceFromRight: secondButtonSpaceFromRight,
          ),
        ),
      if (thirdButtonText.isNotEmpty)
        SizedBox(
          height: isButtonVertical ? 10 : 0,
          width: isButtonVertical ? 0 : 10,
        ),
      if (thirdButtonText.isNotEmpty)
        Flexible(
          child: CustomDialogButton(
            autoCloseDialogOnButtonTap: autoCloseDialogOnThirdButtonTap,
            buttonVisible: isThirdButtonVisible,
            width: thirdButtonWidth,
            buttonColor: thirdButtonColor,
            buttonHeight: thirdButtonHeight,
            buttonTextColor: thirdButtonTextColor,
            onTap: onTapThirdButton,
            borderEnable: thirdBorderEnable,
            buttonText: thirdButtonText,
            iconColor: thirdButtonIconColor,
            iconSize: thirdButtonIconSize,
            leftIcon: thirdButtonLeftIcon,
            rightIcon: thirdButtonRightIcon,
            spaceFromLeft: thirdButtonSpaceFromLeft,
            spaceFromRight: thirdButtonSpaceFromRight,
          ),
        ),
    ];

    return AlertDialog(
      elevation: 0,
      shadowColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      actionsPadding: actionsPadding ??
          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.hardEdge,
      contentPadding: contentPadding ??
          const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      titlePadding: titlePadding ??
          const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
      backgroundColor: generalConfigController.isDarkMode.value
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.secondary,
      title: titleWidget ??
          ((title?.isNotEmpty ?? false)
              ? Text(
                  title ?? "",
                  textAlign: TextAlign.center,
                )
              : SvgPicture.asset(
                  Assets.check,
                  height: 45,
                )),
      // Image.asset(
      //     appIconImages.selcomFullLogo,
      //     color: blackColor,
      //     height: generalConfigController.dheight.value * 0.035,
      //   )),
      content: message.isNotEmpty
          ? SizedBox(
              width: generalConfigController.dwidth.value,
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.5,
                    color: (generalConfigController.isDarkMode.value)
                        ? Styles.whiteColor
                        : Styles.blackColor),
              ),
            )
          : null,
      actions: <Widget>[
        (isButtonVertical)
            ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: buttons,
              )
            : Row(
                children: buttons,
              )
      ],
    );
  }
}

class CustomDialogButton extends StatelessWidget {
  final bool borderEnable;
  final String? buttonText;
  final VoidCallback? onTap;
  final Color? buttonColor;
  final double? buttonHeight;
  final Color? buttonTextColor;
  final double? width;
  final bool buttonVisible;
  final double? borderRadius;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final double? spaceFromLeft;
  final double? spaceFromRight;
  final Color? iconColor;
  final double? iconSize;
  final bool autoCloseDialogOnButtonTap;

  const CustomDialogButton({
    super.key,
    this.borderEnable = false,
    this.buttonText,
    this.onTap,
    this.buttonColor,
    this.buttonHeight,
    this.buttonTextColor,
    this.width,
    this.buttonVisible = true,
    this.borderRadius,
    this.leftIcon,
    this.rightIcon,
    this.spaceFromLeft,
    this.spaceFromRight,
    this.iconColor,
    this.iconSize,
    this.autoCloseDialogOnButtonTap = true,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: buttonVisible,
      child: GestureDetector(
        onTap: () {
          if (autoCloseDialogOnButtonTap) Get.back();
          if (onTap != null) onTap!();
        },
        child: Container(
          width: width,
          // height: 40.0,
          height: buttonHeight ?? generalConfigController.dheight.value * 0.07,
          decoration: BoxDecoration(
            color: buttonColor ??
                (borderEnable ? Styles.whiteColor : Styles.primaryGreenColor),
            border: Border.all(
                color: borderEnable
                    ? Styles.primaryGreenColor
                    : Colors.transparent),
            borderRadius: BorderRadius.circular(borderRadius ?? 10),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leftIcon != null)
                Icon(
                  leftIcon,
                  color: iconColor ?? Styles.whiteColor,
                  size: iconSize,
                ),
              if (leftIcon != null)
                SizedBox(
                  width: spaceFromLeft ?? 10,
                ),
              Text(
                buttonText ?? "",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: buttonTextColor ??
                          (borderEnable
                              ? Styles.blackColor
                              : Styles.whiteColor),
                    ),
              ),
              if (rightIcon != null)
                SizedBox(
                  width: spaceFromRight ?? 10,
                ),
              if (rightIcon != null)
                Icon(
                  rightIcon,
                  color: iconColor ?? Styles.whiteColor,
                  size: iconSize,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class Dialogs {
  static Future<void> error({
    required String error,
    String? title,
    void Function()? errorAction,
    bool isButtonVertical = false,
    bool canPop = false,
    bool barrierDismissible = true,
    final Color? buttonTextColor,
    final double? buttonHeight,
    final double? buttonWidth,
    final Color? buttonColor,
    final Widget? titleWidget,
  }) async {
    await Get.dialog(
      barrierDismissible: barrierDismissible,
      CustomDialog(
        titleWidget: titleWidget,
        title: title,
        firstButtonColor: buttonColor,
        firstButtonHeight: buttonHeight,
        firstButtonTextColor: buttonTextColor,
        canPop: canPop,
        isButtonVertical: isButtonVertical,
        message: error,
        firstButtonWidth: buttonWidth,
        firstButtonText: "Okay",
        onTapFirstButton: () {
          if (errorAction != null) errorAction();
        },
      ),
    );
  }

  static Future<void> threeButtonDialog({
    required String title,
    required String message,
    void Function()? onTapFirstButton,
    void Function()? onTapSecondButton,
    void Function()? onTapThirdButton,
    String firstButtonText = "",
    String secondButtonText = "",
    String thirdButtonText = "",
    bool firstBorderEnable = true,
    bool secondBorderEnable = true,
    bool thirdBorderEnable = false,
    bool canPop = false,
    bool barrierDismissible = true,
  }) async {
    await Get.dialog(
      barrierDismissible: barrierDismissible,
      CustomDialog(
        canPop: canPop,
        title: title,
        isButtonVertical: true,
        message: message,
        firstButtonText: firstButtonText,
        firstBorderEnable: firstBorderEnable,
        onTapFirstButton: () {
          if (onTapFirstButton != null) onTapFirstButton();
        },
        secondButtonText: secondButtonText,
        secondBorderEnable: secondBorderEnable,
        onTapSecondButton: () {
          if (onTapSecondButton != null) onTapSecondButton();
        },
        thirdButtonText: thirdButtonText,
        thirdBorderEnable: thirdBorderEnable,
        onTapThirdButton: () {
          if (onTapThirdButton != null) onTapThirdButton();
        },
      ),
    );
  }

  static Future<void> twoButtonDialog({
    String? title,
    required String message,
    void Function()? onTapFirstButton,
    void Function()? onTapSecondButton,
    String firstButtonText = "",
    String secondButtonText = "",
    bool firstBorderEnable = false,
    bool secondBorderEnable = true,
    bool canPop = false,
    bool isButtonVertical = true,
    bool barrierDismissible = true,
    final Color? firstButtonTextColor,
    final double? firstButtonHeight,
    final Color? firstButtonColor,
    final Color? secondButtonTextColor,
    final double? secondButtonHeight,
    final double? firstButtonWidth,
    final double? secondButtonWidth,
    final Color? secondButtonColor,
    final Widget? titleWidget,
    final bool isSecondButtonVisible = true,
    final bool isFirstButtonVisible = true,
    final bool backgroundBlur = true,
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
    final bool autoCloseDialogOnFirstButtonTap = true,
    final bool autoCloseDialogOnSecondButtonTap = true,
    final bool autoCloseDialogOnThirdButtonTap = true,
    // final bool isSimilarShowDialog = false,
  }) async {
    generalConfigController.isBlurApplied.value = true;
    await Get.dialog(
      // transitionCurve: Curves.decelerate,
      // transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: barrierDismissible,
      WillPopScope(
        onWillPop: () async {
          return willPopScope;
        },
        child: CustomDialog(
          autoCloseDialogOnFirstButtonTap: autoCloseDialogOnFirstButtonTap,
          autoCloseDialogOnSecondButtonTap: autoCloseDialogOnSecondButtonTap,
          autoCloseDialogOnThirdButtonTap: autoCloseDialogOnThirdButtonTap,
          actionsPadding: actionsPadding,
          contentPadding: contentPadding,
          titlePadding: titlePadding,
          canPop: canPop,
          titleWidget: titleWidget,
          title: title,
          message: message,
          firstButtonText: firstButtonText,
          firstButtonColor: firstButtonColor,
          firstButtonHeight: firstButtonHeight,
          firstButtonTextColor: firstButtonTextColor,
          firstBorderEnable: firstBorderEnable,
          firstButtonWidth: firstButtonWidth,
          secondButtonWidth: secondButtonWidth,
          firstButtonIconColor: firstButtonIconColor,
          firstButtonIconSize: firstButtonIconSize,
          firstButtonLeftIcon: firstButtonLeftIcon,
          firstButtonRightIcon: firstButtonRightIcon,
          firstButtonSpaceFromLeft: firstButtonSpaceFromLeft,
          firstButtonSpaceFromRight: firstButtonSpaceFromRight,
          onTapFirstButton: () {
            if (onTapFirstButton != null) onTapFirstButton();
          },
          secondButtonColor: secondButtonColor,
          secondButtonHeight: secondButtonHeight,
          secondButtonText: secondButtonText,
          secondButtonTextColor: secondButtonTextColor,
          secondBorderEnable: secondBorderEnable,
          secondButtonIconColor: secondButtonIconColor,
          secondButtonIconSize: secondButtonIconSize,
          secondButtonLeftIcon: secondButtonLeftIcon,
          secondButtonRightIcon: secondButtonRightIcon,
          secondButtonSpaceFromLeft: secondButtonSpaceFromLeft,
          secondButtonSpaceFromRight: secondButtonSpaceFromRight,
          onTapSecondButton: () {
            if (onTapSecondButton != null) onTapSecondButton();
          },
          isButtonVertical: isButtonVertical,
          isSecondButtonVisible: isSecondButtonVisible,
          isFirstButtonVisible: isFirstButtonVisible,
        )
            .animate()
            .fade(duration: 400.ms, curve: Curves.fastOutSlowIn)
            .scale(duration: 400.ms, curve: Curves.fastOutSlowIn),
      ),

      // .animate().fade(duration: 300.ms).scale(duration: 300.ms),
    );
    generalConfigController.isBlurApplied.value = false;
  }
}
