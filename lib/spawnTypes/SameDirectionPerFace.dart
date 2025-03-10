import "dart:math";

import "package:flame/extensions.dart";
import "package:wanted/objects/face.dart";

import "spawner.dart";

class SameDirectionPerFace extends Spawner {
  @override
  void spawnFaces(int faceAmount, Face target) {
    target.position = Vector2(
      Random().nextDouble() * (game.size.x - target.size.x) + target.size.x,
      Random().nextDouble() * (game.size.y - target.size.y) + target.size.y,
    );
    target.velocity = Vector2(Random().nextDouble()*2-1, Random().nextDouble()*2-1)*10;
    target.isTarget = true;
    game.add(target);
    List<Vector2> velocities = [
      Vector2(Random().nextDouble()*2-1, Random().nextDouble()*2-1)*10,
      Vector2(Random().nextDouble()*2-1, Random().nextDouble()*2-1)*10,
      Vector2(Random().nextDouble()*2-1, Random().nextDouble()*2-1)*10,
      Vector2(Random().nextDouble()*2-1, Random().nextDouble()*2-1)*10
    ];
    for(int i = 0; i <= faceAmount; i++){
      var character = target.character;
      do{
        character = Faces.values.random();
      } while(character == target.character);
      var face = Face(character: character, game: game);
      face.position = Vector2(
        Random().nextDouble() * (game.size.x - face.size.x) + face.size.x,
        Random().nextDouble() * (game.size.y - face.size.y) + face.size.y,
      );
      switch(face.character) {
        case Faces.mario:
          face.velocity = velocities[0];
        case Faces.luigi:
          face.velocity = velocities[1];
        case Faces.wario:
          face.velocity = velocities[2];
        case Faces.yoshi:
          face.velocity = velocities[3];
      }
      game.add(face);
    }
  }
}