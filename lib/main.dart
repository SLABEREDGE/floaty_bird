import 'package:floaty_bird/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'controller/general_config_controller.dart';
import 'utils/ara_theme.dart';
import 'utils/extension.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Hive.initFlutter();
  await generalConfigController.openHiveBox();

  runApp(
    const MyApp(),
    // await Get.to(
    //   () => GameWidget(
    //     game: game,
    //     initialActiveOverlays: const [MainMenuScreen.id],
    //     overlayBuilderMap: {
    //       'mainMenu': (context, _) =>
    //           MainMenuScreen(game: game),
    //       'gameOver': (context, _) =>
    //           GameOverScreen(game: game),
    //       'pauseMenuButton': (context, _) =>
    //           PauseMenuButton(game: game),
    //       'pauseMenuScreen': (context, _) =>
    //           PauseMenuScreen(game: game),
    //     },
    //   ),
    // );
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    DeviceManager.instance.init(context);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: FloatyBirdTheme.lightTheme,
      home: const Splash(),
    );
  }
}
