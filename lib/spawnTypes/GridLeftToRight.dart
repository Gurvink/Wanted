import 'dart:math';

import 'package:flame/extensions.dart';
import 'package:wanted/objects/face.dart';
import 'package:wanted/spawnTypes/spawner.dart';

class GridLeftToRight extends Spawner{
  @override
  void spawnFaces(int faceAmount, Face target) {
    target.isTarget = true;
    Random random = Random();
    int FacesAmount = (((game.size.y - target.size.y)/target.size.y) * ((game.size.x - target.size.x) / target.size.x)).toInt();
    int position = random.nextInt(FacesAmount + 1);
    int loopAmount = 0;
    Vector2 velocity = Vector2(5, 0);
    for(double y = target.size.y; y <= game.size.y; y += target.size.y){
      for(double x = 0; x <= game.size.x + target.size.x; x += target.size.x){
        if(loopAmount == position){
          target.position = Vector2(x, y);
          target.velocity = velocity;
          game.add(target);
        }  else {
          var character = target.character;
          do{
            character = Faces.values.random();
          } while(character == target.character);
          Face face = Face(character: character, game: game);
          face.position = Vector2(x, y);
          face.velocity = velocity;
          game.add(face);
        }
        loopAmount++;
      }
      velocity = -velocity;
    }
  }
}