import 'dart:math';

import 'package:flame/extensions.dart';
import 'package:wanted/objects/face.dart';
import 'package:wanted/spawnTypes/spawner.dart';

class StartFromCenter extends Spawner{
  @override
  void spawnFaces(int faceAmount, Face target) {
    Random random = Random();
    target.isTarget = true;
    target.position = Vector2(game.size.x/2, game.size.y/2);
    target.checkCollision = target.bounceOnWalls;
    int position = random.nextInt(faceAmount + 1);
    Vector2 velocity = Vector2(10, 0);
    for(int i = 0; i <= faceAmount; i++) {
      velocity.rotate(radians(360/faceAmount));
      if(i == position){
        target.velocity = velocity.clone();
        game.add(target);
      } else {
        var character = target.character;
        do {
          character = Faces.values.random();
        } while (character == target.character);
        var face = Face(character: character, game: game);
        face.position = Vector2(game.size.x / 2, game.size.y / 2);
        face.checkCollision = face.bounceOnWalls;
        face.velocity = velocity.clone();
        game.add(face);
      }
    }
  }

}