import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_breakout_game/viewModel/circle_movement_viewmodel.dart';

class GameView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Breakout Game'),
      ),
      body: ChangeNotifierProvider(
        create: (_) => CircleMovementViewModel(),
        child: GameBoard(),
      ),
    );
  }
}

class GameBoard extends StatefulWidget {
  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      Provider.of<CircleMovementViewModel>(context, listen: false).startAnimation(size);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CircleMovementViewModel>(
      builder: (context, viewModel, child) {
        return Stack(
          children: [
            ...viewModel.blocks.map((block) {
              return Positioned(
                left: block.position.dx,
                top: block.position.dy,
                child: Container(
                  width: block.width,
                  height: block.height,
                  color: block.color,
                ),
              );
            }).toList(),
            Positioned(
              left: viewModel.circle.position.dx,
              top: viewModel.circle.position.dy,
              child: Container(
                width: viewModel.circle.size.toDouble(),
                height: viewModel.circle.size.toDouble(),
                decoration: BoxDecoration(
                  color: viewModel.circle.color,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  // Atualiza a posição do retângulo controlável
                },
                child: Container(
                  width: 100, // Largura do retângulo controlável
                  height: 20, // Altura do retângulo controlável
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}