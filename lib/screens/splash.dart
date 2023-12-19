import 'dart:io';

import 'package:flame/game.dart';
import 'package:floaty_bird/controller/general_config_controller.dart';
import 'package:floaty_bird/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../componets/pause_menu_button.dart';
import '../game/flappy_bird_game.dart';
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
  final game = FlappyBirdGame();
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
    await Future.delayed(const Duration(seconds: 2));
    // await Get.to(
    //   () => GameWidget(
    //     game: game,
    //     initialActiveOverlays: const [MainMenuScreen.id],
    //     overlayBuilderMap: {
    //       'mainMenu': (context, _) => MainMenuScreen(game: game),
    //       'gameOver': (context, _) => GameOverScreen(game: game),
    //       'pauseMenuButton': (context, _) => PauseMenuButton(game: game),
    //       'pauseMenuScreen': (context, _) => PauseMenuScreen(game: game),
    //     },
    //   ),
    // );
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
          child: Image.asset(
            Assets.splash,
            height: 150.0.h,
            width: 150.0.h,
          ),
        ),
      ),
    );
  }
}
