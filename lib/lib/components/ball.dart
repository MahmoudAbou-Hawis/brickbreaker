


import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:brick_breaker/brikebreaker.dart';
import 'package:brick_breaker/components/bat.dart';
import 'package:brick_breaker/components/brick.dart';
import 'package:brick_breaker/components/config.dart';
import 'package:brick_breaker/components/playArea.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Ball extends CircleComponent with HasGameReference<Brikebreaker>, CollisionCallbacks { 
final Color color;
bool movingDown = true;
   Vector2 velocity;
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
      if(movingDown && (position.x > 0 || position.x  <= intersectionPoints.last.x) && position.y < game.height - radius){
        velocity[0] =- velocity[0];
      }
      if(movingDown == false && (position.x > 0 || position.x <= intersectionPoints.last.x) && position.y - (2 *radius) >=0 ){
        velocity[0] =- velocity[0];
      }
      if(movingDown == false && position.y - (2 *radius) <=0 ){
        velocity[1] =- velocity[1];
        velocity[0] = velocity[0] * (Random().nextBool() ? 1 : -1);
        movingDown = true;
      }
      if(movingDown && (position.y + (3 * radius))>= gameHeight)
      {
         game.playState = PlayState.gameOver;         
      }
    }
     if(other is Bat)
    {
      movingDown = false;
      velocity[1] =- velocity[1];
      velocity[0] = velocity[0] * (Random().nextBool() ? 1 : -1);
    }
     if(other is Brick)
    {
      
  velocity.y = -velocity.y;
  if(velocity.y < 0) movingDown = false;
  else movingDown = true;

  // Small horizontal variation
  int variation = Random().nextInt(3); // 0, 1, 2
  int direction = Random().nextBool() ? 1 : -1;

  velocity.x += variation * direction;

  final double speed = velocity.length;
  final double targetSpeed = 5.0; 
  velocity = velocity.normalized() * targetSpeed;
        }
  }

  @override
  FutureOr<void> update(double dt) async {
    super.update(dt);
    position += velocity;
  }
}