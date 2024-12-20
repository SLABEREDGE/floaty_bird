import 'dart:developer';
import 'dart:io';

import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:floaty_bird/componets/resume_countdown_widget.dart';
import 'package:floaty_bird/controller/general_config_controller.dart';
import 'package:floaty_bird/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../banner_ad.dart';
import '../componets/pause_menu_button.dart';
import '../game/floaty_bird_game.dart';
import '../utils/ara_theme.dart';
import '../utils/assets.dart';
import '../utils/constants.dart';
import '../utils/internet_service.dart';
import 'game_over_screen.dart';
import 'main_menu_screen.dart';
import 'pause_menu_screen.dart';
import 'watch_ads_to_resume.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with WidgetsBindingObserver {
  final game = FloatyBirdGame();
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    fetchData2();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await checkInternet();
    });
    super.initState();
  }

  Future<void> checkInternet() async {
    if (await InternetService.instance.checkInternet()) {
      await Future.delayed(const Duration(milliseconds: 4250));
      fetchData();
    } else {
      await Get.dialog(
        PopScope(
          canPop: false,
          child: NoInternetDialog(
            onTapFirstButton: () async {
              if (await InternetService.instance.checkInternet()) {
                fetchData();
              } else {
                await checkInternet();
              }
            },
            onTapSecondButton: () async {
              fetchData();
            },
          ),
        ),
        barrierDismissible: false,
      );
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (generalConfigController.isGameSoundOn.value) {
          FlameAudio.bgm.resume();
        }
        log("RESUMED ====>");
        break;
      case AppLifecycleState.inactive:
        log("INACTIVE ====>");
        break;
      case AppLifecycleState.paused:
        if (generalConfigController.isGameSoundOn.value) {
          FlameAudio.bgm.pause();
        }
        log("PAUSED ====>");
        break;
      case AppLifecycleState.detached:
        if (generalConfigController.isGameSoundOn.value) {
          FlameAudio.bgm.pause();
        }
        log("DETACHED ====>");
        break;
      case AppLifecycleState.hidden:
        print("hidden");
        break;
    }
  }

  Future<void> fetchData2() async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Platform.isAndroid ? Colors.transparent : null,
        statusBarIconBrightness: Platform.isAndroid ? Brightness.light : null,
      ),
    );
    generalConfigController.isGameSplashAnimating.value = true;
    generalConfigController.isBirdSwitched.value = true;
    await Future.delayed(const Duration(milliseconds: 1200));
    generalConfigController.isBirdSwitched.value = false;
    await Future.delayed(const Duration(milliseconds: 1200));
    generalConfigController.isBirdSwitched.value = true;
    await Future.delayed(const Duration(milliseconds: 1200));
    generalConfigController.isBirdSwitched.value = false;
    await Future.delayed(const Duration(milliseconds: 600));
    game.playSound = await generalConfigController.fetchHiveData(
        fieldName: DBFields.gameSoundOn, defaultValue: true);
    generalConfigController.gameHighScore.value = await generalConfigController
        .fetchHiveData(fieldName: DBFields.gameHighScore, defaultValue: '0');
    generalConfigController.gameBackgroundImage.value =
        await generalConfigController.fetchHiveData(
            fieldName: DBFields.gameBackgroundImage, defaultValue: '0');
    generalConfigController.isGameSoundOn.value = await generalConfigController
        .fetchHiveData(fieldName: DBFields.gameSoundOn, defaultValue: true);
    generalConfigController.gameBirdImage.value = await generalConfigController
        .fetchHiveData(fieldName: DBFields.gameBirdImage, defaultValue: "1");
    // .fetchHiveData(fieldName: DBFields.gameBirdImage, defaultValue: "0");
    game.playSound = generalConfigController.isGameSoundOn.value;
    generalConfigController.loadRewardedAd(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-7487124206061387/4696479208' // rewarded ad
          // ? 'ca-app-pub-3940256099942544/5224354917' //test rewared ad
          : '',
      game: game,
    );
  }

  Future<void> fetchData() async {
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(
    //     statusBarColor: Platform.isAndroid ? Colors.transparent : null,
    //     statusBarIconBrightness: Platform.isAndroid ? Brightness.light : null,
    //   ),
    // );
    // generalConfigController.isGameSplashAnimating.value = true;
    // generalConfigController.isBirdSwitched.value = true;
    // await Future.delayed(const Duration(milliseconds: 1200));
    // generalConfigController.isBirdSwitched.value = false;
    // await Future.delayed(const Duration(milliseconds: 1200));
    // generalConfigController.isBirdSwitched.value = true;
    // await Future.delayed(const Duration(milliseconds: 1200));
    // generalConfigController.isBirdSwitched.value = false;
    // await Future.delayed(const Duration(milliseconds: 600));
    // game.playSound = await generalConfigController.fetchHiveData(
    //     fieldName: DBFields.gameSoundOn, defaultValue: true);
    generalConfigController.loadRewardedAd(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-7487124206061387/4696479208' // rewarded ad
          // ? 'ca-app-pub-3940256099942544/5224354917' //test rewared ad
          : '',
      game: game,
    );

    await Get.offAll(
      () => GameWidget(
        game: game,
        initialActiveOverlays: const [MainMenuScreen.id],
        overlayBuilderMap: {
          'mainMenu': (context, _) => MainMenuScreen(game: game),
          'gameOver': (context, _) => GameOverScreen(game: game),
          'bannerAd': (context, _) => MyBannerAdWidget(game: game),
          'WatchAdsToResume': (context, _) => WatchAdsToResume(game: game),
          'countDown': (context, _) => ResumeCountDownWidget(game: game),
          'pauseMenuButton': (context, _) => WillPopScope(
              onWillPop: () {
                if (!game.isHit) {
                  game.overlays.add('pauseMenuScreen');
                }
                return Future.value(false);
              },
              child: PauseMenuButton(game: game)),
          'pauseMenuScreen': (context, _) => PauseMenuScreen(game: game),
          // 'rewardAd': (context, _) => RewardAdWidget(game: game),
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    generalConfigController.dheight.value = MediaQuery.of(context).size.height;
    generalConfigController.dwidth.value = MediaQuery.of(context).size.width;
    generalConfigController.safePadding.value =
        MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Styles.lightGreenColor,
      body: Container(
        color: Styles.darkThemePrimaryColor,
        height: generalConfigController.dheight.value,
        width: generalConfigController.dwidth.value,
        child: Center(
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 150.0.h,
                    width: 150.0.h,
                  ),
                  Text(
                    // 'Floaty Bird',
                    'Flying Bird',
                    style: TextStyle(
                      fontSize: 60.0.sp,
                      color: Colors.orangeAccent,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Game',
                      letterSpacing: 1.5,
                      // shadows: <Shadow>[
                      //   Shadow(
                      //     offset: Offset(5, 5),
                      //     blurRadius: 5.0,
                      //     color: Colors.grey,
                      //   ),
                      //   Shadow(
                      //     offset: Offset(5, 5),
                      //     blurRadius: 10.0,
                      //     color: Colors.black,
                      //   ),
                      // ],
                    ),
                  )
                      .animate(
                          target: generalConfigController
                                  .isGameSplashAnimating.value
                              ? 1
                              : 0)
                      .then(delay: 350.ms)
                      .slideY(
                        duration: 500.ms,
                        begin: 0,
                        end: 0.4,
                      )
                      .then(delay: 500.ms)
                      .slideY(
                        duration: 500.ms,
                        begin: 0.15,
                        end: -0.05,
                      )
                      .then(delay: 900.ms)
                      .slideY(
                        duration: 500.ms,
                        end: 0.3,
                      ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(
                    () => AnimatedSwitcher(
                            reverseDuration: const Duration(milliseconds: 1000),
                            duration: const Duration(milliseconds: 1000),
                            switchInCurve: Curves.ease,
                            switchOutCurve: Curves.ease,
                            child: generalConfigController.isBirdSwitched.value
                                ? Image.asset(
                                    Assets.splash2,
                                    height: 150.0.h,
                                    width: 150.0.h,
                                  )
                                : Image.asset(
                                    Assets.splash,
                                    height: 150.0.h,
                                    width: 150.0.h,
                                  ))
                        .animate(
                            target: generalConfigController
                                    .isGameSplashAnimating.value
                                ? 1
                                : 0)
                        .slideY(
                          duration: 800.ms,
                          begin: 0,
                          end: 0.3,
                        )
                        .then(delay: 500.ms)
                        .slideY(
                          duration: 500.ms,
                          begin: 0.15,
                          end: 0,
                        )
                        .then(delay: 500.ms)
                        .slideY(
                          curve: Curves.easeIn,
                          duration: 800.ms,
                          end: 0.2,
                        ),
                  ),
                  Text(
                    'Flying Bird',
                    // 'Floaty Bird',
                    style: TextStyle(
                      fontSize: 60.0.sp,
                      color: Colors.transparent,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Game',
                      letterSpacing: 1.5,
                    ),
                  )
                ],
              )
            ],
          ),
        ).animate().then(delay: 3500.ms).slideY(
              begin: 0,
              end: -0.3,
              curve: Curves.ease,
            ),
      ),
    );
  }
}

class NoInternetDialog extends StatefulWidget {
  final VoidCallback? onTapFirstButton;
  final VoidCallback? onTapSecondButton;

  const NoInternetDialog(
      {super.key, this.onTapFirstButton, this.onTapSecondButton});

  @override
  State<NoInternetDialog> createState() => _NoInternetDialogState();
}

class _NoInternetDialogState extends State<NoInternetDialog> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 0, right: 20, left: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Styles.whiteColor,
              ),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "No Internet",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontFamily: "marker",
                          color: Styles.blackColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 24.0.sp,
                        ),
                    // TextStyle(
                    //   fontFamily: "marker",
                    //   color: Styles.blackColor,
                    //   fontWeight: FontWeight.normal,
                    //   fontSize: 24.0.sp,
                    // ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Uh oh! Looks like you're not online. You can still play, but some cool stuff might be missing. Want to connect?",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 16.0.sp,
                          fontFamily: "sofia",
                          fontWeight: FontWeight.normal,
                          color: Styles.blackColor,
                          height: 1.4,
                        ),
                    // TextStyle(
                    //   fontSize: 16.0.sp,
                    //   fontFamily: "sofia",
                    //   fontWeight: FontWeight.normal,
                    //   color: Styles.blackColor,
                    //   height: 1.4,
                    // ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (widget.onTapFirstButton != null) {
                        Get.back();
                        widget.onTapFirstButton!();
                      }
                    },
                    child: Container(
                      height: generalConfigController.dheight.value * 0.07,
                      decoration: BoxDecoration(
                        color: Styles.primaryGreenColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Try Again",
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontSize: 16.0.sp,
                                    fontFamily: "sofia",
                                    fontWeight: FontWeight.normal,
                                    color: Styles.whiteColor,
                                  ),
                          //  TextStyle(
                          //   fontSize: 16.0.sp,
                          //   fontFamily: "sofia",
                          //   fontWeight: FontWeight.normal,
                          //   color: Styles.whiteColor,
                          // ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (widget.onTapSecondButton != null) {
                        Get.back();
                        widget.onTapSecondButton!();
                      }
                    },
                    child: Container(
                      height: generalConfigController.dheight.value * 0.06,
                      color: Colors.transparent,
                      child: Center(
                        child: Text(
                          "Continue without Internet",
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontSize: 16.0.sp,
                                    fontFamily: "sofia",
                                    fontWeight: FontWeight.normal,
                                    color: Styles.lightGreyTextColor,
                                  ),
                          //  TextStyle(
                          //   fontSize: 16.0.sp,
                          //   fontFamily: "sofia",
                          //   fontWeight: FontWeight.normal,
                          //   color: Styles.lightGreyTextColor,
                          // ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
                .animate()
                .fade(duration: 400.ms, curve: Curves.fastOutSlowIn)
                .scale(duration: 400.ms, curve: Curves.fastOutSlowIn),
          ),
        ],
      ),
    );
  }
}
