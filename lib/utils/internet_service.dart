import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import 'common_methods.dart';

class InternetService {
  static InternetService? _instance;

  InternetService._internal();

  static InternetService get instance {
    _instance ??= InternetService._internal();
    return _instance!;
  }

  final connectivity = Connectivity();

  bool _isDialogShowing = false;

  bool isAppOpenForTheFirstTime = true;

  void listen() {
    isAppOpenForTheFirstTime = true;

    connectivity.onConnectivityChanged.listen((result) {
      log("connectivity status: $result");
      bool isDeviceConnectedWithInternet =
          result == ConnectivityResult.mobile ||
              result == ConnectivityResult.wifi;
      log("Internet connection status: $isDeviceConnectedWithInternet");
      if (isDeviceConnectedWithInternet) {
        internetConnectionAvailableToast();
      } else {
        noInternetConnectionDialog();
      }
    });
  }

  Future<bool> checkInternet() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> noInternetConnectionDialog() async {
    log("Your phone is not connected to the internet. Please check your data/wifi connection and try again.");
    if (!_isDialogShowing && !isAppOpenForTheFirstTime) {
      if (Get.isSnackbarOpen) {
        Get.back();
      }

      _isDialogShowing = true;
      showDialogWithMessage(
        message:
            "Your phone is not connected to the internet. Please check your data/wifi connection and try again.",
      ).then(
        (value) => _isDialogShowing = false,
      );
    }
  }

  void internetConnectionAvailableToast() {
    log(
      "Your phone is not connected to the internet. Please check your data/wifi connection and try again.",
    );

    if (_isDialogShowing) {
      Get.back();
    }

    if (!isAppOpenForTheFirstTime) {
      showGeneralToastMessage(
        message:
            "Your phone is not connected to the internet. Please check your data/wifi connection and try again.",
      );
    }
  }
}
