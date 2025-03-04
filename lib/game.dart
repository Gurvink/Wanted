import 'dart:math';
import 'dart:async' as async;

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:wanted/objects/face.dart';
import 'package:wanted/overlay/Hud.dart';
import 'package:flame_audio/flame_audio.dart';

class MainGame extends FlameGame {
  int faceAmount = 50;
  late Timer timer;
  int time = 30;
  bool active = false;
  int round = 0;
  late final TextComponent timerText;


  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'luigi.png',
      'luigi_wanted.png',
      'mario.png',
      'mario_wanted.png',
      'wario.png',
      'wario_wanted.png',
      'yoshi.png',
      'yoshi_wanted.png',
    ]);
    await FlameAudio.audioCache.loadAll([
      'wanted.mp3',
    ]);
    FlameAudio.bgm.initialize();
    timer = Timer(
      1,
      onTick: () => time -= 1,
      repeat: true,
    );
    camera.viewfinder.anchor = Anchor.topLeft;
    camera.viewport.add(Hud());
  }

  @override
  void update(double dt){
    if(time <= 0){
      gameOver();
    }
    if(active){
      timer.update(dt);
    }
    super.update(dt);
  }

  void gameOver(){
    active = false;
    final toRemove = children.whereType<Face>().toList();
    for(var face in toRemove) {
      remove(face);
    }
    overlays.add('GameOver');
    FlameAudio.bgm.stop();
  }

  void StartGame() {
    faceAmount = 50;
    round = 0;
    time = 30;
    NextRound();
    FlameAudio.bgm.play('wanted.mp3');
  }


  void NextRound() {
    FlameAudio.bgm.resume();
    round++;
    var target = Face(character: Faces.values.random());
    target.isTarget = true;
    target.position = Vector2(
        Random().nextDouble() * (size.x),
        Random().nextDouble() * (size.y),
    );
    add(target);
    for(int i = 0; i < faceAmount; i++) {
      var character = target.character;
      do{
        character = Faces.values.random();
      } while(character == target.character);
      var face = Face(character: character);
      face.position = Vector2(
          Random().nextDouble() * (size.x),
          Random().nextDouble() * (size.y),
      );
      add(face);
      add(Hud());
    }
    active = true;
  }

  void gameWon(){
    FlameAudio.bgm.pause();
    final toRemove = children.whereType<Face>().toList();
    late Face target;
    for(var face in toRemove){
      if(!face.isTarget){
        remove(face);
      } else {
        target = face;
      }
    }
    faceAmount = (faceAmount * 1.2).toInt();
    active = false;

    async.Timer(Duration(seconds: 3), () {
      remove(target);
      NextRound();
    });
  }
}