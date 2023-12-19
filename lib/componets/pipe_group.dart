import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';

import '../controller/general_config_controller.dart';
import '../game/configuration.dart';
import '../game/flappy_bird_game.dart';
import '../game/pipe_position.dart';
import '../utils/assets.dart';
import '../utils/constants.dart';
import 'pipe.dart';

class PipeGroup extends PositionComponent with HasGameRef<FlappyBirdGame> {
  PipeGroup();

  final _random = Random();

  String high = "";

  @override
  Future<void> onLoad() async {
    position.x = gameRef.size.x;
    final heightMinusGround = gameRef.size.y - Config.groundHeight;
    // final spacing = 100 + _random.nextDouble() * (heightMinusGround / 4);
    final spacing = 150 + _random.nextDouble() * (heightMinusGround / 4);
    final centerY =
        spacing + _random.nextDouble() * (heightMinusGround - spacing);

    addAll([
      Pipe(height: centerY - spacing / 2, pipePosition: PipePosition.top),
      Pipe(
          height: heightMinusGround - (centerY + spacing / 2),
          pipePosition: PipePosition.bottom),
    ]);
  }

  @override
  Future<void> update(double dt) async {
    super.update(dt);
    position.x -= Config.gameSpeed * dt;
    if (position.x < -50) {
      removeFromParent();
      updateScore();
    }
    if (gameRef.isHit) {
      removeFromParent();
      gameRef.isHit = false;
    }
  }

  Future<void> updateScore() async {
    if (generalConfigController.isGameSoundOn.value) {
      FlameAudio.play(Assets.point);
    }
    gameRef.bird.score += 1;
    if (int.parse(generalConfigController.gameHighScore.value) <
        gameRef.bird.score) {
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameHighScore,
        data: game.bird.score.toString(),
      );
    }
    removeFromParent();

    // print("highscroe ${high}");
  }
}
