

import 'dart:async';
import 'dart:math';

import 'package:brick_breaker/brikebreaker.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';

class PlayArea extends RectangleComponent with HasGameReference<Brikebreaker> {
  PlayArea() : super(paint: Paint()..color = const Color(0xfff2e8cf),
  children: [
    RectangleHitbox(),
  ],
  );

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    size = Vector2(game.width, game.height);
  }
}