import 'dart:developer';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/image_composition.dart';
import 'package:flame/parallax.dart';
import '../controller/general_config_controller.dart';
import '../game/configuration.dart';
import '../game/floaty_bird_game.dart';
import '../utils/assets.dart';
import '../utils/constants.dart';

class Ground extends ParallaxComponent<FloatyBirdGame>
    with HasGameRef<FloatyBirdGame> {
  Ground();
  late Image ground;
  @override
  Future<void> onLoad() async {
    // ground = await Flame.images.load(Assets.ground1);
    ground = await getGround();
    parallax = Parallax([
      ParallaxLayer(
        ParallaxImage(ground, fill: LayerFill.none),
      ),
    ]);
    add(RectangleHitbox(
        position: Vector2(0, gameRef.size.y - Config.groundHeight),
        size: Vector2(gameRef.size.x, Config.groundHeight)));
  }

  @override
  void update(double dt) {
    super.update(dt);
    parallax?.baseVelocity.x = Config.gameSpeed;
  }

  Future<Image> getGround() async {
    log("generalConfigController.gameBackgroundImage.value ${generalConfigController.gameBackgroundImage.value}");
    if (generalConfigController.gameBackgroundImage.value == '0') {
      ground = await Flame.images.load(Assets.cityGround);
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBackgroundImage,
        data: '0',
      );
    } else if (generalConfigController.gameBackgroundImage.value == '1') {
      ground = await Flame.images.load(Assets.desertGround);
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBackgroundImage,
        data: '1',
      );
    } else if (generalConfigController.gameBackgroundImage.value == '2') {
      ground = await Flame.images.load(Assets.forestGround);
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBackgroundImage,
        data: '2',
      );
    } else if (generalConfigController.gameBackgroundImage.value == '3') {
      ground = await Flame.images.load(Assets.hellGround);
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBackgroundImage,
        data: '3',
      );
    } else if (generalConfigController.gameBackgroundImage.value == '4') {
      ground = await Flame.images.load(Assets.iceGround);
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBackgroundImage,
        data: '4',
      );
    } else if (generalConfigController.gameBackgroundImage.value == '5') {
      ground = await Flame.images.load(Assets.lavaGround);
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBackgroundImage,
        data: '5',
      );
    } else if (generalConfigController.gameBackgroundImage.value == '6') {
      ground = await Flame.images.load(Assets.mountainGround);
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBackgroundImage,
        data: '6',
      );
    } else if (generalConfigController.gameBackgroundImage.value == '7') {
      ground = await Flame.images.load(Assets.nebulaGround);
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBackgroundImage,
        data: '7',
      );
    } else if (generalConfigController.gameBackgroundImage.value == '8') {
      ground = await Flame.images.load(Assets.snowGround);
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBackgroundImage,
        data: '8',
      );
    } else if (generalConfigController.gameBackgroundImage.value == '9') {
      ground = await Flame.images.load(Assets.waterFallGround);
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBackgroundImage,
        data: '9',
      );
    } else {
      ground = await Flame.images.load(Assets.cityGround);
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBackgroundImage,
        data: '0',
      );
    }
    log("ground changed to ${generalConfigController.gameBackgroundImage.value}");
    return ground;
  }
}
