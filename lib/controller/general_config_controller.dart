import 'dart:developer';

import 'package:flame_audio/flame_audio.dart';
import 'package:floaty_bird/utils/assets.dart';
import 'package:floaty_bird/utils/common_methods.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';

import '../componets/resume_countdown_widget.dart';
import '../game/floaty_bird_game.dart';

class GeneralConfigController extends GetxController {
  RxDouble dheight = 0.0.obs;
  RxDouble dwidth = 0.0.obs;
  RxDouble safePadding = 0.0.obs;
  RxString preferredLang = "".obs;
  RxBool isLoggedIn = false.obs;
  RxBool isWelcomed = false.obs;
  RxBool isContinueButtonActive = false.obs;
  Rx<dynamic> dbBox = Object().obs;
  RxBool isLoaderActive = false.obs;
  RxString deviceToken = "".obs;
  RxString intUDID = "".obs;
  RxDouble lat = 0.0.obs;
  RxDouble long = 0.0.obs;
  RxBool userEarnedReward = false.obs;

  RxBool isFromSplash = false.obs;
  RxBool isDarkMode = false.obs;
  RxBool isBlurApplied = false.obs;
  RxBool bottomSheetOpen = false.obs;
  RxBool iserrorDialogShown = false.obs;
  RxDouble bottomsheetHeight = 0.0.obs;
  RxBool flashStatus = false.obs;

  //alpha numberic keyboard
  RxBool isNumKeyPressed = false.obs;
  RxBool isShiftKeyPressed = false.obs;

  //game
  RxBool onSelectGame = false.obs;
  RxString gameHighScore = "0".obs;
  RxString gameBackgroundImage = "0".obs;
  RxBool isGameBackgroundChange = false.obs;
  RxBool isGameSoundOn = false.obs;
  RxBool isGameSplashAnimating = false.obs;
  RxBool isBirdSwitched = false.obs;
  RxBool userResumedUsingAds = false.obs;
  RewardedAd? rewardedAd;

  // Hive Methods
  Future<void> openHiveBox() async {
    var box = await Hive.openBox('araBox');
    dbBox.value = box;
  }

  fetchHiveData({required String fieldName, var defaultValue}) async {
    if (await Hive.boxExists('araBox') && Hive.isBoxOpen('araBox')) {
      var data = dbBox.value!.get(fieldName) ?? defaultValue;
      // log("Data retrieved from Hive Hive with following structure \n {$fieldName : $data}");
      return data;
    }
  }

  Future<void> setHiveData({required String fieldName, var data}) async {
    await dbBox.value?.put(fieldName, data);
  }

  // Common Params Fetching Methods

  // Rewarded Ads IMPL

  Future<void> loadRewardedAd(
      {required String adUnitId, required FloatyBirdGame game}) async {
    await RewardedAd.load(
      // adUnitId: widget.adUnitId,
      adUnitId: adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) async {
          log("RewardedAd Add Loaded");
          // if (!mounted) {
          //   ad.dispose();
          //   return;
          // }
          rewardedAd = ad;
          if (rewardedAd != null) {
            if (rewardedAd == null) {
              log('Warning: attempt to show rewarded before loaded.');
              await loadRewardedAd(adUnitId: adUnitId, game: game);
              return;
            }
            rewardedAd!.onUserEarnedRewardCallback = (ad, reward) {
              log('user earned reward ============>');
            };

            rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
              onAdShowedFullScreenContent: (RewardedAd ad) =>
                  log('ad onAdShowedFullScreenContent.'),
              onAdDismissedFullScreenContent: (RewardedAd ad) async {
                log('$ad onAdDismissedFullScreenContent.');
                if (userEarnedReward.value) {
                  game.overlays.remove('rewardAd');
                  log("removed1");
                  game.overlays.remove('WatchAdsToResume');
                  log("removed2");
                  game.overlays.remove('gameOver');
                  if (generalConfigController.isGameSoundOn.value) {
                    FlameAudio.bgm.play(Assets.gamePlaySong);
                  }
                  log("removed3");
                  game.overlays.add('countDown');
                  await Future.delayed(const Duration(milliseconds: 4500));
                  log("removed4");
                  game.resumeEngine();
                  log("removed5");
                  game.bird.resetBird();
                  log("removed6");
                  generalConfigController.userResumedUsingAds.value = true;
                  userEarnedReward.value = false;
                } else {
                  generalConfigController.userResumedUsingAds.value = true;
                  game.overlays.remove('rewardAd');
                  log("removed1");
                  game.overlays.remove('WatchAdsToResume');
                  log("removed2");
                  game.overlays.add('gameOver');
                }
                ad.dispose();
                await loadRewardedAd(adUnitId: adUnitId, game: game);
              },
              onAdFailedToShowFullScreenContent:
                  (RewardedAd ad, AdError error) async {
                log('$ad onAdFailedToShowFullScreenContent: $error');
                ad.dispose();
                await loadRewardedAd(adUnitId: adUnitId, game: game);
              },
            );

            rewardedAd!.setImmersiveMode(true);
            // hideLoader();
            // rewardedAd!.show(onUserEarnedReward:
            //     (AdWithoutView ad, RewardItem reward) async {
            //   userEarnedReward.value = true;
            // });
            // rewardedAd = null;
          }
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (error) {
          hideLoader();
          showGeneralToastMessage(
            message: 'Failed to load Ad!',
          );
          log('RewardedAd failed to load: $error');
        },
      ),
    );
  }
}

GeneralConfigController generalConfigController = GeneralConfigController();
