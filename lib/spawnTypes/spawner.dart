
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:wanted/objects/face.dart';
import 'package:wanted/spawnTypes/RandomMovement.dart';
import 'package:wanted/spawnTypes/noMovementRandom.dart';

import '../game.dart';

abstract class Spawner extends Component with HasGameReference<MainGame>{
  Face spawnFaces(int faceAmount, Face target);

  static Spawner randomClass(){
    List<Spawner> classes = [NoMovementRandom(), RandomMovement()];
    return classes.random();
  }
}