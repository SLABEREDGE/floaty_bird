import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../utils/ara_theme.dart';

class GeneralConfigController extends GetxController {
  RxDouble dheight = 0.0.obs;
  RxDouble dwidth = 0.0.obs;
  RxDouble safePadding = 0.0.obs;
  RxString preferredLang = "".obs;
  RxBool isLoggedIn = false.obs;
  RxBool isWelcomed = false.obs;
  RxBool isContinueButtonActive = false.obs;
  Rx<dynamic> dbBox = Object().obs;
  RxBool isLoaderActive = false.obs;
  RxString deviceToken = "".obs;
  RxString intUDID = "".obs;
  RxDouble lat = 0.0.obs;
  RxDouble long = 0.0.obs;

  RxBool isFromSplash = false.obs;
  RxBool isDarkMode = false.obs;
  RxBool isBlurApplied = false.obs;
  RxBool bottomSheetOpen = false.obs;
  RxBool iserrorDialogShown = false.obs;
  RxDouble bottomsheetHeight = 0.0.obs;
  RxBool flashStatus = false.obs;

  //alpha numberic keyboard
  RxBool isNumKeyPressed = false.obs;
  RxBool isShiftKeyPressed = false.obs;

  //game
  RxBool onSelectGame = false.obs;
  RxString gameHighScore = "0".obs;
  RxString gameBackgroundImage = "0".obs;
  RxBool isGameBackgroundChange = false.obs;
  RxBool isGameSoundOn = false.obs;

  // Hive Methods
  Future<void> openHiveBox() async {
    var box = await Hive.openBox('araBox');
    dbBox.value = box;
  }

  fetchHiveData({required String fieldName, var defaultValue}) async {
    if (await Hive.boxExists('araBox') && Hive.isBoxOpen('araBox')) {
      var data = dbBox.value!.get(fieldName) ?? defaultValue;
      // log("Data retrieved from Hive Hive with following structure \n {$fieldName : $data}");
      return data;
    }
  }

  Future<void> setHiveData({required String fieldName, var data}) async {
    await dbBox.value?.put(fieldName, data);
  }

  // Common Params Fetching Methods
}

GeneralConfigController generalConfigController = GeneralConfigController();
