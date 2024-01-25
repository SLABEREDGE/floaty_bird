import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'game/floaty_bird_game.dart';

class RewardAdWidget extends StatefulWidget {
  static const String id = 'rewardAd';
  final FloatyBirdGame game;

  final AdSize adSize;

  final String adUnitId =
      Platform.isAndroid ? 'ca-app-pub-3940256099942544/5354046379' : '';

  RewardAdWidget({
    super.key,
    this.adSize = AdSize.fluid,
    required this.game,
  });

  @override
  State<RewardAdWidget> createState() => _RewardAdWidgetState();
}

class _RewardAdWidgetState extends State<RewardAdWidget> {
  RewardedAd? _rewardedAd;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.yellow.withOpacity(0.1),
        width: widget.adSize.width.toDouble(),
        height: widget.adSize.height.toDouble(),
        child: _rewardedAd == null
            // Nothing to render yet.
            ? SizedBox()
            // The actual ad.
            : 
            AdWidget(ad:   
_rewardedAd.show(onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
  // Reward the user for watching an ad.
})),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  @override
  void dispose() {
    _rewardedAd?.dispose();
    super.dispose();
  }

  /// Loads a banner ad.
  void _loadAd() {
    RewardedAd.load(
      adUnitId: widget.adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          log("Add Loaded");
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() {
            _rewardedAd = ad as RewardedAd;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (error) {
          log('BannerAd failed to load: $error');
        },
      ),
    );

    // Start loading.
  }
}
