import 'dart:math';
import 'hex_code.dart';
import 'order.dart';
import 'constants.dart';
import 'unit.dart';

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

  List<Hex> hexes = [Hex(), Hex(), Hex(), Hex(meter: 1), Hex(), Hex(), Hex()];
  //List<Order> orders = [Order(), Order(), Order()];
  late List<Order> orders = [
    Order(hex: Hex(meter: 1), points: 1, quantityName: 'length', unitName: 'meter'),
    Order(hex: Hex(meter: 1), points: 1, quantityName: 'length', unitName: 'meter'),
    Order(hex: Hex(meter: 1), points: 1, quantityName: 'length', unitName: 'meter'),
  ];
  int score = 0;
  int moveCount = 0;
  int orderCount = 0;

  Board();

  void processOrder(int orderIndex, int hexIndex) {
    //JUST A TEMPORARY SOLUTION TO CONVERT TO STRINGS
    if (hexes[hexIndex].toString() == orders[orderIndex].hex.toString()) {
      score += orders[orderIndex].points;

      Unit newUnit = derivedUnits[Random().nextInt(derivedUnits.length)];
      orders[orderIndex].change(
        newUnit.hex,
        newUnit.hex.difficulty(),
        newUnit.quantity,
        newUnit.name,
      );
      hexes[hexIndex].clear();
    }
  }

  void addHex() {
    // First check that there are spaces to spawn a thing.
    var available = false;

    List<int> availableIndexes = [];
    for (var index = 0; index < 7; index++) {
      if (hexes[index].isClear()) {
        available = true;
        availableIndexes.add(index);
      }
    }

    if (!available) {
      print('game over');
      return;
      // You may want to handle the game over logic here.
    }

    final int spawnIndex = availableIndexes[Random().nextInt(availableIndexes.length)];
    final Unit newUnit = baseUnits[Random().nextInt(baseUnits.length)];

    print(newUnit.hex.toString());

    hexes[spawnIndex] = Hex(
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
