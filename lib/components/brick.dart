



import 'package:brick_breaker/brikebreaker.dart';
import 'package:brick_breaker/components/ball.dart';
import 'package:brick_breaker/components/config.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';

class Brick extends RectangleComponent with CollisionCallbacks , HasGameReference<Brikebreaker>{

  Brick({required Color color ,required super.position}) :super(anchor: Anchor.center,size: Vector2(brickWidth, brickHeight),paint: Paint()..color = color,children: [RectangleHitbox()]);

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
        super.onCollisionStart(intersectionPoints, other);
    removeFromParent();

    if(other is Ball)
    {
    game.score.value++;
    if(game.score.value == 6 * 8) game.playState = PlayState.won;
    }
  }
}