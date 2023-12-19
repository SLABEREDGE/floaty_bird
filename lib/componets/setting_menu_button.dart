import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/ara_theme.dart';
import '../controller/general_config_controller.dart';
import '../game/floaty_bird_game.dart';
import '../utils/bouncing_widget.dart';
import '../utils/constants.dart';

class SettingsMenuButton extends StatefulWidget {
  final FloatyBirdGame game;
  const SettingsMenuButton({super.key, required this.game});

  @override
  State<SettingsMenuButton> createState() => _SettingsMenuButtonState();
}

class _SettingsMenuButtonState extends State<SettingsMenuButton> {
  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.sizeOf(context).height / 2 * 0.15,
      right: 20,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                clicked = !clicked;
              });
            },
            child: BouncingWidget(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(10),
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
                child: const Icon(
                  Icons.settings,
                  size: 25,
                  color: Styles.whiteColor,
                ),
              ),
            ),
          ),
          Visibility(
            visible: clicked,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Obx(
                () => GestureDetector(
                  onTap: () async {
                    if (generalConfigController.isGameSoundOn.value) {
                      generalConfigController.isGameSoundOn.value = false;
                      await generalConfigController.setHiveData(
                        fieldName: DBFields.gameSoundOn,
                        data: generalConfigController.isGameSoundOn.value,
                      );
                    } else {
                      generalConfigController.isGameSoundOn.value = true;
                      await generalConfigController.setHiveData(
                        fieldName: DBFields.gameSoundOn,
                        data: generalConfigController.isGameSoundOn.value,
                      );
                    }
                    clicked = !clicked;
                  },
                  child: BouncingWidget(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(10),
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
                      child: Icon(
                        generalConfigController.isGameSoundOn.value
                            ? Icons.volume_up
                            : Icons.volume_off,
                        size: 25,
                        color: Styles.whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: clicked,
            child: GestureDetector(
              onTap: () {
                widget.game.bird.reset();
                widget.game.overlays.remove('gameOver');
                widget.game.overlays.remove('pauseMenuScreen');
                widget.game.pauseEngine();
                // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                //     overlays: SystemUiOverlay.values);
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                // Get.back();
                clicked = !clicked;
              },
              child: BouncingWidget(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(10),
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
                  child: const Icon(
                    Icons.exit_to_app,
                    size: 25,
                    color: Styles.whiteColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
