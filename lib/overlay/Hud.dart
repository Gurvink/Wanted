import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:wanted/game.dart';

class Hud extends PositionComponent with HasGameReference<MainGame> {
  Hud({
   super.position,
   super.size,
   super.scale,
   super.angle,
   super.anchor,
   super.children,
   super.priority = 5,
});
  late TextComponent _timerTextComponent;

  @override
  FutureOr<void> onLoad() {
    _timerTextComponent = TextComponent(
      text: 'Time: ${game.time}',
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 32,
          color: Color.fromRGBO(165, 165, 0, 1.0)
        ),
      ),
      anchor: Anchor.center,
      position: Vector2(game.size.x - 100, 20),
    );
    add(_timerTextComponent);
  }

  @override
  void update(double dt){
    _timerTextComponent.text = 'Time: ${game.time}';
  }
}