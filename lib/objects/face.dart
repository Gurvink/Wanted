import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import '../game.dart';

enum Faces {mario, luigi, wario, yoshi}

class Face extends SpriteComponent with TapCallbacks{
  final Faces character;
  late Image faceImage;
  Vector2 velocity = Vector2.zero();
  final double speed = 20;
  bool isTarget = false;
  MainGame game;

  Face({required this.character, required this.game}) : super(anchor: Anchor.center)
  {
    size = Vector2.all(
        min(game.size.x  / sqrt(game.amountInScreen), game.size.y / sqrt(game.amountInScreen))
    );
  }

  @override
  Future<void> onLoad() async{
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
    super.onLoad();
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
    if(position.x < 0 - size.x){
      position.x = game.size.x + size.x;
    } else if (position.x > game.size.x + size.x){
      position.x = 0 - size.x;
    }

    if(position.y < 0 - size.y){
      position.y = game.size.y + size.y;
    } else if (position.y > game.size.y + size.y){
      position.y = 0 - size.y;
    }
    position += velocity * speed * dt;
    super.update(dt);
  }
}