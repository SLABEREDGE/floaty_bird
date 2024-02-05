import 'dart:developer';

import 'package:flame_audio/flame_audio.dart';
import 'package:floaty_bird/controller/general_config_controller.dart';
import 'package:floaty_bird/utils/assets.dart';
import 'package:floaty_bird/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

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
                        fontSize: 60.0.sp,
                        fontFamily: 'Game',
                        letterSpacing: 1.5,
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
                        fontSize: 60.0.sp,
                        fontFamily: 'Game',
                        letterSpacing: 1.5,
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
                    Text(
                      'Game Over',
                      style: TextStyle(
                        fontSize: 60.0.sp,
                        letterSpacing: 1.5,
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
                    Obx(
                      () => Text(
                        int.parse(generalConfigController.gameHighScore.value) <
                                game.bird.score
                            ? 'New HighScore : ${game.bird.score}'
                            : 'Score: ${game.bird.score}',
                        style: TextStyle(
                          fontSize: 50.0.sp,
                          fontFamily: 'Game',
                          letterSpacing: 1.4,
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
                    ),
                    Obx(
                      () => Text(
                        int.parse(generalConfigController.gameHighScore.value) <
                                game.bird.score
                            ? 'New HighScore : ${game.bird.score}'
                            : 'Score: ${game.bird.score}',
                        style: TextStyle(
                          fontSize: 50.0.sp,
                          color: Colors.white,
                          fontFamily: 'Game',
                          letterSpacing: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => Visibility(
                    visible: !generalConfigController.userResumedUsingAds.value,
                    child: Visibility(
                      visible: generalConfigController.rewardedAd != null,
                      child: BouncingWidget(
                        child: ElevatedButton(
                          onPressed: onWatchAds,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orangeAccent,
                              elevation: 5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Watch ad to resume',
                                style: TextStyle(
                                  fontSize: 25.0.sp,
                                  height: 1.2,
                                  letterSpacing: 1.3,
                                  fontFamily: 'Game',
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(Icons.video_call),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                BouncingWidget(
                  child: ElevatedButton(
                    onPressed: onRestart,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrangeAccent, elevation: 5),
                    child: Text(
                      'Play Again ?',
                      style: TextStyle(
                        fontSize: 25.0.sp,
                        height: 1.2,
                        letterSpacing: 1.3,
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
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Home',
                          style: TextStyle(
                            fontSize: 25.0.sp,
                            height: 1.2,
                            fontFamily: 'Game',
                            letterSpacing: 1.3,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(Icons.home),
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
    // if (generalConfigController.isGameSoundOn.value) {
    //   FlameAudio.bgm.stop();
    // }
    generalConfigController.userResumedUsingAds.value = false;
    game.overlays.remove('gameOver');
    game.pipes.update(0);
    game.resumeEngine();
    game.bird.resetBird();
    game.bird.resetScore();
    game.interval.reset(); //added to reset pipes
    log("game.score =====> ${game.score.text}");
    if (generalConfigController.isGameSoundOn.value) {
      FlameAudio.bgm.play(Assets.gamePlaySong);
    }
  }

  void onHome() {
    generalConfigController.userResumedUsingAds.value = false;
    game.overlays.remove('gameOver');
    game.overlays.remove('pauseMenuButton');
    game.overlays.add('mainMenu');
    game.pipes.update(0);
    game.bird.resetBird();
    game.bird.resetScore();
    game.interval.reset();
    if (generalConfigController.isGameSoundOn.value) {
      game.isBgPlaying = true;
    }
    // game.isBgPlaying = true;
    // game.pauseEngine();
  }

  Future<void> onWatchAds() async {
    if (generalConfigController.isGameSoundOn.value) {
      FlameAudio.bgm.pause();
    }
    if (generalConfigController.rewardedAd != null) {
      generalConfigController.rewardedAd!.show(
          onUserEarnedReward: (AdWithoutView ad, RewardItem reward) async {
        generalConfigController.userEarnedReward.value = true;
      });
    } else {
      log("Adddddddssss is nullllll =====>");
    }
  }
}
