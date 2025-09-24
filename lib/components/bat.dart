


import 'dart:ui';

import 'package:brick_breaker/brikebreaker.dart' hide Colors;
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class Bat extends PositionComponent with HasGameReference<Brikebreaker> , DragCallbacks {

  Bat({required Vector2 position , required Vector2 size , required this.cornerRadius}
) : super(position: position, size: size, anchor: Anchor.center ,children: [RectangleHitbox()]);

  final double cornerRadius;


  @override
  void render(Canvas canvas) {
    super.render(canvas);
    Paint paint = Paint()..color = Colors.greenAccent;
    Rect rect = Rect.fromLTRB(0,0,120,30);
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(cornerRadius)), paint); 
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
 super.onDragUpdate(event);
    position.x = (position.x + event.localDelta.x).clamp(0, game.width);
  }
}