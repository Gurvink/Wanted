import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import '../game.dart';

enum Faces {mario, luigi, wario, yoshi}

class Face extends SpriteComponent with HasGameReference<MainGame>, TapCallbacks{
  final Faces character;
  late Image faceImage;

  Vector2 velocity = Vector2.zero();
  final double speed = 20;
  bool isTarget = false;

  Face({required this.character}) : super(size: Vector2.all(64), anchor: Anchor.center);

  @override
  Future<void> onLoad() async{
    super.onLoad();
    velocity = Vector2(Random().nextDouble()*10-10, Random().nextDouble()*10-10);
    switch(character){
      case Faces.mario:
        faceImage = game.images.fromCache('mario.png');
        break;
      case Faces.luigi:
        faceImage = game.images.fromCache('luigi.png');
        break;
      case Faces.wario:
        faceImage = game.images.fromCache('wario.png');
        break;
      case Faces.yoshi:
        faceImage = game.images.fromCache('yoshi.png');
        break;
    }
    sprite = Sprite(faceImage);
  }

  @override
  void onTapDown(TapDownEvent event){
    if(isTarget){
      velocity = Vector2.zero();
      game.time += 5;
      game.gameWon();
    } else {
      game.time -= 3;
      removeFromParent();
    }
  }

  @override
  void update(double dt){
    if(position.x < 0 || position.x > game.size.x){
      velocity.x = -velocity.x;
    }
    if(position.y < 0 || position.y > game.size.y){
      velocity.y = -velocity.y;
    }
    position += velocity * speed * dt;
    super.update(dt);
  }

}