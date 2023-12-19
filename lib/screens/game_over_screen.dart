import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../componets/setting_menu_button.dart';
import '../game/floaty_bird_game.dart';
import '../utils/ara_theme.dart';
import '../utils/bouncing_widget.dart';

class GameOverScreen extends StatelessWidget {
  final FloatyBirdGame game;
  static const String id = 'gameOver';
  const GameOverScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
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
                // Image.asset(Assets.gameOver),
                const SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    Text(
                      'Game Over',
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
                      'Game Over',
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
                      'Game Over',
                      style: TextStyle(
                        fontSize: 60,
                        color: Colors.orange,
                        fontFamily: 'Game',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Stack(
                  children: [
                    Text(
                      'Score: ${game.bird.score}',
                      style: TextStyle(
                        fontSize: 50,
                        fontFamily: 'Game',
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 3
                          ..color = Styles.darkGreyColor,
                        shadows: const <Shadow>[
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
                    ),
                    Text(
                      'Score: ${game.bird.score}',
                      style: const TextStyle(
                          fontSize: 50,
                          color: Colors.white,
                          fontFamily: 'Game'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                BouncingWidget(
                  child: ElevatedButton(
                    onPressed: onRestart,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrangeAccent, elevation: 5),
                    child: const Text(
                      'Play Again ?',
                      style: TextStyle(
                        fontSize: 20,
                        height: 1.2,
                        fontFamily: 'Game',
                      ),
                    ),
                  ),
                ),
                BouncingWidget(
                  child: ElevatedButton(
                    onPressed: onHome,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigoAccent, elevation: 5),
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
                // ElevatedButton(
                //   onPressed: onGetBack,
                //   style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.blueAccent, elevation: 5),
                //   child: const Row(
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       Text(
                //         'Leave Game',
                //         style: TextStyle(
                //             fontSize: 20, height: 1.2, fontFamily: 'Game'),
                //       ),
                //       SizedBox(
                //         width: 10,
                //       ),
                //       Icon(Icons.exit_to_app),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onRestart() {
    game.overlays.remove('gameOver');
    game.resumeEngine();
    game.bird.reset();
  }

  void onHome() {
    game.bird.reset();
    game.overlays.remove('gameOver');
    game.overlays.add('mainMenu');
    game.pauseEngine();
  }

  void onGetBack() {
    game.bird.reset();
    game.overlays.remove('gameOver');
    game.pauseEngine();
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    // Get.back();
  }
}
