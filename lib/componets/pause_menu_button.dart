import 'package:flutter/material.dart';

import '../../../utils/ara_theme.dart';
import '../game/floaty_bird_game.dart';
import '../utils/bouncing_widget.dart';

class PauseMenuButton extends StatelessWidget {
  static const String id = 'pauseMenuButton';
  final FloatyBirdGame game;
  const PauseMenuButton({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.sizeOf(context).height / 2 * 0.15,
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
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.indigoAccent,
                borderRadius: BorderRadius.circular(10),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    offset: const Offset(4, 4),
                    blurRadius: 8.0,
                    color: Styles.whiteColor.withOpacity(0.3),
                  ),
                  BoxShadow(
                    offset: const Offset(4, 4),
                    blurRadius: 8.0,
                    color: Styles.blackColor.withOpacity(0.6),
                  ),
                ],
              ),
              child: const Icon(
                Icons.pause,
                size: 25,
                color: Styles.whiteColor,
              ),
            ),
            // Container(
            //   padding: const EdgeInsets.all(5),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            //   child: const Icon(
            //     Icons.pause,
            //     color: Colors.greenAccent,
            //   ),
            // ),
          ),
        ),
      ),
    );
  }
}
