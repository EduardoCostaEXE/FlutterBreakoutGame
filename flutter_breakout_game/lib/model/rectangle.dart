import 'package:flutter/material.dart';

abstract class Rectangle {
  Offset position;
  Color color;
  double height;
  double width;

  Rectangle({
    required this.position,
    required this.color,
    required this.height,
    required this.width,
  });
}