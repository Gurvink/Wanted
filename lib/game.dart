import 'dart:async' as async;

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:wanted/objects/face.dart';
import 'package:wanted/overlay/Hud.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:wanted/spawnTypes/spawner.dart';

class MainGame extends FlameGame {
  int faceAmount = 50;
  late Timer timer;
  int time = 30;
  bool active = false;
  int round = 0;
  int amountInScreen = 200;
  late Spawner spawner;
  final ValueNotifier<String> imageNotifier = ValueNotifier('luigi_wanted.png');

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
    FlameAudio.bgm.pause();
    add(Hud());
  }


  void NextRound() {
    round++;
    var spawner = Spawner.randomClass();
    add(spawner);
    var target = Face(character: Faces.values.random(), game: this);
    changeImage(target.character);
    overlays.add("WantedPoster");
    async.Timer(Duration(seconds: 3), (){
      overlays.remove("WantedPoster");
      spawner.spawnFaces(faceAmount, target);
      active = true;
      FlameAudio.bgm.resume();
    });
  }

  void gameWon(){
    FlameAudio.bgm.pause();
    final toRemove = children.whereType<Face>().toList();
    Face target = toRemove.firstWhere((e) => e.isTarget);
    for(var face in toRemove){
      if(!face.isTarget){
        remove(face);
      }
    }
    faceAmount = (faceAmount * 1.1).toInt();
    active = false;
    async.Timer(Duration(seconds: 3), () {
      remove(target);
      NextRound();
    });
  }

  void changeImage(Faces target){
    switch(target) {
      case Faces.mario:
        imageNotifier.value = 'mario_wanted.png';
      case Faces.luigi:
        imageNotifier.value = 'luigi_wanted.png';
      case Faces.wario:
        imageNotifier.value = 'wario_wanted.png';
      case Faces.yoshi:
        imageNotifier.value = 'yoshi_wanted.png';
    }
  }
}