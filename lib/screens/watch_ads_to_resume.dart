import 'dart:developer';

import 'package:flame_audio/flame_audio.dart';
import 'package:floaty_bird/controller/general_config_controller.dart';
import 'package:floaty_bird/utils/assets.dart';
import 'package:floaty_bird/utils/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../game/floaty_bird_game.dart';
import '../utils/ara_theme.dart';

class WatchAdsToResume extends StatefulWidget {
  final FloatyBirdGame game;
  static const String id = 'WatchAdsToResume';
  const WatchAdsToResume({super.key, required this.game});

  @override
  State<WatchAdsToResume> createState() => _WatchAdsToResumeState();
}

class _WatchAdsToResumeState extends State<WatchAdsToResume>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 10,
      child:
          // Stack(
          //   children: [
          // Container(
          //   color: Styles.lightGreyTextColor.withOpacity(0.2),
          // )
          //     .animate(
          //       autoPlay: true,
          //       onPlay: (controller) => controller.repeat(
          //         reverse: true,
          //       ),
          //     )
          //     .shimmer(
          //       duration: 800.ms,
          //     ),
          Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              Assets.watchAdsToResume,
              height: MediaQuery.of(context).size.height * 0.45,
              // width: MediaQuery.of(context).size.width * 0.4,
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.165,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Stack(
                      children: [
                        Text(
                          "Do you want to resume ?",
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Marker',
                            color: Colors.deepOrange,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (generalConfigController.isGameSoundOn.value) {
                          FlameAudio.bgm.pause();
                        }
                        if (generalConfigController.rewardedAd != null) {
                          generalConfigController.rewardedAd!.show(
                              onUserEarnedReward:
                                  (AdWithoutView ad, RewardItem reward) async {
                            generalConfigController.userEarnedReward.value =
                                true;
                          });
                        } else {
                          log("Adddddddssss is nullllll =====>");
                        }
                      },
                      child: BouncingWidget(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SvgPicture.asset(
                              Assets.adsButton,
                              height: 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Watch Ad",
                                  style: TextStyle(
                                    fontSize: 24,
                                    height: 1.1,
                                    fontFamily: 'Marker',
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                SvgPicture.asset(
                                  Assets.playButton,
                                  height: 30,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                        .animate(
                          autoPlay: true,
                          onPlay: (controller) => controller.repeat(
                            reverse: true,
                          ),
                        )
                        .scale(
                          begin: const Offset(0.90, 0.90),
                          end: const Offset(1, 1),
                          duration: 1000.ms,
                          curve: Curves.easeInOut,
                        ),
                    GestureDetector(
                      onTap: () {
                        widget.game.overlays.remove('WatchAdsToResume');
                        widget.game.overlays.add('gameOver');
                        if (generalConfigController.isGameSoundOn.value) {
                          FlameAudio.bgm.resume();
                        }
                      },
                      child: Container(
                        color: Colors.transparent,
                        margin: const EdgeInsets.only(top: 3),
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Marker',
                              color: Styles.lightGreyTextColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
            .animate()
            .fade(duration: 400.ms, curve: Curves.fastOutSlowIn)
            .scale(duration: 400.ms, curve: Curves.fastOutSlowIn),
      ),
      //   ],
      // ),
    );
  }
}
