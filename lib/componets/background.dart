import 'package:flame/components.dart';

import '../controller/general_config_controller.dart';
import '../game/background_image.dart';
import '../game/floaty_bird_game.dart';
import '../utils/assets.dart';
import '../utils/constants.dart';

class Background extends SpriteGroupComponent<BackgroundImage>
    with HasGameRef<FloatyBirdGame> {
  Background();

  @override
  Future<void> onLoad() async {
    print(
        "generalConfigController.backgroundImage.value ${generalConfigController.gameBackgroundImage.value}");
    final forest = await gameRef.loadSprite(Assets.forestBg);
    final ruins = await gameRef.loadSprite(Assets.ruinsBg);
    final temple = await gameRef.loadSprite(Assets.templeBg);
    final village = await gameRef.loadSprite(Assets.villageBg);
    final village2 = await gameRef.loadSprite(Assets.village2Bg);
    final waterfall = await gameRef.loadSprite(Assets.walterfallBg);
    current = BackgroundImage.waterfall;
    // final background = await Flame.images.load(Assets.background1);
    size = gameRef.size;
    sprites = {
      BackgroundImage.forest: forest,
      BackgroundImage.ruins: ruins,
      BackgroundImage.temple: temple,
      BackgroundImage.village: village,
      BackgroundImage.village2: village2,
      BackgroundImage.waterfall: waterfall,
    };
    // sprite = Sprite(background);
  }

  Future<void> getBackground() async {
    if (generalConfigController.gameBackgroundImage.value == '0') {
      current = BackgroundImage.waterfall;
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBackgroundImage,
        data: '0',
      );
    } else if (generalConfigController.gameBackgroundImage.value == '1') {
      current = BackgroundImage.forest;
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBackgroundImage,
        data: '1',
      );
    } else if (generalConfigController.gameBackgroundImage.value == '2') {
      current = BackgroundImage.ruins;
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBackgroundImage,
        data: '2',
      );
    } else if (generalConfigController.gameBackgroundImage.value == '3') {
      current = BackgroundImage.temple;
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBackgroundImage,
        data: '3',
      );
    } else if (generalConfigController.gameBackgroundImage.value == '4') {
      current = BackgroundImage.village;
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBackgroundImage,
        data: '4',
      );
    } else if (generalConfigController.gameBackgroundImage.value == '5') {
      current = BackgroundImage.village2;
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBackgroundImage,
        data: '5',
      );
    } else {
      current = BackgroundImage.waterfall;
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBackgroundImage,
        data: '0',
      );
    }
  }
}
