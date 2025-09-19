


import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:brick_breaker/components/ball.dart';
import 'package:brick_breaker/components/config.dart';
import 'package:brick_breaker/components/playArea.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

class Brikebreaker extends FlameGame   with HasCollisionDetection {
  final gameLevel level;
  final Color ballColor;
  Brikebreaker({required this.level ,required this.ballColor }) : super(camera: CameraComponent.withFixedResolution(width: gameWidth, height: gameHeight));
  double get width => gameWidth;
  double get height => gameHeight;
  
  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    Vector2 velocity = Vector2.zero();
    camera.viewfinder.anchor = Anchor.topLeft;

    if(level == gameLevel.easy){
      velocity[0] = (Random().nextInt(2) +2) * (Random().nextBool() ? 1 : -1);
      velocity[1] = 2 ;
    } else if (level == gameLevel.medium){
     velocity[0] = (Random().nextInt(2) +4) * (Random().nextBool() ? 1 : -1);
      velocity[1] = 4;
    } else if (level == gameLevel.hard){
     velocity[0] = (Random().nextInt(2) +6) * (Random().nextBool() ? 1 : -1);
      velocity[1] = 6;
    }

     add(PlayArea());
     add(Ball(position: size/3, reduios: gameWidth *0.02, color:ballColor, velocity: velocity,));
     debugMode = true;
  }

}