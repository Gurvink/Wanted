import 'dart:math';

import 'package:flame/extensions.dart';
import 'package:wanted/objects/face.dart';
import 'package:wanted/spawnTypes/spawner.dart';

class NoMovementRandom extends Spawner{
  @override
  void spawnFaces(int faceAmount, Face target) {
    target.isTarget = true;
    target.position = Vector2(
      Random().nextDouble() * (game.size.x - target.size.x) + target.size.x,
      Random().nextDouble() * (game.size.y - target.size.y) + target.size.y,
    );
    for(int i = 0; i < faceAmount; i++) {
      var character = target.character;
      do{
        character = Faces.values.random();
      } while(character == target.character);
      var face = Face(character: character);
      face.position = Vector2(
        Random().nextDouble() * (game.size.x - face.size.x) + face.size.x,
        Random().nextDouble() * (game.size.y - face.size.y) + face.size.y,
      );
      game.add(face);
    }
    game.add(target);
  }
}
