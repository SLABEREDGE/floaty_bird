import 'dart:developer';
import 'dart:io';

import 'package:flame_audio/flame_audio.dart';
import 'package:floaty_bird/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../utils/ara_theme.dart';
import '../../../utils/constants.dart';
import '../banner_ad.dart';
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
  Future<void> fetchData() async {
    generalConfigController.gameHighScore.value = await generalConfigController
        .fetchHiveData(fieldName: DBFields.gameHighScore, defaultValue: '0');
    generalConfigController.gameBackgroundImage.value =
        await generalConfigController.fetchHiveData(
            fieldName: DBFields.gameBackgroundImage, defaultValue: '0');
    generalConfigController.isGameSoundOn.value = await generalConfigController
        .fetchHiveData(fieldName: DBFields.gameSoundOn, defaultValue: true);
    widget.game.playSound = generalConfigController.isGameSoundOn.value;
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
  }

  @override
  Widget build(BuildContext context) {
    if (widget.game.playSound) {
      if (widget.game.isBgPlaying) {
        log("widget.game.isBgPlaying ${widget.game.isBgPlaying}");
      } else {
        FlameAudio.bgm.play(
          Assets.homeSong1,
        );
      }
    } else {
      FlameAudio.bgm.pause();
    }
    widget.game.pauseEngine();
    return WillPopScope(
      onWillPop: () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        FlameAudio.bgm.stop();
        return Future.value(true);
      },
      child: Scaffold(
        body: Obx(
          () => Container(
            width: double.infinity,
            height: double.infinity,
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage(
            //  generalConfigController.gameBackgroundImage.value == '0'
            //               ? Assets.cityMenu
            //               : generalConfigController.gameBackgroundImage.value ==
            //                       '1'
            //                   ? Assets.desertMenu
            //                   : generalConfigController
            //                               .gameBackgroundImage.value ==
            //                           '2'
            //                       ? Assets.forestMenu
            //                       : generalConfigController
            //                                   .gameBackgroundImage.value ==
            //                               '3'
            //                           ? Assets.hellMenu
            //                           : generalConfigController
            //                                       .gameBackgroundImage.value ==
            //                                   '4'
            //                               ? Assets.iceMenu
            //                               : generalConfigController
            //                                           .gameBackgroundImage
            //                                           .value ==
            //                                       '5'
            //                                   ? Assets.lavaMenu
            //                                   : generalConfigController
            //                                               .gameBackgroundImage
            //                                               .value ==
            //                                           '6'
            //                                       ? Assets.mountainMenu
            //                                       : generalConfigController
            //                                                   .gameBackgroundImage
            //                                                   .value ==
            //                                               '7'
            //                                           ? Assets.nebulaMenu
            //                                           : generalConfigController
            //                                                       .gameBackgroundImage
            //                                                       .value ==
            //                                                   '8'
            //                                               ? Assets.snowMenu
            //                                               : Assets.walterfallMenu,
            //     ),
            //     fit: BoxFit.cover,
            //   ),
            // ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Obx(
                  () => Image.asset(
                    generalConfigController.gameBackgroundImage.value == '0'
                        ? Assets.cityMenu
                        : generalConfigController.gameBackgroundImage.value ==
                                '1'
                            ? Assets.desertMenu
                            : generalConfigController
                                        .gameBackgroundImage.value ==
                                    '2'
                                ? Assets.forestMenu
                                : generalConfigController
                                            .gameBackgroundImage.value ==
                                        '3'
                                    ? Assets.hellMenu
                                    : generalConfigController
                                                .gameBackgroundImage.value ==
                                            '4'
                                        ? Assets.iceMenu
                                        : generalConfigController
                                                    .gameBackgroundImage
                                                    .value ==
                                                '5'
                                            ? Assets.lavaMenu
                                            : generalConfigController
                                                        .gameBackgroundImage
                                                        .value ==
                                                    '6'
                                                ? Assets.mountainMenu
                                                : generalConfigController
                                                            .gameBackgroundImage
                                                            .value ==
                                                        '7'
                                                    ? Assets.nebulaMenu
                                                    : generalConfigController
                                                                .gameBackgroundImage
                                                                .value ==
                                                            '8'
                                                        ? Assets.snowMenu
                                                        : Assets.walterfallMenu,
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
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        Text(
                          'Flappy Bird',
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
                          'Flappy Bird',
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
                      Assets.bird,
                      height: 100.0.h,
                    )
                        .animate(
                          autoPlay: true,
                          onPlay: (controller) => controller.repeat(
                            reverse: true,
                          ),
                        )
                        .scale(
                          duration: 1300.ms,
                          begin: const Offset(0.95, 0.95),
                          end: const Offset(1, 1),
                          curve: Curves.easeInOut,
                        ),
                    // .moveY(
                    //   duration: 1000.ms,
                    //   begin: 0,
                    //   end: 15,
                    //   curve: Curves.easeInOut,
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    (generalConfigController.isGameBackgroundChange.value ==
                            false)
                        ? GestureDetector(
                            onTap: () async {
                              if (generalConfigController.isGameSoundOn.value) {
                                FlameAudio.bgm.pause();
                              }
                              widget.game.overlays.remove('mainMenu');
                              widget.game.overlays.add("bannerAd");
                              widget.game.overlays.add('pauseMenuButton');
                              widget.game.interval.reset();
                              widget.game.bird.resetBird();
                              widget.game.bird.resetScore();
                              widget.game.resumeEngine();
                              if (generalConfigController.isGameSoundOn.value) {
                                FlameAudio.bgm.play(Assets.gamePlaySong);
                              }
                              generalConfigController
                                  .userResumedUsingAds.value = false;
                            },
                            child: BouncingWidget(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SvgPicture.asset(
                                    Assets.adsButton,
                                    height: 60,
                                  ),
                                  Text(
                                    'Tap to Start',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontFamily: 'Marker',
                                      letterSpacing: 1.5,
                                      // fontWeight: FontWeight.bold,
                                      foreground: Paint()
                                        ..style = PaintingStyle.stroke
                                        ..strokeWidth = 2
                                        ..color = Styles.darkGreyColor,
                                      shadows: <Shadow>[
                                        const Shadow(
                                          offset: Offset(3, 3),
                                          blurRadius: 5.0,
                                          color:
                                              Color.fromARGB(255, 68, 68, 68),
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
                                    'Tap to Start',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      letterSpacing: 1.5,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: 'Marker',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                            .animate(
                              autoPlay: true,
                              onPlay: (controller) => controller.repeat(
                                reverse: true,
                              ),
                            )
                            .scale(
                              duration: 1300.ms,
                              begin: const Offset(0.95, 0.95),
                              end: const Offset(1, 1),
                              curve: Curves.easeInOut,
                            )
                        : const CircularProgressIndicator(
                            color: Styles.whiteColor,
                          ),
                    // const SizedBox(
                    //   height: 30,
                    // ),
                  ],
                ),
                SettingsMenuButton(game: widget.game),
                MyBannerAdWidget(game: widget.game),
                Positioned(
                  // top: MediaQuery.sizeOf(context).height / 2 * 0.155,
                  top: MediaQuery.sizeOf(context).height / 2 * 0.25,
                  left: 20,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset(
                        Assets.highScore,
                        height: 50,
                      ),
                      Obx(
                        () => Text(
                          'High Score : ${generalConfigController.gameHighScore.value}',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Marker',
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
                            fontFamily: 'Marker',
                            height: 1.1,
                          ),
                        ),
                      ),
                    ],
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
                                  } else if (index == 6) {
                                    generalConfigController
                                        .gameBackgroundImage.value = '6';
                                    await generalConfigController.setHiveData(
                                      fieldName: DBFields.gameBackgroundImage,
                                      data: '6',
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
                                  } else if (index == 7) {
                                    generalConfigController
                                        .gameBackgroundImage.value = '7';
                                    await generalConfigController.setHiveData(
                                      fieldName: DBFields.gameBackgroundImage,
                                      data: '7',
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
                                  } else if (index == 8) {
                                    generalConfigController
                                        .gameBackgroundImage.value = '8';
                                    await generalConfigController.setHiveData(
                                      fieldName: DBFields.gameBackgroundImage,
                                      data: '8',
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
                                  } else if (index == 9) {
                                    generalConfigController
                                        .gameBackgroundImage.value = '9';
                                    await generalConfigController.setHiveData(
                                      fieldName: DBFields.gameBackgroundImage,
                                      data: '9',
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

                                  await widget.game.background.onLoad();
                                  await widget.game.ground.onLoad();
                                  // await widget.game.background.getBackground();
                                  // await widget.game.ground.getGround();
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    right: index == 9 ? 20 : 0,
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
                                                ? Colors.lime
                                                : Styles.whiteColor,
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
                                                  ? Assets.cityFrame
                                                  : index == 1
                                                      ? Assets.deserFrame
                                                      : index == 2
                                                          ? Assets.forestFrame
                                                          : index == 3
                                                              ? Assets.hellFrame
                                                              : index == 4
                                                                  ? Assets
                                                                      .iceFrame
                                                                  : index == 5
                                                                      ? Assets
                                                                          .lavaFrame
                                                                      : index ==
                                                                              6
                                                                          ? Assets
                                                                              .mountainFrame
                                                                          : index == 7
                                                                              ? Assets.nebulaFrame
                                                                              : index == 8
                                                                                  ? Assets.snowFrame
                                                                                  : Assets.walterfallFrame,
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
                                                  // ? Styles.primaryGreenColor
                                                  //     .withOpacity(0.6)
                                                  ? Styles.blackColor
                                                      .withOpacity(0.6)
                                                  // : Styles.blackColor
                                                  //     .withOpacity(0.5),
                                                  : null,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                index ==
                                                        int.parse(
                                                          generalConfigController
                                                              .gameBackgroundImage
                                                              .value,
                                                        )
                                                    ? "Selected"
                                                    : "",
                                                style: TextStyle(
                                                  fontSize: 16.0.sp,
                                                  color: Colors.white,
                                                  fontFamily: 'Marker',
                                                  letterSpacing: 1.5,
                                                  height: 0.8,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 10,
                                        right: 10,
                                        child: Container(
                                          height: 28,
                                          width: 28,
                                          child: index ==
                                                  int.parse(
                                                    generalConfigController
                                                        .gameBackgroundImage
                                                        .value,
                                                  )
                                              ? SvgPicture.asset(Assets.check)
                                              : const SizedBox.shrink(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: 10,
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
