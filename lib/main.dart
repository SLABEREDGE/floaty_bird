import 'dart:async';

import 'package:floaty_bird/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'controller/general_config_controller.dart';
import 'utils/ara_theme.dart';
import 'utils/extension.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  unawaited(MobileAds.instance.initialize());
  // await (MobileAds.instance.initialize());
  await Hive.initFlutter();
  await generalConfigController.openHiveBox();

  runApp(
    const MyApp(),
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
