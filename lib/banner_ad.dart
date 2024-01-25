import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'game/floaty_bird_game.dart';

class MyBannerAdWidget extends StatefulWidget {
  static const String id = 'bannerAd';
  final FloatyBirdGame game;

  /// The requested size of the banner. Defaults to [AdSize.banner].
  final AdSize adSize;

  /// The AdMob ad unit to show.
  ///
  /// TODO: replace this test ad unit with your own ad unit
  final String adUnitId = Platform.isAndroid
      // Use this ad unit on Android...
      ? 'ca-app-pub-7487124206061387/9927790439'
      // ... or this one on iOS.
      : '';

  MyBannerAdWidget({
    super.key,
    this.adSize = AdSize.banner,
    required this.game,
  });

  @override
  State<MyBannerAdWidget> createState() => _MyBannerAdWidgetState();
}

class _MyBannerAdWidgetState extends State<MyBannerAdWidget> {
  /// The banner ad to show. This is `null` until the ad is actually loaded.
  BannerAd? _bannerAd;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: MediaQuery.of(context).padding.top,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: widget.adSize.width.toDouble(),
            height: widget.adSize.height.toDouble(),
            child: _bannerAd == null
                // Nothing to render yet.
                ? SizedBox()
                // The actual ad.
                : AdWidget(ad: _bannerAd!),
          ),
        ],
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
    _bannerAd?.dispose();
    super.dispose();
  }

  /// Loads a banner ad.
  void _loadAd() {
    final bannerAd = BannerAd(
      size: widget.adSize,
      adUnitId: widget.adUnitId,
      request: const AdRequest(),
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          log("Add Loaded");
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, error) {
          log('BannerAd failed to load: $error');
          ad.dispose();
        },
      ),
    );

    // Start loading.
    bannerAd.load();
  }
}
