import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:wanted/game.dart';
import 'package:wanted/overlay/gameOver.dart';
import 'package:wanted/overlay/startMenu.dart';

void main() {
  runApp(GameWidget<MainGame>.controlled(
    gameFactory: MainGame.new,
    overlayBuilderMap: {
      'MainMenu': (_, game) => StartMenu(game: game),
      'GameOver': (_, game) => GameOver(game: game)
    },
    initialActiveOverlays: const ['MainMenu'],
  ));
}