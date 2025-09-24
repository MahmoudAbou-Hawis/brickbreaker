import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:brick_breaker/components/ball.dart';
import 'package:brick_breaker/components/bat.dart';
import 'package:brick_breaker/components/brick.dart';
import 'package:brick_breaker/components/config.dart';
import 'package:brick_breaker/components/playArea.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';

enum PlayState { welcome, playing, gameOver, won }

class Brikebreaker extends FlameGame with HasCollisionDetection {
  final gameLevel level;
  final Color ballColor;

  late Ball ball;
  late Bat bat;
  late PlayArea playArea;
  late List<Brick> bricks;

   ValueNotifier<int> score = ValueNotifier(0);

  late PlayState _playState;
  PlayState get playState => _playState;

  

  set playState(PlayState playState) {
    _playState = playState;

    switch (playState) {
      case PlayState.gameOver:
             remove(ball);
        remove(bat);
        for (final brick in bricks.toList()) {
        if (brick.isMounted) {
          remove(brick);
        }        }
                overlays.add(playState.name);

        break;
      case PlayState.welcome:
      case PlayState.won:
        overlays.add(playState.name);
 
        break;

      case PlayState.playing:
        overlays.remove(PlayState.welcome.name);
        overlays.remove(PlayState.gameOver.name);
        overlays.remove(PlayState.won.name);
        break;
    }
  }

  Brikebreaker({
    required this.level,
    required this.ballColor,
  }) : super(
          camera: CameraComponent.withFixedResolution(
            width: gameWidth,
            height: gameHeight,
          ),
        );

  double get width => gameWidth;
  double get height => gameHeight;

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
       overlays.remove(PlayState.welcome.name);
        overlays.remove(PlayState.gameOver.name);
        overlays.remove(PlayState.won.name);
    camera.viewfinder.anchor = Anchor.topLeft;

    playArea = PlayArea();
    add(playArea);

    playState = PlayState.welcome;
  }

  void start(Color color) {
    playState = PlayState.playing;
    score.value = 0;

    final velocity = Vector2.zero();

    ball = Ball(
      position: size / 2,
      reduios: gameWidth * 0.03,
      color: color,
      velocity: velocity,
    );

    if (level == gameLevel.easy) {
      velocity[0] = (Random().nextInt(2) + 2) * (Random().nextBool() ? 1 : -1);
      velocity[1] = 2;
    } else if (level == gameLevel.medium) {
      velocity[0] = (Random().nextInt(2) + 4) * (Random().nextBool() ? 1 : -1);
      velocity[1] = 4;
    } else if (level == gameLevel.hard) {
      velocity[0] = (Random().nextInt(2) + 6) * (Random().nextBool() ? 1 : -1);
      velocity[1] = 6;
    }

    add(ball);

    
    bat = Bat(
      position: Vector2(200, 880),
      size: Vector2(size[0] / 3.6, size[0] / 13.9),
      cornerRadius: 150,
    );
    add(bat);

    
    bricks = [];
    final brickPosition = Vector2(40, 60);

    for (int j = 0; j < 6; j++) {
      for (int i = 0; i < brickColors.length - 2; i++) {
        final brick = Brick(
          color: brickColors[i],
          position: brickPosition.clone(),
        );
        bricks.add(brick);
        add(brick);

        brickPosition[0] += (brickWidth + 12);
      }
      brickPosition[0] = 40;
      brickPosition[1] += (brickHeight + 10);
    }

    debugMode = false;
  }
}
