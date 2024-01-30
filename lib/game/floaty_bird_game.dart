import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../componets/background.dart';
import '../componets/bird.dart';
import '../componets/ground.dart';
import '../componets/pipe_group.dart';
import '../utils/ara_theme.dart';
import 'configuration.dart';

class FloatyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  FloatyBirdGame();

  late Bird bird;
  late Background background;
  late TextComponent score;
  Timer interval = Timer(Config.pipeInterval, repeat: true);
  bool isHit = false;
  bool playSound = true;
  bool isBgPlaying = false;

  @override
  Future<void> onLoad() async {
    addAll([
      background = Background(),
      Ground(),
      bird = Bird(),
      score = buildScore(),
    ]);
    interval.onTick = () => add(PipeGroup());
  }

  TextComponent buildScore() {
    return TextComponent(
      text: 'Score: 0',
      // position: Vector2(size.x / 2, size.y / 2 * 0.2),
      position: Vector2(size.x / 2, size.y * 0.15),
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 40,
          color: Styles.whiteColor,
          fontWeight: FontWeight.bold,
          fontFamily: 'Game',
          shadows: <Shadow>[
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
    );
  }

  @override
  void onTap() {
    super.onTap();
    bird.fly();
  }

  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt);
    score.text = 'Score: ${bird.score}';
  }
}
