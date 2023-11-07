import 'hex_code.dart';

class Unit {
  String name;
  String symbol;
  String quantity;
  Hex hex;

  Unit(this.name, this.symbol, this.quantity, this.hex) {
    name = name.toLowerCase();
    quantity = quantity.toLowerCase();
    // this.description = description; // Eg: "The second, symbol s, is the SI unit of time. It is defined by taking the fixed numerical value of the caesium frequency, ∆νCs, the unperturbed ground-state hyperfine transition frequency of the caesium 133 atom, to be 9192631770 when expressed in the unit Hz, which is equal to s−1."
  }

  // void change(Hex hex, int points, String quantityName, String unitName) {
  //   this.hex = hex;
  //   this.points = points;
  //   this.quantityName = quantityName;
  //   this.unitName = unitName;
  // }

  bool compareTo(Hex hex) {
    return this.hex == hex;
  }

  @override
  String toString() {
    return "Create a $name, the unit for $quantity";
    // return "Create the unit for\n$quantityName";
  }

  int getPoints() {
    int points = 0;

    points += hex.second.abs();
    points += hex.meter.abs();
    points += hex.kilogram.abs();
    points += hex.ampere.abs();
    points += hex.kelvin.abs();
    points += hex.mole.abs();
    points += hex.candela.abs();

    return points;
  }
}
