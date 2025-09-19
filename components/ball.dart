


import 'dart:async';
import 'dart:ui';

import 'package:brick_breaker/brikebreaker.dart';
import 'package:brick_breaker/components/playArea.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Ball extends CircleComponent with HasGameReference<Brikebreaker>, CollisionCallbacks { 
final Color color;
bool movingDown = true;
  final Vector2 velocity;
  Ball({required Vector2 position , required double reduios, required this.color ,required this.velocity})
  : super(paint:  Paint()..color = color, radius: reduios, position: position ,  
            anchor: Anchor.center,
            children:  [
              CircleHitbox(),
            ]
);


@override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ){
    super.onCollisionStart(intersectionPoints, other);
    if (other is PlayArea) {
      print(position);
      print(intersectionPoints);
      if(movingDown && (position.x > 0 || position.x <= intersectionPoints.last.x)){
        velocity[0] =- velocity[0];
      }

    }
  }

  @override
  FutureOr<void> update(double dt) async {
    super.update(dt);
    position += velocity;
  }
}