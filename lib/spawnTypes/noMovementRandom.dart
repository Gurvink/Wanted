import 'dart:math';

import 'package:flame/extensions.dart';
import 'package:wanted/objects/face.dart';
import 'package:wanted/spawnTypes/spawner.dart';

class NoMovementRandom extends Spawner{
  @override
  Face spawnFaces(int faceAmount, Face target) {
    target.isTarget = true;
    target.position = Vector2(
      Random().nextDouble() * (game.size.x - 20) + 20,
      Random().nextDouble() * (game.size.y - 20) + 20,
    );
    for(int i = 0; i < faceAmount; i++) {
      var character = target.character;
      do{
        character = Faces.values.random();
      } while(character == target.character);
      var face = Face(character: character);
      face.position = Vector2(
        Random().nextDouble() * (game.size.x - 20) + 20,
        Random().nextDouble() * (game.size.y - 20) + 20,
      );
      game.add(face);
    }
    game.add(target);
    return target;
  }
}
