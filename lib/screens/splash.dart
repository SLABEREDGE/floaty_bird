import 'dart:io';
import 'package:flame/game.dart';
import 'package:floaty_bird/controller/general_config_controller.dart';
import 'package:floaty_bird/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../componets/pause_menu_button.dart';
import '../game/floaty_bird_game.dart';
import '../utils/ara_theme.dart';
import '../utils/assets.dart';
import 'game_over_screen.dart';
import 'main_menu_screen.dart';
import 'pause_menu_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final game = FloatyBirdGame();
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Platform.isAndroid ? Colors.transparent : null,
        statusBarIconBrightness: Platform.isAndroid ? Brightness.light : null,
      ),
    );
    generalConfigController.isGameSplashAnimating.value = true;
    await Future.delayed(const Duration(milliseconds: 3600));
    await Get.to(
      () => GameWidget(
        game: game,
        initialActiveOverlays: const [MainMenuScreen.id],
        overlayBuilderMap: {
          'mainMenu': (context, _) => MainMenuScreen(game: game),
          'gameOver': (context, _) => GameOverScreen(game: game),
          'pauseMenuButton': (context, _) => PauseMenuButton(game: game),
          'pauseMenuScreen': (context, _) => PauseMenuScreen(game: game),
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
                  const Text(
                    'Floaty Bird',
                    style: TextStyle(
                      fontSize: 60,
                      color: Styles.lightYellowColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Game',
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(5, 5),
                          blurRadius: 5.0,
                          color: Colors.grey,
                        ),
                        Shadow(
                          offset: Offset(5, 5),
                          blurRadius: 10.0,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  )
                      .animate(
                          target: generalConfigController
                                  .isGameSplashAnimating.value
                              ? 1
                              : 0)
                      .then(delay: 500.ms)
                      .slideY(
                        duration: 500.ms,
                        begin: 0,
                        end: 0.15,
                      )
                      .then(delay: 500.ms)
                      .slideY(
                        // curve: Curves.easeOutExpo,
                        duration: 500.ms,
                        begin: 0.15,
                        end: -0.05,
                      )
                      .then(delay: 500.ms)
                      .slideY(
                        curve: Curves.easeIn,
                        duration: 500.ms,
                        end: 0.05,
                      ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(
                    () => Image.asset(
                      Assets.splash,
                      height: 150.0.h,
                      width: 150.0.h,
                    )
                        .animate(
                            target: generalConfigController
                                    .isGameSplashAnimating.value
                                ? 1
                                : 0)
                        .slideY(
                          duration: 500.ms,
                          begin: 0,
                          end: 0.3,
                        )
                        .then(delay: 500.ms)
                        .slideY(
                          // curve: Curves.easeOutExpo,
                          duration: 500.ms,
                          end: -0.1,
                        )
                        .then(delay: 500.ms)
                        .slideY(
                          curve: Curves.easeIn,
                          duration: 500.ms,
                          end: 0.1,
                        ),
                  ),
                  const Text(
                    'Floaty Bird',
                    style: TextStyle(
                      fontSize: 60,
                      color: Colors.transparent,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Game',
                    ),
                  )
                ],
              )
            ],
          ),
        ).animate().then(delay: 3000.ms).slideY(begin: 0, end: -1),
      ),
    );
  }
}
