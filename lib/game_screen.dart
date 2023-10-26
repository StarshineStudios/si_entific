// game_screen.dart
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';
import 'package:si_entific/constants.dart';
import 'hexagon_grid_widget.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HexGrid();
  }
}

// //This
// class HexBoardDisplay extends StatefulWidget {
//   final double radius;
//   const HexBoardDisplay({super.key, required this.radius});

//   @override
//   State<HexBoardDisplay> createState() => _HexBoardDisplayState();
// }

// class _HexBoardDisplayState extends State<HexBoardDisplay> {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Positioned(
//           top: 0,
//           left: 0,
//           bottom: 0,
//           right: 0,
//           child: HexagonWidget.pointy(
//             height: widget.radius,
//             color: const Color.fromARGB(255, 54, 244, 54),
//             elevation: 0,
//             child: const Text('PLAY'),
//           ),
//         ),
//       ],
//     );
//   }
// }
