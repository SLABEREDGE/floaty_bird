import 'dart:developer';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import '../controller/general_config_controller.dart';
import '../game/bird_movement.dart';
import '../game/configuration.dart';
import '../game/floaty_bird_game.dart';
import '../utils/assets.dart';
import '../utils/constants.dart';

class Bird extends SpriteGroupComponent<BirdMovement>
    with HasGameRef<FloatyBirdGame>, CollisionCallbacks {
  Bird();

  int score = 0;

  late Sprite birdMidFlap;
  late Sprite birdUpFlap;
  late Sprite birdDownFlap;

  @override
  Future<void> onLoad() async {
    birdMidFlap = await getMidBird();
    birdUpFlap = await getUpBird();
    birdDownFlap = await getDownBird();

    size = Vector2(50, 40);
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
    current = BirdMovement.middle;
    sprites = {
      BirdMovement.middle: birdMidFlap,
      BirdMovement.up: birdUpFlap,
      BirdMovement.down: birdDownFlap,
    };
    add(CircleHitbox());
  }

  void fly() {
    add(
      MoveByEffect(
        Vector2(0, Config.gravity),
        EffectController(duration: 0.2, curve: Curves.decelerate),
        onComplete: () => current = BirdMovement.down,
      ),
    );
    current = BirdMovement.up;
    if (generalConfigController.isGameSoundOn.value) {
      FlameAudio.play(Assets.flying);
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    gameOver();
  }

  void resetBird() {
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
  }

  void resetScore() {
    score = 0;
  }

  Future<void> gameOver() async {
    if (generalConfigController.isGameSoundOn.value) {
      FlameAudio.play(Assets.collision);
      FlameAudio.bgm.stop();
    }
    game.isHit = true;
    gameRef.pauseEngine();
    if (!generalConfigController.userResumedUsingAds.value) {
      gameRef.overlays.add('WatchAdsToResume');
      if (generalConfigController.isGameSoundOn.value) {
        FlameAudio.bgm.play(Assets.homeSong);
      }
    } else {
      gameRef.overlays.add('gameOver');
    }
    game.isHit = true;
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += Config.birdVelocity * dt;
    if (position.y < 1) {
      gameOver();
    }
  }

  Future<Sprite> getMidBird() async {
    log("getMidBird is ${generalConfigController.gameBirdImage.value}");
    if (generalConfigController.gameBirdImage.value == '0') {
      birdMidFlap = await gameRef.loadSprite(Assets.bird0MidFlap);
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBirdImage,
        data: '0',
      );
    } else if (generalConfigController.gameBirdImage.value == '1') {
      birdMidFlap = await gameRef.loadSprite(Assets.bird1MidFlap);
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBirdImage,
        data: '1',
      );
    } else if (generalConfigController.gameBirdImage.value == '2') {
      birdMidFlap = await gameRef.loadSprite(Assets.bird2MidFlap);
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBirdImage,
        data: '2',
      );
    } else if (generalConfigController.gameBirdImage.value == '3') {
      birdMidFlap = await gameRef.loadSprite(Assets.bird3MidFlap);
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBirdImage,
        data: '3',
      );
    } else if (generalConfigController.gameBirdImage.value == '4') {
      birdMidFlap = await gameRef.loadSprite(Assets.bird4MidFlap);
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBirdImage,
        data: '4',
      );
    } else {
      birdMidFlap = await gameRef.loadSprite(Assets.bird5MidFlap);
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBirdImage,
        data: '5',
      );
    }

    log("getMidBird changed to ${generalConfigController.gameBirdImage.value}");
    return birdMidFlap;
  }

  Future<Sprite> getUpBird() async {
    log("getUpBird is ${generalConfigController.gameBirdImage.value}");
    if (generalConfigController.gameBirdImage.value == '0') {
      birdUpFlap = await gameRef.loadSprite(Assets.bird0UpFlap);
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBirdImage,
        data: '0',
      );
    } else if (generalConfigController.gameBirdImage.value == '1') {
      birdUpFlap = await gameRef.loadSprite(Assets.bird1UpFlap);
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBirdImage,
        data: '1',
      );
    } else if (generalConfigController.gameBirdImage.value == '2') {
      birdUpFlap = await gameRef.loadSprite(Assets.bird2UpFlap);
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBirdImage,
        data: '2',
      );
    } else if (generalConfigController.gameBirdImage.value == '3') {
      birdUpFlap = await gameRef.loadSprite(Assets.bird3UpFlap);
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBirdImage,
        data: '3',
      );
    } else if (generalConfigController.gameBirdImage.value == '4') {
      birdUpFlap = await gameRef.loadSprite(Assets.bird4UpFlap);
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBirdImage,
        data: '4',
      );
    } else {
      birdUpFlap = await gameRef.loadSprite(Assets.bird5UpFlap);
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBirdImage,
        data: '5',
      );
    }

    log("getUpBird changed to ${generalConfigController.gameBirdImage.value}");
    return birdUpFlap;
  }

  Future<Sprite> getDownBird() async {
    log("getDownBird is ${generalConfigController.gameBirdImage.value}");

    if (generalConfigController.gameBirdImage.value == '0') {
      birdDownFlap = await gameRef.loadSprite(Assets.bird0DownFlap);
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBirdImage,
        data: '0',
      );
    } else if (generalConfigController.gameBirdImage.value == '1') {
      birdDownFlap = await gameRef.loadSprite(Assets.bird1DownFlap);
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBirdImage,
        data: '1',
      );
    } else if (generalConfigController.gameBirdImage.value == '2') {
      birdDownFlap = await gameRef.loadSprite(Assets.bird2DownFlap);
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBirdImage,
        data: '2',
      );
    } else if (generalConfigController.gameBirdImage.value == '3') {
      birdDownFlap = await gameRef.loadSprite(Assets.bird3DownFlap);
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBirdImage,
        data: '3',
      );
    } else if (generalConfigController.gameBirdImage.value == '4') {
      birdDownFlap = await gameRef.loadSprite(Assets.bird4DownFlap);
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBirdImage,
        data: '4',
      );
    } else {
      birdDownFlap = await gameRef.loadSprite(Assets.bird5DownFlap);
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBirdImage,
        data: '5',
      );
    }
    log("getDownBird changed to ${generalConfigController.gameBirdImage.value}");
    return birdDownFlap;
  }
}
