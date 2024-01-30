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

class Bird extends SpriteGroupComponent<BirdMovement>
    with HasGameRef<FloatyBirdGame>, CollisionCallbacks {
  Bird();

  int score = 0;

  @override
  Future<void> onLoad() async {
    final birdMidFlap = await gameRef.loadSprite(Assets.birdMidFlap);
    final birdUpFlap = await gameRef.loadSprite(Assets.birdUpFlap);
    final birdDownFlap = await gameRef.loadSprite(Assets.birdDownFlap);

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
      FlameAudio.bgm.play(Assets.homeSong1);
    }
    game.isHit = true;
    gameRef.pauseEngine();
    if (!generalConfigController.userResumedUsingAds.value) {
      gameRef.overlays.add('WatchAdsToResume');
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
}
