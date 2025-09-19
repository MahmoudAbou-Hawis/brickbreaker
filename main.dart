


import 'package:brick_breaker/brikebreaker.dart';
import 'package:brick_breaker/components/config.dart';
import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';

void main(){
  runApp(GameWidget(game:  Brikebreaker(level:gameLevel.hard, ballColor: const Color.fromARGB(255, 50, 110, 70))));
}