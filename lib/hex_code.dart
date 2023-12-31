import 'dart:math';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'unit.dart';

class Hex {
  int second;
  int meter;
  int kilogram;
  int ampere;
  int kelvin;
  int mole;
  int candela;

  Hex({
    this.second = 0,
    this.meter = 0,
    this.kilogram = 0,
    this.ampere = 0,
    this.kelvin = 0,
    this.mole = 0,
    this.candela = 0,
  });

  void change({
    int second = 0,
    int meter = 0,
    int kilogram = 0,
    int ampere = 0,
    int kelvin = 0,
    int mole = 0,
    int candela = 0,
  }) {
    this.second = second;
    this.meter = meter;
    this.kilogram = kilogram;
    this.ampere = ampere;
    this.kelvin = kelvin;
    this.mole = mole;
    this.candela = candela;
  }

  List<int> getAsList() {
    return [second, meter, kilogram, ampere, kelvin, mole, candela];
  }

  void clear() {
    second = 0;
    meter = 0;
    kilogram = 0;
    ampere = 0;
    kelvin = 0;
    mole = 0;
    candela = 0;
  }

  bool isClear() {
    return second == 0 && meter == 0 && kilogram == 0 && ampere == 0 && kelvin == 0 && mole == 0 && candela == 0;
  }

  int difficulty() {
    return (second.abs() + meter.abs() + kilogram.abs() + ampere.abs() + kelvin.abs() + mole.abs() + candela.abs());
  }

  void addSecond() {
    second += 1;
  }

  void addMeter() {
    meter += 1;
  }

  void addKilogram() {
    kilogram += 1;
  }

  void addAmpere() {
    ampere += 1;
  }

  void addKelvin() {
    kelvin += 1;
  }

  void addMole() {
    mole += 1;
  }

  void addCandela() {
    candela += 1;
  }

  //remove
  void removeSecond() {
    second -= 1;
  }

  void removeMeter() {
    meter -= 1;
  }

  void removeKilogram() {
    kilogram -= 1;
  }

  void removeAmpere() {
    ampere -= 1;
  }

  void removeKelvin() {
    kelvin -= 1;
  }

  void removeMole() {
    mole -= 1;
  }

  void removeCandela() {
    candela -= 1;
  }

  void multiply(Hex other) {
    second += other.second;
    meter += other.meter;
    kilogram += other.kilogram;
    ampere += other.ampere;
    kelvin += other.kelvin;
    mole += other.mole;
    candela += other.candela;
  }

  void divide(Hex other) {
    second = other.second - second;
    meter = other.meter - meter;
    kilogram = other.kilogram - kilogram;
    ampere = other.ampere - ampere;
    kelvin = other.kelvin - kelvin;
    mole = other.mole - mole;
    candela = other.candela - candela;
  }

  // ignore: hash_and_equals
  @override
  bool operator ==(Object other) {
    if (other is Hex) {
      return second == other.second &&
          meter == other.meter &&
          kilogram == other.kilogram &&
          ampere == other.ampere &&
          kelvin == other.kelvin &&
          mole == other.mole &&
          candela == other.candela;
    }
    return false;
  }

  Color getColor() {
    List<Color> colors = [];
    for (var unitAndColor in [
      [second.abs(), color1],
      [meter.abs(), color2],
      [kilogram.abs(), color3],
      [ampere.abs(), color4],
      [kelvin.abs(), color5],
      [mole.abs(), color6],
      [candela.abs(), color7],
    ]) {
      for (int i = 0; i < (unitAndColor[0] as int); i++) {
        colors.add(unitAndColor[1] as Color);
      }
    }
    if (colors.isEmpty) {
      return paleTeal;
    } else {
      return averageColor(colors);
    }
  }

  Color averageColor(List<Color> colorList) {
    if (colorList.isEmpty) {
      // Return a default color if the list is empty
      return Colors.black;
    }

    int totalRed = 0;
    int totalGreen = 0;
    int totalBlue = 0;

    for (Color color in colorList) {
      totalRed += color.red;
      totalGreen += color.green;
      totalBlue += color.blue;
    }

    int averageRed = totalRed ~/ colorList.length; // Use ~/ for integer division
    int averageGreen = totalGreen ~/ colorList.length;
    int averageBlue = totalBlue ~/ colorList.length;

    return Color.fromARGB(
      255, // Alpha value, typically 255 for fully opaque
      averageRed,
      averageGreen,
      averageBlue,
    );
  }

  // void main() {
  // Example usage
  // List<Color> colors = [
  //   Colors.red,
  //   Colors.green,
  //   Colors.blue,
  // ];
  // test of average color
  // Color avgColor = averageColor(colors);
  // print('Average Color: $avgColor');
  // }
  // double fontSize() {
  //   //check if it matches a derived unit
  //   for (Unit unit in derivedUnits) {
  //     if (this == unit.hex) {
  //       return lengthToFontSize(unit.symbol.length);
  //     }
  //   }

  //   var numerator = "";
  //   var denominator = "";

  //   List<String> superscripts = [
  //     '⁰',
  //     '¹',
  //     '²',
  //     '³',
  //     '⁴',
  //     '⁵',
  //     '⁶',
  //     '⁷',
  //     '⁸',
  //     '⁹',
  //   ];

  //   for (var unitAndSymbol in [
  //     [meter, "m"],
  //     [kilogram, "kg"],
  //     [second, "s"],
  //     [ampere, "A"],
  //     [kelvin, "K"],
  //     [mole, "mol"],
  //     [candela, "cd"]
  //   ]) {
  //     final unit = unitAndSymbol[0] as int;
  //     final symbol = unitAndSymbol[1] as String;
  //     if (unit > 0) {
  //       if (unit > 1) {
  //         if (unit <= 9) {
  //           numerator += "$symbol${superscripts[unit]}·";
  //         } else {
  //           numerator += "($symbol^$unit)·";
  //         }
  //       } else {
  //         numerator += "$symbol·";
  //       }
  //     } else if (unit < 0) {
  //       if (unit < -1) {
  //         if (unit == -4) {
  //           denominator += "$symbol⁴·";
  //         } else if (unit == -3) {
  //           denominator += "$symbol³·";
  //         } else if (unit == -2) {
  //           denominator += "$symbol²·";
  //         } else {
  //           denominator += "($symbol^${-1 * unit})·";
  //         }
  //       } else {
  //         denominator += "$symbol·";
  //       }
  //     }
  //   }

  //   if (numerator.isNotEmpty) {
  //     numerator = numerator.substring(0, numerator.length - 1);
  //   }
  //   if (denominator.isNotEmpty) {
  //     denominator = denominator.substring(0, denominator.length - 1);
  //   }

  //   return denominator.length > numerator.length ? lengthToFontSize(denominator.length) : lengthToFontSize(numerator.length);
  // }

  // double lengthToFontSize(int length) {
  //   //double averageHeightToWidthRatio = 3 / 2;
  //   double hexWidth = 120;

  //   return (hexWidth / (length.toDouble() + 6 / 7)); //* averageHeightToWidthRatio;
  // }

  @override
  String toString() {
    //check if it matches a derived unit

    // return 'lol';
    for (Unit unit in derivedUnits) {
      if (this.toBaseUnits() == unit.hex.toBaseUnits()) {
        return unit.symbol;
      }
    }

    var numerator = "";
    var denominator = "";

    List<String> superscripts = [
      '⁰',
      '¹',
      '²',
      '³',
      '⁴',
      '⁵',
      '⁶',
      '⁷',
      '⁸',
      '⁹',
    ];

    for (var unitAndSymbol in [
      [second, "s"],
      [meter, "m"],
      [kilogram, "kg"],
      [ampere, "A"],
      [kelvin, "K"],
      [mole, "mol"],
      [candela, "cd"]
    ]) {
      final unit = unitAndSymbol[0] as int;
      final symbol = unitAndSymbol[1] as String;
      if (unit > 0) {
        if (unit > 1) {
          //4 because the symbol for 5 does not work
          if (unit <= 4) {
            numerator += "$symbol${superscripts[unit]}·";
          } else {
            numerator += "($symbol^$unit)·";
          }
        } else {
          numerator += "$symbol·";
        }
      } else if (unit < 0) {
        if (unit < -1) {
          int abs = unit.abs();
          //4 because the symbol for 5 does not work

          if (abs <= 4) {
            denominator += "$symbol${superscripts[abs]}·";
          } else {
            denominator += "($symbol^$abs)·";
          }
        } else {
          denominator += "$symbol·";
        }
      }
    }

    if (numerator.isNotEmpty) {
      numerator = numerator.substring(0, numerator.length - 1);
    }
    if (denominator.isNotEmpty) {
      denominator = denominator.substring(0, denominator.length - 1);
    }

    int lineCount = max(weightedLength(numerator), weightedLength(denominator)).toInt();
    if (denominator.isNotEmpty) {
      if (numerator.isNotEmpty) {
        return "$numerator\n${'━' * lineCount}\n$denominator";
      } else {
        return "1\n${'━' * lineCount}\n$denominator";
      }
    } else if (numerator.isNotEmpty) {
      return numerator;
    } else {
      return "1";
    }
  }

  double weightedLength(String text) {
    double length = 0.0;

    for (int i = 0; i < text.length; i++) {
      String char = text[i];
      if (char == '·' ||
          char == '^' ||
          char == '⁰' ||
          char == '¹' ||
          char == '²' ||
          char == '³' ||
          char == '⁴' ||
          char == '⁵' ||
          char == '⁶' ||
          char == '⁷' ||
          char == '⁸' ||
          char == '⁹') {
        length += 0.5;
      } else {
        length += 1.0;
      }
    }

    return length;
  }

  List<Hex> toBaseHexes() {
    List<Hex> result = [];
    for (int i = 0; i < second.abs(); i++) {
      result.add(Hex(second: 1));
    }
    for (int i = 0; i < meter.abs(); i++) {
      result.add(Hex(meter: 1));
    }
    for (int i = 0; i < kilogram.abs(); i++) {
      result.add(Hex(kilogram: 1));
    }
    for (int i = 0; i < ampere.abs(); i++) {
      result.add(Hex(ampere: 1));
    }
    for (int i = 0; i < kelvin.abs(); i++) {
      result.add(Hex(kelvin: 1));
    }
    for (int i = 0; i < mole.abs(); i++) {
      result.add(Hex(mole: 1));
    }
    for (int i = 0; i < candela.abs(); i++) {
      result.add(Hex(candela: 1));
    }
    return result;
  }

  String toBaseUnits() {
    //check if it matches a derived unit
    // for (Unit unit in derivedUnits) {
    //   if (this == unit.hex) {
    //     return unit.symbol;
    //   }
    // }

    var numerator = "";
    var denominator = "";

    List<String> superscripts = [
      '⁰',
      '¹',
      '²',
      '³',
      '⁴',
      '⁵',
      '⁶',
      '⁷',
      '⁸',
      '⁹',
    ];

    for (var unitAndSymbol in [
      [second, "s"],
      [meter, "m"],
      [kilogram, "kg"],
      [ampere, "A"],
      [kelvin, "K"],
      [mole, "mol"],
      [candela, "cd"]
    ]) {
      final unit = unitAndSymbol[0] as int;
      final symbol = unitAndSymbol[1] as String;
      if (unit > 0) {
        if (unit > 1) {
          if (unit <= 9) {
            numerator += "$symbol${superscripts[unit]}·";
          } else {
            numerator += "($symbol^$unit)·";
          }
        } else {
          numerator += "$symbol·";
        }
      } else if (unit < 0) {
        if (unit < -1) {
          int abs = unit.abs();
          if (abs <= 9) {
            denominator += "$symbol${superscripts[abs]}·";
          } else {
            denominator += "($symbol^$abs)·";
          }
        } else {
          denominator += "$symbol·";
        }
      }
    }

    if (numerator.isNotEmpty) {
      numerator = numerator.substring(0, numerator.length - 1);
    }
    if (denominator.isNotEmpty) {
      denominator = denominator.substring(0, denominator.length - 1);
    }

    int lineCount = max(weightedLength(numerator), weightedLength(denominator)).toInt();
    if (denominator.isNotEmpty) {
      if (numerator.isNotEmpty) {
        return "$numerator\n${'━' * lineCount}\n$denominator";
      } else {
        return "1\n${'━' * lineCount}\n$denominator";
      }
    } else if (numerator.isNotEmpty) {
      return numerator;
    } else {
      return "1";
    }
  }
}

// final List<List> derivedUnits = [
//   ['Hertz', 'Hz', 'Frequency', Hex(second: -1, meter: 0, kilogram: 0, ampere: 0, kelvin: 0, mole: 0, candela: 0)],
//   ['Newton', 'N', 'Force', Hex(second: -2, meter: 1, kilogram: 1, ampere: 0, kelvin: 0, mole: 0, candela: 0)],
//   ['Pascal', 'Pa', 'Pressure', Hex(second: -2, meter: -1, kilogram: 1, ampere: 0, kelvin: 0, mole: 0, candela: 0)],
//   ['Joule', 'J', 'Energy', Hex(second: -2, meter: 2, kilogram: 1, ampere: 0, kelvin: 0, mole: 0, candela: 0)],
//   ['Watt', 'W', 'Power', Hex(second: -3, meter: 2, kilogram: 1, ampere: 0, kelvin: 0, mole: 0, candela: 0)],
//   ['Coulomb', 'C', 'Electric Charge', Hex(second: 1, meter: 0, kilogram: 0, ampere: 1, kelvin: 0, mole: 0, candela: 0)],
//   ['Volt', 'V', 'Electric Potential', Hex(second: -3, meter: 2, kilogram: 1, ampere: -1, kelvin: 0, mole: 0, candela: 0)],
//   ['Farad', 'F', 'Capacitance', Hex(second: 4, meter: -2, kilogram: -1, ampere: 2, kelvin: 0, mole: 0, candela: 0)],
//   ['Ohm', 'V\n—\nA', 'Resistance', Hex(second: -3, meter: 2, kilogram: 1, ampere: -2, kelvin: 0, mole: 0, candela: 0)],
//   ['Siemens', 'S', 'Electrical Conductance', Hex(second: 3, meter: -2, kilogram: -1, ampere: 2, kelvin: 0, mole: 0, candela: 0)],
//   ['Weber', 'Wb', 'Magnetic Flux', Hex(second: -2, meter: 2, kilogram: 1, ampere: -1, kelvin: 0, mole: 0, candela: 0)],
//   ['Tesla', 'T', 'Magnetic Flux Density', Hex(second: -2, meter: 0, kilogram: 1, ampere: -1, kelvin: 0, mole: 0, candela: 0)],
//   ['Henry', 'H', 'Inductance', Hex(second: -2, meter: 2, kilogram: 1, ampere: -2, kelvin: 0, mole: 0, candela: 0)],
//   ['Lux', 'lx', 'Illuminance', Hex(second: 0, meter: -2, kilogram: 0, ampere: 0, kelvin: 0, mole: 0, candela: 1)],
//   ['Becquerel', 'Bq', 'Activity Referred to a Radionuclide', Hex(second: -1, meter: 0, kilogram: 0, ampere: 0, kelvin: 0, mole: 0, candela: 0)],
//   ['Gray', 'Gy', 'Absorbed Dose (of Ionizing Radiation)', Hex(second: -2, meter: 2, kilogram: 0, ampere: 0, kelvin: 0, mole: 0, candela: 0)],
//   ['Sievert', 'Sv', 'Equivalent Dose (of Ionizing Radiation)', Hex(second: -2, meter: 2, kilogram: 0, ampere: 0, kelvin: 0, mole: 0, candela: 0)],
//   ['Katal', 'kat', 'Catalytic Activity', Hex(second: -1, meter: 0, kilogram: 0, ampere: 0, kelvin: 0, mole: 1, candela: 0)],
//   ['Square Meter', 'm²', 'Area', Hex(second: 0, meter: 2, kilogram: 0, ampere: 0, kelvin: 0, mole: 0, candela: 0)],
//   ['Cubic Meter', 'm³', 'Volume', Hex(second: 0, meter: 3, kilogram: 0, ampere: 0, kelvin: 0, mole: 0, candela: 0)],
//   // Uncomment and complete the rest of the derived units as needed
// ];
