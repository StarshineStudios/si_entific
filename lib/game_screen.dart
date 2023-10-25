// game_screen.dart
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Game Title'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Center(
                child: Text('temp'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//This
class hexBoardDisplay extends StatefulWidget {
  double radius;
  hexBoardDisplay({super.key, required this.radius});

  @override
  State<hexBoardDisplay> createState() => _hexBoardDisplayState();
}

class _hexBoardDisplayState extends State<hexBoardDisplay> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          bottom: 0,
          right: 0,
          child: HexagonWidget.pointy(
            height: widget.radius,
            color: const Color.fromARGB(255, 54, 244, 54),
            elevation: 8,
            child: const Text('PLAY'),
          ),
        ),
      ],
    );
  }
}
