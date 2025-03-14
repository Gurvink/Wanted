
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:wanted/objects/face.dart';
import 'package:wanted/spawnTypes/GridLeftToRight.dart';
import 'package:wanted/spawnTypes/GridSpawner.dart';
import 'package:wanted/spawnTypes/GridUpToDown.dart';
import 'package:wanted/spawnTypes/RandomMovement.dart';
import 'package:wanted/spawnTypes/SameDirectionPerFace.dart';
import 'package:wanted/spawnTypes/StartFromCenter.dart';
import 'package:wanted/spawnTypes/noMovementRandom.dart';

import '../game.dart';

abstract class Spawner extends Component with HasGameReference<MainGame>{
  void spawnFaces(int faceAmount, Face target);

  static Spawner randomClass(){
    List<Spawner> classes = [
      NoMovementRandom(),
      RandomMovement(),
      SameDirectionPerFace(),
      GridSpawner(),
      GridLeftToRight(),
      GridUpToDown(),
      StartFromCenter()
    ];
    return classes.random();
  }
}