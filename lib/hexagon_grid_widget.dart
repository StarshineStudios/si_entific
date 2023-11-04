import 'package:flutter/material.dart';
import 'dart:math';

import 'package:hexagon/hexagon.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:si_entific/constants.dart';
import 'board.dart';

class HexGrid extends StatefulWidget {
  const HexGrid({super.key});

  @override
  State<HexGrid> createState() => _HexGridState();
}

class _HexGridState extends State<HexGrid> {
  Board board = Board();
  double radius = 71;
  bool hasBeatenHighScore = false;

  String bottomText = 'Complete the tasks above';

  int selectedIndex = -1;
  int polarity = 0; // -1 is dividing, 0 is not selected, 1 is

  Future<bool> _onWillPop() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: mediumTeal,
            title: const Text(
              'Quit Game?',
              style: TextStyle(color: white, fontSize: 35),
            ),
            content: const Text(
              'All Progress will be lost. Do you really want to go back? Highscores are saved.',
              style: TextStyle(color: white, fontSize: 20),
            ),
            actions: [
              NiceButton(
                color: lightTeal,

                onPressed: () => Navigator.of(context).pop(true), // Allow navigation back
                child: const Padding(
                  padding: EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
                  child: Text(
                    'Yes',
                    style: TextStyle(color: white, fontSize: 20),
                  ),
                ),
              ),
              NiceButton(
                color: lightTeal,

                onPressed: () => Navigator.of(context).pop(false), // Stay on the page
                child: const Padding(
                  padding: EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
                  child: Text(
                    'No',
                    style: TextStyle(color: white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

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
          //print('something terrible happened');
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
          //print('something went terribly wrong');
        }
      }
    }

    //print(selectedIndex);
  }

  void manageOrder(int orderIndex) {
    if (selectedIndex != -1) {
      int originalScore = board.score;

      board.processOrder(orderIndex, selectedIndex);

      if (board.score == originalScore) {
        bottomText = 'Incorrect! Try again!';
      } else if (board.score > originalScore) {
        bottomText = 'Good Job!';
      } else if (board.score > originalScore + 4) {
        bottomText = 'Excellent!';
      } else if (board.score > originalScore + 5) {
        bottomText = 'Pure genius?';
      } else if (board.score > originalScore + 6) {
        bottomText = 'That was a tough one! Good Job!';
      } else if (board.score > originalScore + 7) {
        bottomText = 'Big Brain Moment!';
      } else if (board.score > originalScore + 8) {
        bottomText = "Your teacher must be proud!";
      } else if (board.score > originalScore + 9) {
        bottomText = 'Splendiferous!';
      } else if (board.score > originalScore + 10) {
        bottomText = 'Fantabulous!';
      } else if (board.score > originalScore + 10) {
        bottomText = 'Supercalifragilisticexpialidocious!';
      }

      selectedIndex = -1;
      polarity = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    //print(board.hexes);

    return ValueListenableBuilder(
      valueListenable: Hive.box('generalBox').listenable(),
      builder: (context, box, widget) {
        int highscore = box.get('highscore', defaultValue: 0);

        //if you have beaten it, we set the bool to true

        if (board.score > highscore) {
          hasBeatenHighScore = true;
          box.put('highscore', board.score);
        }

        String topText = hasBeatenHighScore ? 'New Highscore! $highscore' : 'Score: ${board.score} Highscore: $highscore';

        return Scaffold(
          backgroundColor: mediumTeal,
          appBar: AppBar(
            title: Text(
              topText,
              textAlign: TextAlign.center,
              textScaleFactor: 1.5,
              style: const TextStyle(fontSize: 16),
            ),
            backgroundColor: mediumTeal,
            foregroundColor: white,
          ),
          body: WillPopScope(
            onWillPop: _onWillPop,
            child: Center(
              child: ListView(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Column(
                  //   children: board.orders.asMap().entries.map((entry) {
                  //     int index = entry.key;
                  //     Order order = entry.value;
                  //     return _buildOrder(order.toString(), index);
                  //   }).toList(),
                  // ),

                  _buildOrder(board.orders[0].toString(), 0),
                  _buildOrder(board.orders[1].toString(), 1),

                  _buildOrder(board.orders[2].toString(), 2),

                  // Column(
                  //   children: [
                  //     Text(
                  //       'Score: ${board.score}',
                  //       style: const TextStyle(fontSize: 25, color: white),
                  //     ),
                  //     Text(
                  //       'Moves: ${board.moveCount}',
                  //       style: const TextStyle(fontSize: 25, color: white),
                  //     ),
                  //   ],
                  // ),
                  Center(
                    child: Container(
                      constraints: BoxConstraints.expand(width: 0.86602540378 * radius * 6, height: radius * 6), // Set yourWidth and yourHeight accordingly
                      color: transp,
                      child: Stack(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = -1;
                                polarity = 0;
                              });
                            },
                            child: Container(
                              color: transp,
                            ),
                          ),

                          // _buildDecorativeHexagon(1.5 * radius, -0.86602540378 * radius, darkTeal),
                          // _buildDecorativeHexagon(0, -2 * 0.86602540378 * radius, darkTeal),
                          // _buildDecorativeHexagon(1.5 * radius, 0.86602540378 * radius, darkTeal),
                          // _buildDecorativeHexagon(0, 0, darkTeal),
                          // _buildDecorativeHexagon(-1.5 * radius, -0.86602540378 * radius, darkTeal),
                          // _buildDecorativeHexagon(-1.5 * radius, 0.86602540378 * radius, darkTeal),

                          _buildHexagon(1.5 * radius, -0.86602540378 * radius, board.hexes[0].toString(), 0, board.hexes[0].getColor()),
                          _buildHexagon(0, -2 * 0.86602540378 * radius, board.hexes[1].toString(), 1, board.hexes[1].getColor()),
                          _buildHexagon(1.5 * radius, 0.86602540378 * radius, board.hexes[2].toString(), 2, board.hexes[2].getColor()),
                          _buildHexagon(0, 0, board.hexes[3].toString(), 3, board.hexes[3].getColor()),
                          _buildHexagon(-1.5 * radius, -0.86602540378 * radius, board.hexes[4].toString(), 4, board.hexes[4].getColor()),
                          _buildHexagon(0, 2 * 0.86602540378 * radius, board.hexes[5].toString(), 5, board.hexes[5].getColor()),
                          _buildHexagon(-1.5 * radius, 0.86602540378 * radius, board.hexes[6].toString(), 6, board.hexes[6].getColor()),

                          // _buildHexagon(1.5 * radius, -0.86602540378 * radius, board.hexes[0].toString(), 0),
                          // _buildHexagon(0, -2 * 0.86602540378 * radius, board.hexes[1].toString(), 1),
                          // _buildHexagon(1.5 * radius, 0.86602540378 * radius, board.hexes[2].toString(), 2),
                          // _buildHexagon(0, 0, board.hexes[3].toString(), 3),
                          // _buildHexagon(-1.5 * radius, -0.86602540378 * radius, board.hexes[4].toString(), 4),
                          // _buildHexagon(0, 2 * 0.86602540378 * radius, board.hexes[5].toString(), 5),
                          // _buildHexagon(-1.5 * radius, 0.86602540378 * radius, board.hexes[6].toString(), 6),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: selectedIndex == -1
                              ? transp
                              : polarity == 1
                                  ? Colors.red
                                  : Colors.green,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            selectedIndex == -1
                                ? bottomText
                                : polarity == 1
                                    ? 'Multiplying'
                                    : 'Dividing',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 28, color: white),
                          ),
                        ),
                      ),
                    ),
                  ),

                  _buildBigHexagon(
                    0,
                    0,
                    selectedIndex == -1 ? 'Select Hex to See\n Base Unit Breakdown' : board.hexes[selectedIndex].toBaseUnits(),
                    3,
                    selectedIndex == -1 ? paleTeal : board.hexes[selectedIndex].getColor(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildOrder(String label, int orderIndex) {
    return GestureDetector(
      onTap: () {
        setState(() {
          manageOrder(orderIndex);
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: lightTeal),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 21,
                  color: white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildDecorativeHexagon(double offsetY, double offsetX, Color hexColor) {
  //   return Positioned(
  //     top: offsetY + radius * 2,
  //     left: offsetX + radius * sqrt(3),
  //     child: HexagonWidget.pointy(
  //       height: radius * 2 + 5,
  //       color: darkTeal,
  //       elevation: 0,
  //     ),
  //   );
  // }

  Widget _buildHexagon(double offsetY, double offsetX, String label, int index, Color hexColor) {
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
          color: transp,
          elevation: 0,
          child: HexagonWidget.pointy(
            height: radius * 2 - 10,
            color: index == selectedIndex ? (polarity == 1 ? Colors.red : Colors.green) : hexColor,
            elevation: 0,
            child: HexagonWidget.pointy(
              height: radius * 2 - 25,
              color: hexColor,
              elevation: 0,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: white, fontSize: 70, height: 0),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //the display hex at bottom
  Widget _buildBigHexagon(double offsetY, double offsetX, String label, int index, Color hexColor) {
    return Container(
      // top: offsetY + radius * 2,
      // left: offsetX + radius * sqrt(3),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = -1;
            polarity = 0;
          });
        },
        child: HexagonWidget.pointy(
          height: (radius * 2) * 2.75,
          color: darkTeal,
          elevation: 0,
          child: HexagonWidget.pointy(
            height: (radius * 2 - 15) * 2.75,
            color: hexColor,
            elevation: 0,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: white, fontSize: 70, height: 0),
                ),
              ),
            ),
          ),
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
