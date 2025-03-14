import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:wanted/game.dart';
import 'package:wanted/overlay/gameOver.dart';
import 'package:wanted/overlay/startMenu.dart';
import 'package:wanted/overlay/wantedPoster.dart';

void main() {
  runApp(GameWidget<MainGame>.controlled(
    gameFactory: MainGame.new,
    overlayBuilderMap: {
      'MainMenu': (_, game) => StartMenu(game: game),
      'GameOver': (_, game) => GameOver(game: game),
      'WantedPoster': (_, game) => WantedPoster(game: game, imageNotifier: game.imageNotifier,)
    },
    initialActiveOverlays: const ['MainMenu'],
  ));
}