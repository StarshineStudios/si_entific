import 'hex_code.dart';

class Order {
  Hex hex;
  int points;
  String quantityName;
  String unitName;

  Order({required this.hex, required this.points, required this.quantityName, required this.unitName});

  void change(Hex hex, int points, String quantityName, String unitName) {
    this.hex = hex;
    this.points = points;
    this.quantityName = quantityName;
    this.unitName = unitName;
  }

  bool compareTo(Hex hex) {
    return this.hex == hex;
  }

  @override
  String toString() {
    return "Create a\n$unitName,\nthe unit for\n$quantityName";
    // return "Create the unit for\n$quantityName";
  }
}
