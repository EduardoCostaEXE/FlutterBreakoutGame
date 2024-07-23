import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../model/circle.dart';
import '../model/destructible_rectangle.dart';

class CircleMovementViewModel extends ChangeNotifier {
  Circle _circle;
  double _dx = 0;
  double _dy = -1;
  final double _speed = 4;
  final int _size = 20;
  final Random _random = Random();

  List<DestructibleRectangle> blocks = [];

  CircleMovementViewModel()
      : _circle = Circle(position: const Offset(200, 380), size: 20, color: Colors.black) {
  }

  Circle get circle => _circle;

  void startAnimation(Size screenSize) {
    initializeBlocks(screenSize);
    Timer.periodic(const Duration(milliseconds: 16), (timer) {
      _moveCircle(screenSize);
    });
  }

  void _moveCircle(Size screenSize) {
    double newX = _circle.position.dx + _dx * _speed;
    double newY = _circle.position.dy + _dy * _speed;

    if (newX <= 0 || newX + _size >= screenSize.width) {
      _dx = -_dx;
    }
    if (newY <= 0) {
      _dy = -_dy;
    }
    if (newY + _size >= screenSize.height) {
      _dy = -_dy;// Fim de jogo
    }

    for (DestructibleRectangle block in blocks) {
      if (collidesWithBlock(block)) {
        _dy = -_dy;
        blocks.remove(block);
        break;
      }
    }

    _circle = Circle(position: Offset(newX, newY), size: _size, color: _circle.color);
    notifyListeners();
  }

  bool collidesWithBlock(DestructibleRectangle block) {
    Rect circleRect = Rect.fromCircle(
        center: Offset(
          _circle.position.dx + (_size / 2),
          _circle.position.dy + (_size / 2),
        ),
        radius: _circle.radius
    );
    Rect blockRect = Rect.fromLTWH(
        block.position.dx, block.position.dy, block.width, block.height
    );
    return circleRect.overlaps(blockRect);
  }

  void initializeBlocks(Size screenSize) {
    int rows = 3;
    int cols = 5;
    double blockHeight = 20; // Altura do bloco
    double padding = 5; // Espaço entre os blocos
    double blockWidth = (screenSize.width - ((cols -1) * padding))/cols; // Largura do bloco de acordo com o tamanho da tela

    blocks = [];

    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols - (row % 2); col++) {
        blocks.add(DestructibleRectangle(
          position: Offset(
              col * (blockWidth + padding),
              row * (blockHeight + padding)
          ),
          color: Colors.blue,
          height: blockHeight,
          width: blockWidth,
        ));
      }
    }
  }

  void _changeColor() { //Talvez implementar mais tarde
    _circle = Circle(
      position: _circle.position,
      size: _circle.size,
      color: Color.fromARGB(
        255,
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
      ),
    );
    notifyListeners();
  }
}