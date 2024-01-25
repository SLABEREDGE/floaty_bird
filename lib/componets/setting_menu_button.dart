import 'package:floaty_bird/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      // top: MediaQuery.sizeOf(context).height / 2 * 0.15,
      top: MediaQuery.sizeOf(context).height / 2 * 0.25,
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
              child: SvgPicture.asset(
                Assets.settingsButton,
                height: 45,
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
                    child: SvgPicture.asset(
                      generalConfigController.isGameSoundOn.value
                          ? Assets.soundOnButton
                          : Assets.soundOffButton,
                      height: 45,
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
                child: SvgPicture.asset(
                  Assets.cancelButton,
                  height: 45,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
