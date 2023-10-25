import 'dart:math';
import 'Hex.dart';
import 'order.dart';
import 'constants.dart';
import 'package:flutter/material.dart';

class Board {
  static final List<List<int>> compatibility = [
    [2, 3, 1], // Hex 0
    [0, 3, 4], // Hex 1
    [0, 3, 5], // Hex 2
    [0, 1, 2, 4, 5, 6], // Hex 3
    [1, 3, 6], // Hex 4
    [2, 3, 6], // Hex 5
    [3, 4, 5], // Hex 6
  ];

  List<Hex> hexes;
  List<Order> orders;
  int score;
  int moveCount;
  int orderCount;

  Board({
    Hex hex0,
    Hex hex1,
    Hex hex2,
    Hex hex3,
    Hex hex4,
    Hex hex5,
    Hex hex6,
  }) {
    hexes = [hex0, hex1, hex2, hex3, hex4, hex5, hex6];
    orders = [Order(), Order(), Order()];
    score = 0;
    moveCount = 0;
    orderCount = 0;
  }

  void refreshOrder(int orderIndex) {
    score += orders[orderIndex].points;

    final newUnit = derivedUnits[Random().nextInt(derivedUnits.length)];
    orders[orderIndex].change(
      hex: newUnit.hex,
      points: newUnit.hex.difficulty(),
      quantityName: newUnit.quantity,
      unitName: newUnit.name,
    );
  }

  void addHex() {
    // First check that there are spaces to spawn a thing.
    var available = false;
    final availableIndexes = <int>[];
    for (var index = 0; index < 7; index++) {
      if (hexes[index].isClear()) {
        available = true;
        availableIndexes.add(index);
      }
    }

    if (!available) {
      print('game over');
      // You may want to handle the game over logic here.
    }

    final spawnIndex = availableIndexes[Random().nextInt(availableIndexes.length)];
    final newUnit = baseUnits[Random().nextInt(baseUnits.length)];

    hexes[spawnIndex].change(
      second: newUnit.hex.second,
      meter: newUnit.hex.meter,
      kilogram: newUnit.hex.kilogram,
      ampere: newUnit.hex.ampere,
      kelvin: newUnit.hex.kelvin,
      mole: newUnit.hex.mole,
      candela: newUnit.hex.candela,
    );
  }

  @override
  String toString() {
    return 'Hex0: ${hexes[0].toString()}, Hex1: ${hexes[1].toString()}, Hex2: ${hexes[2].toString()}, Hex3: ${hexes[3].toString()}, Hex4: ${hexes[4].toString()}, Hex5: ${hexes[5].toString()}, Hex6: ${hexes[6].toString()},';
  }

  // We move the first hex INTO the second hex, thus the first hex may disappear.
  bool multiplyHexes(int hexIndex1, int hexIndex2) {
    if (compatibility[hexIndex1].contains(hexIndex2)) {
      moveCount++;
      hexes[hexIndex2].multiply(hexes[hexIndex1]);
      hexes[hexIndex1].clear();
      return true;
    }
    return false;
  }

  // We move the first hex INTO the second hex, thus the first hex may disappear.
  bool divideHexes(int hexIndex1, int hexIndex2) {
    if (compatibility[hexIndex1].contains(hexIndex2)) {
      moveCount++;
      hexes[hexIndex2].divide(hexes[hexIndex1]);
      hexes[hexIndex1].clear();
      return true;
    }
    return false;
  }
}
