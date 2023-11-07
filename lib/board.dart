import 'dart:math';
import 'hex_code.dart';
import 'order.dart';
import 'constants.dart';
import 'unit.dart';
import 'package:dart_random_choice/dart_random_choice.dart';

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
  late List<Unit> orders = [
    // Unit(hex: Hex(meter: 1), points: 1, quantityName: 'length', unitName: 'meter'),
    // Unit(hex: Hex(second: 1), points: 1, quantityName: 'time', unitName: 'second'),
    // Unit(hex: Hex(kilogram: 1), points: 1, quantityName: 'mass', unitName: 'kilogram'),

    Unit('meter', 'm', 'length', Hex(meter: 1)),
    Unit('second', 's', 'time', Hex(second: 1)),
    Unit('kilogram', 'kg', 'mass', Hex(kilogram: 1)),
  ];

  late List<Unit> ordersQueued = derivedUnits;

  late List<Hex> orderHexes = [];
  int score = 0;
  int moveCount = 0;
  int orderCount = 0;

  Board();

  void processOrder(int orderIndex, int hexIndex) {
    //JUST A TEMPORARY SOLUTION TO CONVERT TO STRINGS
    if (hexes[hexIndex].toBaseUnits() == orders[orderIndex].hex.toBaseUnits()) {
      score += orders[orderIndex].getPoints();

      int getOrderIndex = Random().nextInt(ordersQueued.length);
      print(ordersQueued);
      Unit newUnit = ordersQueued.removeAt(getOrderIndex);

      //derivedUnits[Random().nextInt(derivedUnits.length)];
      // orders[orderIndex].change(
      //   newUnit.hex,
      //   newUnit.hex.difficulty(),
      //   newUnit.quantity,
      //   newUnit.name,
      // );
      orders[orderIndex] = newUnit;
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
      //print('something went terriibly wrong.');
      return;
      // You may want to handle the game over logic here.
    }

    final int spawnIndex = availableIndexes[Random().nextInt(availableIndexes.length)];

    //now check the units that we have.

    //if empty, we should add it to
    if (orderHexes.isEmpty) {
      orderHexes.addAll(orders[0].hex.toBaseHexes());
      orderHexes.addAll(orders[1].hex.toBaseHexes());
      orderHexes.addAll(orders[2].hex.toBaseHexes());
    }
    print(orderHexes);

    //for each order, look at it's base components
    // for (int k = 0; k < 3; k++) {
    //   Order order = orders[k];
    //   List<int> listOfAmounts = order.hex.getAsList();

    //   for (int i = 0; i < 7; i++) {
    //     for (int j = 0; j < listOfAmounts[i].abs(); j++) {
    //       orderUnits.add(baseUnits[j]);
    //     }
    //   }
    // }

    Random random = Random();
    int randomOrderHexIndex = random.nextInt(orderHexes.length); // Generates a random number between 0 and 99

    final Hex randomOrderHex = orderHexes.removeAt(randomOrderHexIndex);

    final Hex randomBaseHex = randomChoice(baseHexes, [.18, .18, .16, .14, .11, .11, .12]);

    //choose whether to use a random one or one for an order.
    int randomNumber = random.nextInt(100); // Generates a random number between 0 and 99
    bool isUsingOrderUnit = randomNumber < 90; // Returns true ~66% of the time

    final Hex newHex = isUsingOrderUnit ? randomOrderHex : randomBaseHex;

    // final Unit newUnit = baseUnits[Random().nextInt(baseUnits.length)];

    //print(newUnit.hex.toString());

    hexes[spawnIndex] = newHex;

    // Hex(
    //   second: newUnit.hex.second,
    //   meter: newUnit.hex.meter,
    //   kilogram: newUnit.hex.kilogram,
    //   ampere: newUnit.hex.ampere,
    //   kelvin: newUnit.hex.kelvin,
    //   mole: newUnit.hex.mole,
    //   candela: newUnit.hex.candela,
    // );
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
