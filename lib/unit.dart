import 'Hex.dart';

class Unit {
  late String name;
  late String symbol;
  late String quantity;
  late Hex hex;

  Unit(String name, this.symbol, String quantity, this.hex) {
    this.name = name.toLowerCase(); // Eg: s
    this.quantity = quantity.toLowerCase();
    // this.description = description; // Eg: "The second, symbol s, is the SI unit of time. It is defined by taking the fixed numerical value of the caesium frequency, ∆νCs, the unperturbed ground-state hyperfine transition frequency of the caesium 133 atom, to be 9192631770 when expressed in the unit Hz, which is equal to s−1."
  }
}
