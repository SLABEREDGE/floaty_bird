import 'package:flame_audio/flame_audio.dart';
import 'package:floaty_bird/controller/general_config_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/ara_theme.dart';
import '../componets/setting_menu_button.dart';
import '../game/floaty_bird_game.dart';
import '../utils/bouncing_widget.dart';

class PauseMenuScreen extends StatelessWidget {
  final FloatyBirdGame game;
  static const String id = 'pauseMenuScreen';
  const PauseMenuScreen({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    FlameAudio.bgm.pause();
    game.pauseEngine();
    return Material(
      color: Colors.black38,
      child: Stack(
        children: [
          SettingsMenuButton(game: game),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Text(
                      'Game Pause',
                      style: TextStyle(
                        fontSize: 60,
                        fontFamily: 'Game',
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 10
                          ..color = Styles.blackColor,
                        shadows: const <Shadow>[
                          Shadow(
                            offset: Offset(7, 5),
                            blurRadius: 8.0,
                            color: Colors.grey,
                          ),
                          Shadow(
                            offset: Offset(8, 5),
                            blurRadius: 12.0,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Game Pause',
                      style: TextStyle(
                        fontSize: 60,
                        fontFamily: 'Game',
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 5
                          ..color = Styles.whiteColor,
                        shadows: const <Shadow>[
                          Shadow(
                            offset: Offset(7, 5),
                            blurRadius: 8.0,
                            color: Colors.grey,
                          ),
                          Shadow(
                            offset: Offset(8, 5),
                            blurRadius: 12.0,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      'Game Pause',
                      style: TextStyle(
                        fontSize: 60,
                        color: Colors.indigoAccent,
                        fontFamily: 'Game',
                      ),
                    ),
                  ],
                ),
                // Image.asset(Assets.message),
                const SizedBox(
                  height: 10,
                ),
                BouncingWidget(
                  child: ElevatedButton(
                    onPressed: onRestart,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrangeAccent, elevation: 5),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Resume',
                          style: TextStyle(
                              fontSize: 25, height: 1.2, fontFamily: 'Game'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.play_arrow),
                      ],
                    ),
                  ),
                ),
                BouncingWidget(
                  child: ElevatedButton(
                    onPressed: onHome,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent, elevation: 5),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Home',
                          style: TextStyle(
                              fontSize: 25, height: 1.2, fontFamily: 'Game'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.home),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onRestart() {
    if (generalConfigController.isGameSoundOn.value) {
      FlameAudio.bgm.resume();
    }
    game.overlays.remove('pauseMenuScreen');
    game.resumeEngine();
  }

  void onHome() {
    game.bird.resetBird();
    game.bird.resetScore();
    game.overlays.remove('pauseMenuScreen');
    game.overlays.remove('pauseMenuButton');
    game.overlays.add('mainMenu');
    game.interval.reset();
    game.isBgPlaying = false;
    game.pauseEngine();
  }

  void onGetBack() {
    // Get.offAllNamed(Routes.HOME);
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    // Get.back();
  }
}
