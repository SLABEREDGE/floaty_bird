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
    final city = await gameRef.loadSprite(Assets.cityGameBg);
    final desert = await gameRef.loadSprite(Assets.desertGameBg);
    final forest = await gameRef.loadSprite(Assets.forestGameBg);
    final hell = await gameRef.loadSprite(Assets.hellGameBg);
    final ice = await gameRef.loadSprite(Assets.iceGameBg);
    final lava = await gameRef.loadSprite(Assets.lavaGameBg);
    final nebula = await gameRef.loadSprite(Assets.nebulaGameBg);
    final mountain = await gameRef.loadSprite(Assets.mountainGameBg);
    final snow = await gameRef.loadSprite(Assets.snowGameBg);
    final waterfall = await gameRef.loadSprite(Assets.walterfallBg);
    // current = BackgroundImage.waterfall;
    current = await getBackground();
    // final background = await Flame.images.load(Assets.background1);
    size = gameRef.size;
    sprites = {
      BackgroundImage.city: city,
      BackgroundImage.desert: desert,
      BackgroundImage.forest: forest,
      BackgroundImage.hell: hell,
      BackgroundImage.ice: ice,
      BackgroundImage.lava: lava,
      BackgroundImage.mountain: mountain,
      BackgroundImage.nebula: nebula,
      BackgroundImage.snow: snow,
      BackgroundImage.waterfall: waterfall,
    };
    // sprite = Sprite(background);
  }

  Future<BackgroundImage?> getBackground() async {
    if (generalConfigController.gameBackgroundImage.value == '0') {
      current = BackgroundImage.city;
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBackgroundImage,
        data: '0',
      );
    } else if (generalConfigController.gameBackgroundImage.value == '1') {
      current = BackgroundImage.desert;
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBackgroundImage,
        data: '1',
      );
    } else if (generalConfigController.gameBackgroundImage.value == '2') {
      current = BackgroundImage.forest;
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBackgroundImage,
        data: '2',
      );
    } else if (generalConfigController.gameBackgroundImage.value == '3') {
      current = BackgroundImage.hell;
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBackgroundImage,
        data: '3',
      );
    } else if (generalConfigController.gameBackgroundImage.value == '4') {
      current = BackgroundImage.ice;
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBackgroundImage,
        data: '4',
      );
    } else if (generalConfigController.gameBackgroundImage.value == '5') {
      current = BackgroundImage.lava;
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBackgroundImage,
        data: '5',
      );
    } else if (generalConfigController.gameBackgroundImage.value == '6') {
      current = BackgroundImage.mountain;
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBackgroundImage,
        data: '6',
      );
    } else if (generalConfigController.gameBackgroundImage.value == '7') {
      current = BackgroundImage.nebula;
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBackgroundImage,
        data: '7',
      );
    } else if (generalConfigController.gameBackgroundImage.value == '8') {
      current = BackgroundImage.snow;
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBackgroundImage,
        data: '8',
      );
    } else if (generalConfigController.gameBackgroundImage.value == '9') {
      current = BackgroundImage.waterfall;
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBackgroundImage,
        data: '9',
      );
    } else {
      current = BackgroundImage.city;
      await generalConfigController.setHiveData(
        fieldName: DBFields.gameBackgroundImage,
        data: '0',
      );
    }
    return current;
  }
}
