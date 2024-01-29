import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../game/floaty_bird_game.dart';
import '../utils/assets.dart';
import '../utils/bouncing_widget.dart';

class PauseMenuButton extends StatelessWidget {
  static const String id = 'pauseMenuButton';
  final FloatyBirdGame game;
  const PauseMenuButton({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      // top: MediaQuery.sizeOf(context).height / 2 * 0.15,
      top: MediaQuery.sizeOf(context).height / 2 * 0.25,
      left: 20,
      child: GestureDetector(
        onTap: () {
          if (!game.isHit) {
            game.pauseEngine();
            game.overlays.add('pauseMenuScreen');
          }
        },
        child: Material(
          color: Colors.transparent,
          child: BouncingWidget(
            child: SvgPicture.asset(
              Assets.pauseButton,
              height: 45,
            ),
          ),
        ),
      ),
    );
  }
}
