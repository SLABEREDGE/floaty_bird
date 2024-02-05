import 'dart:async';
import 'dart:developer';

import 'package:floaty_bird/utils/ara_theme.dart';
import 'package:floaty_bird/utils/extension.dart';
import 'package:flutter/material.dart';

import '../game/floaty_bird_game.dart';

class ResumeCountDownWidget extends StatefulWidget {
  final FloatyBirdGame game;
  static const String id = 'countDown';
  const ResumeCountDownWidget({super.key, required this.game});

  @override
  State<ResumeCountDownWidget> createState() => _ResumeCountDownWidgetState();
}

class _ResumeCountDownWidgetState extends State<ResumeCountDownWidget> {
  ValueNotifier<int> timerSeconds = ValueNotifier(3);
  Timer? timer;
  void startTimer(int seconds) {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (timerSeconds.value == 0) {
          timerSeconds.value = 3;
          cancelTimer();
        } else {
          timerSeconds.value = timerSeconds.value - 1;
          log("Remaining Seconds to hide details: ${timerSeconds.value}");
        }
      },
    );
  }

  void cancelTimer() async {
    if (timer != null) {
      widget.game.overlays.remove('countDown');
      timer?.cancel();
      timer = null;
      timerSeconds.value = 3;
    }
  }

  @override
  void initState() {
    startTimer(timerSeconds.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      child: Center(
        child: ValueListenableBuilder(
          valueListenable: timerSeconds,
          builder: (context, v, c) {
            return Text(
              timerSeconds.value.toString(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 120.0.sp,
                    color: Styles.whiteColor,
                  ),
            );
          },
        ),
      ),
    );
  }
}
