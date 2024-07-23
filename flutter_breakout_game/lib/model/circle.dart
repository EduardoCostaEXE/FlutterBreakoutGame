import 'package:flutter/material.dart';

class Circle {
  Offset position;
  int size;
  double radius;
  Color? color;

  Circle({
    required this.position,
    required this.size,
    this.color
  }) : radius = size / 2.0;
}