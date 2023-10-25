import 'package:flutter/material.dart';
import 'dart:math';

import 'package:hexagon/hexagon.dart';
import 'board.dart';

class HexGrid extends StatefulWidget {
  const HexGrid({super.key});

  @override
  State<HexGrid> createState() => _HexGridState();
}

class _HexGridState extends State<HexGrid> {
  Board board = Board();
  double radius = 30;

  int selectedIndex = -1;
  int polarity = 0; // -1 is dividing, 0 is not selected, 1 is

  void manageTap(int newIndex) {
    //IF THERE IS NOTHING SELECTED, SELECT IT
    if (selectedIndex == -1) {
      selectedIndex = newIndex;
      polarity = 1;

      //THERE IS SOMETHING SELECTED
    } else {
      //IF WE ARE TAPPING THE SAME HEX AGAIN
      if (newIndex == selectedIndex) {
        //if it is set to multiply mode, set it to divide
        if (polarity == 1) {
          polarity = -1;
          //if it is set to division, unselect it
        } else if (polarity == -1) {
          polarity = 0;
          selectedIndex = -1;
          //if it is not selected this is literally impossible
        } else {
          print('something terrible happened');
        }
        //IF WE ARE TAPPING A DIFFERENT HEX
      } else {
        if (polarity == 1) {
          if (board.multiplyHexes(selectedIndex, newIndex)) {
            board.addHex();
            selectedIndex = -1;
            polarity = 0;
          }
        } else if (polarity == -1) {
          if (board.divideHexes(selectedIndex, newIndex)) {
            board.addHex();
            selectedIndex = -1;
            polarity = 0;
          }
        } else {
          print('something went terribly wrong');
        }
      }
    }

    print(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Text('Score: ${board.score}'),
        // Text('Moves: ${board.moveCount}'),
        // Column(
        //   children: board.orders.map((order) {
        //     return _buildOrder(order.toString());
        //   }).toList(),
        // ),
        Center(
          child: Stack(
            children: <Widget>[
              _buildHexagon(1.5 * radius, -0.86602540378 * radius, board.hexes[0].toString(), 0),
              _buildHexagon(0, -2 * 0.86602540378 * radius, board.hexes[1].toString(), 1),
              _buildHexagon(1.5 * radius, 0.86602540378 * radius, board.hexes[2].toString(), 2),
              _buildHexagon(0, 0, board.hexes[3].toString(), 3),
              _buildHexagon(-1.5 * radius, -0.86602540378 * radius, board.hexes[4].toString(), 4),
              _buildHexagon(0, 2 * 0.86602540378 * radius, board.hexes[5].toString(), 5),
              _buildHexagon(-1.5 * radius, 0.86602540378 * radius, board.hexes[6].toString(), 6),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrder(String label) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(40), color: Colors.amber),
      child: Text(
        label,
        style: TextStyle(fontSize: 10),
      ),
    );
  }

  Widget _buildHexagon(double offsetY, double offsetX, String label, int index) {
    return Positioned(
      top: offsetY + radius * 2,
      left: offsetX + radius * sqrt(3),
      child: GestureDetector(
        onTap: () {
          setState(() {
            manageTap(index);
          });
        },
        child: HexagonWidget.pointy(
          height: radius * 2,
          color: index == selectedIndex ? (polarity == 1 ? Colors.red : Colors.green) : const Color.fromARGB(255, 191, 211, 206),
          elevation: 4,
          child: Text(label),
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Hexagon Grid Test'),
        ),
        body: const Center(
          child: HexGrid(), // Adjust the radius as needed
        ),
      ),
    ),
  );
}
