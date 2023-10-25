import 'Hex.dart';

class Order {
  Hex hex;
  double points;
  String quantityName;
  String unitName;

  Order({required this.hex, required this.points, required this.quantityName, required this.unitName});

  void change(Hex hex, double points, String quantityName, String unitName) {
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
    if (unitName != null) {
      return "Create a\n$unitName,\nthe unit for\n$quantityName";
    }
    return "Create the unit for\n$quantityName";
  }
}
