import 'dart:io';

import 'package:floaty_bird/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../../utils/ara_theme.dart';
import '../../../utils/constants.dart';
import '../componets/setting_menu_button.dart';
import '../controller/general_config_controller.dart';
import '../game/floaty_bird_game.dart';
import '../utils/assets.dart';
import '../utils/bouncing_widget.dart';

class MainMenuScreen extends StatefulWidget {
  final FloatyBirdGame game;
  static const String id = 'mainMenu';
  const MainMenuScreen({super.key, required this.game});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  int seletectMap = 0;
  DateTime? _lastBackPressed;
  Future<void> fetchData() async {
    generalConfigController.gameHighScore.value = await generalConfigController
        .fetchHiveData(fieldName: DBFields.gameHighScore, defaultValue: '0');
    generalConfigController.gameBackgroundImage.value =
        await generalConfigController.fetchHiveData(
            fieldName: DBFields.gameBackgroundImage, defaultValue: '0');
    generalConfigController.isGameSoundOn.value = await generalConfigController
        .fetchHiveData(fieldName: DBFields.gameSoundOn, defaultValue: true);
  }

  @override
  void initState() {
    fetchData();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Platform.isAndroid ? Brightness.light : null,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: SystemUiOverlay.values); // to re-show bars
  }

  void showGeneralToastMessage(
      {String? message, Duration? duration, SnackPosition? snackPosition}) {
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
        backgroundColor: Styles.darkThemePrimaryColor,
        messageText: Text(
          message ?? "",
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Styles.whiteColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    widget.game.pauseEngine();
    return WillPopScope(
      onWillPop: () {
        if (_lastBackPressed == null ||
            DateTime.now().difference(_lastBackPressed!) >
                const Duration(seconds: 2)) {
          _lastBackPressed = DateTime.now();
          showGeneralToastMessage(
              message: 'Press back again to exit game',
              snackPosition: SnackPosition.BOTTOM);
          return Future.value(false);
        }
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return Future.value(true);
      },
      child: Scaffold(
        body: Obx(
          () => Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  generalConfigController.gameBackgroundImage.value == '0'
                      ? Assets.walterfallMenu
                      : generalConfigController.gameBackgroundImage.value == '1'
                          ? Assets.forestMenu
                          : generalConfigController.gameBackgroundImage.value ==
                                  '2'
                              ? Assets.ruinsMenu
                              : generalConfigController
                                          .gameBackgroundImage.value ==
                                      '3'
                                  ? Assets.templeMenu
                                  : generalConfigController
                                              .gameBackgroundImage.value ==
                                          '4'
                                      ? Assets.villageMenu
                                      : Assets.village2Menu,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Obx(
                  () => Image.asset(
                    generalConfigController.gameBackgroundImage.value == '0'
                        ? Assets.walterfallMenu
                        : generalConfigController.gameBackgroundImage.value ==
                                '1'
                            ? Assets.forestMenu
                            : generalConfigController
                                        .gameBackgroundImage.value ==
                                    '2'
                                ? Assets.ruinsMenu
                                : generalConfigController
                                            .gameBackgroundImage.value ==
                                        '3'
                                    ? Assets.templeMenu
                                    : generalConfigController
                                                .gameBackgroundImage.value ==
                                            '4'
                                        ? Assets.villageMenu
                                        : Assets.village2Menu,
                    height: generalConfigController.dheight.value,
                    width: generalConfigController.dwidth.value,
                    fit: BoxFit.cover,
                  )
                      .animate(
                          target: generalConfigController
                                  .isGameBackgroundChange.value
                              ? 1
                              : 0)
                      .shimmer(
                        duration: 800.ms,
                      ),
                ),
                SettingsMenuButton(game: widget.game),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        Text(
                          'Floaty Bird',
                          style: TextStyle(
                            fontSize: 65,
                            fontFamily: 'Game',
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 3
                              ..color = Styles.darkGreyColor,
                            shadows: <Shadow>[
                              const Shadow(
                                offset: Offset(5, 5),
                                blurRadius: 5.0,
                                color: Colors.grey,
                              ),
                              Shadow(
                                offset: const Offset(5, 5),
                                blurRadius: 10.0,
                                color: Colors.black.withOpacity(0.8),
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          'Floaty Bird',
                          style: TextStyle(
                            fontSize: 65,
                            color: Colors.white,
                            fontFamily: 'Game',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Stack(
                      children: [
                        Text(
                          'Get Ready',
                          style: TextStyle(
                            fontSize: 50,
                            fontFamily: 'Game',
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 8
                              ..color = Styles.blackColor,
                            shadows: <Shadow>[
                              const Shadow(
                                offset: Offset(5, 5),
                                blurRadius: 5.0,
                                color: Colors.grey,
                              ),
                              Shadow(
                                offset: const Offset(5, 5),
                                blurRadius: 10.0,
                                color: Colors.black.withOpacity(0.8),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Get Ready',
                          style: TextStyle(
                            fontSize: 50,
                            fontFamily: 'Game',
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 3
                              ..color = Styles.whiteColor,
                          ),
                        ),
                        const Text(
                          'Get Ready',
                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.orange,
                            fontFamily: 'Game',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      'assets/images/bird_upflap.png',
                      height: 100.0.h,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    (generalConfigController.isGameBackgroundChange.value ==
                            false)
                        ? GestureDetector(
                            onTap: () {
                              widget.game.overlays.remove('mainMenu');
                              widget.game.overlays.add('pauseMenuButton');
                              widget.game.resumeEngine();
                            },
                            child: BouncingWidget(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/button.png',
                                    height: 55,
                                    // width: 300,
                                    fit: BoxFit.cover,
                                  ),
                                  Text(
                                    'Tap to start',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'sofia',
                                      fontWeight: FontWeight.bold,
                                      foreground: Paint()
                                        ..style = PaintingStyle.stroke
                                        ..strokeWidth = 2
                                        ..color = Styles.darkGreyColor,
                                      shadows: <Shadow>[
                                        const Shadow(
                                          offset: Offset(3, 3),
                                          blurRadius: 5.0,
                                          color: Colors.grey,
                                        ),
                                        Shadow(
                                          offset: const Offset(3, 3),
                                          blurRadius: 10.0,
                                          color: Colors.black.withOpacity(0.8),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Text(
                                    'Tap to start',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'sofia',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const CircularProgressIndicator(
                            color: Styles.whiteColor,
                          ),
                    // const SizedBox(
                    //   height: 30,
                    // ),
                  ],
                ),
                Positioned(
                  top: MediaQuery.sizeOf(context).height / 2 * 0.155,
                  left: 20,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      // color: Colors.blueAccent,
                      color: Colors.indigoAccent,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          offset: const Offset(4, 4),
                          blurRadius: 8.0,
                          color: Styles.whiteColor.withOpacity(0.3),
                        ),
                        BoxShadow(
                          offset: const Offset(4, 4),
                          blurRadius: 8.0,
                          color: Styles.blackColor.withOpacity(0.6),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Obx(
                          () => Text(
                            'High Score : ${generalConfigController.gameHighScore.value}',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'sofia',
                              height: 1.1,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 1
                                ..color = Styles.darkGreyColor,
                              shadows: <Shadow>[
                                const Shadow(
                                  offset: Offset(2, 2),
                                  blurRadius: 5.0,
                                  color: Colors.grey,
                                ),
                                Shadow(
                                  offset: const Offset(2, 2),
                                  blurRadius: 6.0,
                                  color: Colors.black.withOpacity(0.8),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Obx(
                          () => Text(
                            'High Score : ${generalConfigController.gameHighScore.value}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'sofia',
                              height: 1.1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: SizedBox(
                      height: generalConfigController.dheight.value * 0.18,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return BouncingWidget(
                            child: Obx(
                              () => GestureDetector(
                                onTap: () async {
                                  if (index == 0) {
                                    generalConfigController
                                        .gameBackgroundImage.value = '0';
                                    await generalConfigController.setHiveData(
                                      fieldName: DBFields.gameBackgroundImage,
                                      data: '0',
                                    );
                                    if (index != seletectMap) {
                                      generalConfigController
                                          .isGameBackgroundChange.value = true;
                                      await Future.delayed(
                                          const Duration(milliseconds: 1000));
                                      generalConfigController
                                          .isGameBackgroundChange.value = false;
                                    }
                                    seletectMap = index;
                                  } else if (index == 1) {
                                    generalConfigController
                                        .gameBackgroundImage.value = '1';
                                    await generalConfigController.setHiveData(
                                      fieldName: DBFields.gameBackgroundImage,
                                      data: '1',
                                    );
                                    if (index != seletectMap) {
                                      generalConfigController
                                          .isGameBackgroundChange.value = true;
                                      await Future.delayed(
                                          const Duration(milliseconds: 1000));
                                      generalConfigController
                                          .isGameBackgroundChange.value = false;
                                    }
                                    seletectMap = index;
                                  } else if (index == 2) {
                                    generalConfigController
                                        .gameBackgroundImage.value = '2';
                                    await generalConfigController.setHiveData(
                                      fieldName: DBFields.gameBackgroundImage,
                                      data: '2',
                                    );
                                    if (index != seletectMap) {
                                      generalConfigController
                                          .isGameBackgroundChange.value = true;
                                      await Future.delayed(
                                          const Duration(milliseconds: 1000));
                                      generalConfigController
                                          .isGameBackgroundChange.value = false;
                                    }
                                    seletectMap = index;
                                  } else if (index == 3) {
                                    generalConfigController
                                        .gameBackgroundImage.value = '3';
                                    await generalConfigController.setHiveData(
                                      fieldName: DBFields.gameBackgroundImage,
                                      data: '3',
                                    );
                                    if (index != seletectMap) {
                                      generalConfigController
                                          .isGameBackgroundChange.value = true;
                                      await Future.delayed(
                                          const Duration(milliseconds: 1000));
                                      generalConfigController
                                          .isGameBackgroundChange.value = false;
                                    }
                                    seletectMap = index;
                                  } else if (index == 4) {
                                    generalConfigController
                                        .gameBackgroundImage.value = '4';
                                    await generalConfigController.setHiveData(
                                      fieldName: DBFields.gameBackgroundImage,
                                      data: '4',
                                    );
                                    if (index != seletectMap) {
                                      generalConfigController
                                          .isGameBackgroundChange.value = true;
                                      await Future.delayed(
                                          const Duration(milliseconds: 1000));
                                      generalConfigController
                                          .isGameBackgroundChange.value = false;
                                    }
                                    seletectMap = index;
                                  } else if (index == 5) {
                                    generalConfigController
                                        .gameBackgroundImage.value = '5';
                                    await generalConfigController.setHiveData(
                                      fieldName: DBFields.gameBackgroundImage,
                                      data: '5',
                                    );
                                    if (index != seletectMap) {
                                      generalConfigController
                                          .isGameBackgroundChange.value = true;
                                      await Future.delayed(
                                          const Duration(milliseconds: 1000));
                                      generalConfigController
                                          .isGameBackgroundChange.value = false;
                                    }
                                    seletectMap = index;
                                  } else {
                                    generalConfigController
                                        .gameBackgroundImage.value = '0';
                                    await generalConfigController.setHiveData(
                                      fieldName: DBFields.gameBackgroundImage,
                                      data: '0',
                                    );
                                    if (index != seletectMap) {
                                      generalConfigController
                                          .isGameBackgroundChange.value = true;
                                      await Future.delayed(
                                          const Duration(milliseconds: 1000));
                                      generalConfigController
                                          .isGameBackgroundChange.value = false;
                                    }
                                    seletectMap = index;
                                  }

                                  await widget.game.background.getBackground();
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    right: index == 5 ? 20 : 0,
                                  ),
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: generalConfigController
                                                .dheight.value *
                                            0.16,
                                        width: generalConfigController
                                                .dwidth.value *
                                            0.26,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: index ==
                                                    int.parse(
                                                      generalConfigController
                                                          .gameBackgroundImage
                                                          .value,
                                                    )
                                                ? Styles.whiteColor
                                                : Styles.lightCreamColor,
                                            width: 3,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: index ==
                                                  int.parse(
                                                    generalConfigController
                                                        .gameBackgroundImage
                                                        .value,
                                                  )
                                              ? <BoxShadow>[
                                                  BoxShadow(
                                                    offset: const Offset(4, 4),
                                                    blurRadius: 8.0,
                                                    color: Styles.whiteColor
                                                        .withOpacity(0.3),
                                                  ),
                                                  BoxShadow(
                                                    offset: const Offset(4, 4),
                                                    blurRadius: 8.0,
                                                    color: Styles.blackColor
                                                        .withOpacity(0.6),
                                                  ),
                                                ]
                                              : null,
                                          image: DecorationImage(
                                            image: AssetImage(
                                              index == 0
                                                  ? 'assets/images/background_waterfall.png'
                                                  : index == 1
                                                      ? 'assets/images/background_forest.png'
                                                      : index == 2
                                                          ? 'assets/images/background_ruins.png'
                                                          : index == 3
                                                              ? 'assets/images/background_temple.png'
                                                              : index == 4
                                                                  ? 'assets/images/background_village.png'
                                                                  : 'assets/images/background_village2.png',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            width: generalConfigController
                                                    .dwidth.value *
                                                0.26,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: index ==
                                                      int.parse(
                                                        generalConfigController
                                                            .gameBackgroundImage
                                                            .value,
                                                      )
                                                  ? Styles.primaryGreenColor
                                                      .withOpacity(0.6)
                                                  : Styles.blackColor
                                                      .withOpacity(0.5),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                index == 0
                                                    ? 'WaterFall'
                                                    : index == 1
                                                        ? 'Forest'
                                                        : index == 2
                                                            ? 'Ruins'
                                                            : index == 3
                                                                ? 'Temple'
                                                                : index == 4
                                                                    ? 'Village'
                                                                    : 'Village 2',
                                                style: TextStyle(
                                                  fontSize: 16.0.sp,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'sofia',
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: index ==
                                                    int.parse(
                                                      generalConfigController
                                                          .gameBackgroundImage
                                                          .value,
                                                    )
                                                ? Styles.primaryGreenColor
                                                : Styles.lightCreamColor,
                                          ),
                                          child: Icon(
                                            Icons.check,
                                            size: 20,
                                            color: index ==
                                                    int.parse(
                                                      generalConfigController
                                                          .gameBackgroundImage
                                                          .value,
                                                    )
                                                ? Styles.whiteColor
                                                : Styles.lightCreamColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: 6,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
