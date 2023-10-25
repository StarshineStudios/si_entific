import 'package:flutter/material.dart';
import 'dart:math';

import 'package:hexagon/hexagon.dart';

class HexagonGridWidget extends StatelessWidget {
  final double radius;

  HexagonGridWidget({required this.radius});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          _buildHexagon(1.5 * radius, 0.86602540378 * radius),
          _buildHexagon(1.5 * radius, -0.86602540378 * radius),
          _buildHexagon(-1.5 * radius, -0.86602540378 * radius),
          _buildHexagon(-1.5 * radius, 0.86602540378 * radius),
          _buildHexagon(0, -2 * 0.86602540378 * radius),
          _buildHexagon(0, 2 * 0.86602540378 * radius),
          _buildHexagon(0, 0),
        ],
      ),
    );
  }

  Widget _buildHexagon(double offsetY, double offsetX) {
    return Positioned(
      top: offsetY + radius * 2,
      left: offsetX + radius * sqrt(3),
      child: HexagonWidget.pointy(
        height: radius * 2,
        color: Color.fromARGB(255, 191, 211, 206),
        elevation: 4,
        child: const Text('1'),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hexagon Grid Test'),
        ),
        body: Center(
          child: HexagonGridWidget(radius: 30.0), // Adjust the radius as needed
        ),
      ),
    ),
  );
}
