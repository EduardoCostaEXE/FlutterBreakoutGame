import 'dart:ui';
import 'package:flutter_breakout_game/model/rectangle.dart';

class DestructibleRectangle extends Rectangle {
  DestructibleRectangle({
    required Offset position,
    required Color color,
    required double height,
    required double width,
  }) : super(
    position: position,
    color: color,
    height: height,
    width: width,
  );
}