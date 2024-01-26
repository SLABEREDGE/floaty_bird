import 'dart:developer';
import 'dart:io';
import 'package:floaty_bird/utils/ara_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'game/floaty_bird_game.dart';

class RewardAdWidget extends StatefulWidget {
  static const String id = 'rewardAd';
  final FloatyBirdGame game;

  final AdSize adSize;

  final String adUnitId = Platform.isAndroid
      ?
      // 'ca-app-pub-3940256099942544/5354046379'
      'ca-app-pub-7487124206061387/4696479208'
      : '';

  RewardAdWidget({
    super.key,
    this.adSize = AdSize.fluid,
    required this.game,
  });

  @override
  State<RewardAdWidget> createState() => _RewardAdWidgetState();
}

class _RewardAdWidgetState extends State<RewardAdWidget> {
  RewardedAd? rewardedAd;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Styles.darkThemePrimaryColor,
      child: SafeArea(
        child: Container(
          color: Styles.darkThemePrimaryColor,
          // width: widget.adSize.width.toDouble(),
          // height: widget.adSize.height.toDouble(),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: GestureDetector(
              onTap: () {
                // if (rewardedAd != null) {
                //   rewardedAd!.show(
                //     onUserEarnedReward: (ad, reward) {
                //       // Handle reward earned by the user
                //     },
                //   );
                // } else {
                //   widget.game.overlays.remove('rewardAd');
                // }
              },
              child: const CircularProgressIndicator(
                color: Styles.whiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _loadAd();
    });
    super.initState();
  }

  @override
  void dispose() {
    rewardedAd?.dispose();
    super.dispose();
  }

  /// Loads a rewardedAd ad.
  Future<void> _loadAd() async {
    await RewardedAd.load(
      adUnitId: widget.adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          log("RewardedAd Add Loaded");
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() {
            rewardedAd = ad;
            if (rewardedAd != null) {
              rewardedAd!.show(
                onUserEarnedReward: (ad, reward) {
                  // Handle reward earned by the user
                },
              );
            }
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (error) {
          log('RewardedAd failed to load: $error');
        },
      ),
    );
  }
}
