import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'game/floaty_bird_game.dart';

class MyBannerAdWidget extends StatefulWidget {
  static const String id = 'bannerAd';
  final FloatyBirdGame game;
  final AdSize adSize;
  final String? adUnitId;

  const MyBannerAdWidget({
    super.key,
    this.adSize = AdSize.banner,
    this.adUnitId,
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
          SizedBox(
            width: widget.adSize.width.toDouble(),
            height: widget.adSize.height.toDouble(),
            child: _bannerAd == null
                // Nothing to render yet.
                ? const SizedBox.shrink()
                // The actual ad.
                : Center(child: AdWidget(ad: _bannerAd!)),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    _loadAd();
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  /// Loads a banner ad.
  Future<void> _loadAd() async {
    final bannerAd = BannerAd(
      size: widget.adSize,
      adUnitId: widget.adUnitId ??
          (Platform.isAndroid
              ? 'ca-app-pub-7487124206061387/2026325080' //AdSize.fullBanner,
              // ? 'ca-app-pub-3940256099942544/6300978111' // Test AdSize.banner,
              : ''),
      request: const AdRequest(),
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          log("Banner Add Loaded");
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
          // _loadAd();
        },
      ),
    );

    // Start loading.
    bannerAd.load();
  }
}
