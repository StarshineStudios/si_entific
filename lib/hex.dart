import 'dart:math';

class Hex {
  double second;
  double meter;
  double kilogram;
  double ampere;
  double kelvin;
  double mole;
  double candela;

  Hex(
    int i, {
    this.second = 0.0,
    this.meter = 0.0,
    this.kilogram = 0.0,
    this.ampere = 0.0,
    this.kelvin = 0.0,
    this.mole = 0.0,
    this.candela = 0.0,
  });

  void change({
    double second = 0,
    double meter = 0,
    double kilogram = 0,
    double ampere = 0,
    double kelvin = 0,
    double mole = 0,
    double candela = 0,
  }) {
    this.second = second;
    this.meter = meter;
    this.kilogram = kilogram;
    this.ampere = ampere;
    this.kelvin = kelvin;
    this.mole = mole;
    this.candela = candela;
  }

  List<double> getAsList() {
    return [second, meter, kilogram, ampere, kelvin, mole, candela];
  }

  void clear() {
    meter = 0;
    kilogram = 0;
    second = 0;
    ampere = 0;
    kelvin = 0;
    mole = 0;
    candela = 0;
  }

  bool isClear() {
    return meter == 0 && kilogram == 0 && second == 0 && ampere == 0 && kelvin == 0 && mole == 0 && candela == 0;
  }

  double difficulty() {
    return (second.abs() + meter.abs() + kilogram.abs() + ampere.abs() + kelvin.abs() + mole.abs() + candela.abs());
  }

  void addMeter() {
    meter += 1;
  }

  void addKilogram() {
    kilogram += 1;
  }

  void addSecond() {
    second += 1;
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

  void removeMeter() {
    meter -= 1;
  }

  void removeKilogram() {
    kilogram -= 1;
  }

  void removeSecond() {
    second -= 1;
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
    if (other != null) {
      meter += other.meter;
      kilogram += other.kilogram;
      second += other.second;
      ampere += other.ampere;
      kelvin += other.kelvin;
      mole += other.mole;
      candela += other.candela;
    } else {
      throw ArgumentError("Can only multiply with another Hex object.");
    }
  }

  void divide(Hex other) {
    if (other != null) {
      meter = other.meter - meter;
      kilogram = other.kilogram - kilogram;
      second = other.second - second;
      ampere = other.ampere - ampere;
      kelvin = other.kelvin - kelvin;
      mole = other.mole - mole;
      candela = other.candela - candela;
    } else {
      throw ArgumentError("Can only divide by another Hex object.");
    }
  }

  @override
  bool operator ==(Object hex) {
    if (hex is Hex) {
      return meter == hex.meter &&
          kilogram == hex.kilogram &&
          second == hex.second &&
          ampere == hex.ampere &&
          kelvin == hex.kelvin &&
          mole == hex.mole &&
          candela == hex.candela;
    }
    return false;
  }

  @override
  String toString() {
    for (var unit in derivedUnits) {
      if (this == unit[3]) {
        return unit[1];
      }
    }

    var numerator = "";
    var denominator = "";

    for (var unitAndSymbol in [
      [meter, "m"],
      [kilogram, "kg"],
      [second, "s"],
      [ampere, "A"],
      [kelvin, "K"],
      [mole, "mol"],
      [candela, "cd"]
    ]) {
      final unit = unitAndSymbol[0] as double;
      final symbol = unitAndSymbol[1] as String;
      if (unit > 0) {
        if (unit > 1) {
          if (unit == 4) {
            numerator += "$symbol⁴·";
          } else if (unit == 3) {
            numerator += "$symbol³·";
          } else if (unit == 2) {
            numerator += "$symbol²·";
          } else {
            numerator += "($symbol^$unit)·";
          }
        } else {
          numerator += "$symbol·";
        }
      } else if (unit < 0) {
        if (unit < -1) {
          if (unit == -4) {
            denominator += "$symbol⁴·";
          } else if (unit == -3) {
            denominator += "$symbol³·";
          } else if (unit == -2) {
            denominator += "$symbol²·";
          } else {
            denominator += "($symbol^${-1 * unit})·";
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

    if (denominator.isNotEmpty) {
      return "$numerator\n${'—' * max(numerator.length, denominator.length)}\n$denominator";
    } else if (numerator.isNotEmpty) {
      return numerator;
    } else {
      return "1";
    }
  }
}

final List<List> derivedUnits = [
  ['Hertz', 'Hz', 'Frequency', Hex(second: -1, meter: 0, kilogram: 0, ampere: 0, kelvin: 0, mole: 0, candela: 0)],
  ['Newton', 'N', 'Force', Hex(second: -2, meter: 1, kilogram: 1, ampere: 0, kelvin: 0, mole: 0, candela: 0)],
  ['Pascal', 'Pa', 'Pressure', Hex(second: -2, meter: -1, kilogram: 1, ampere: 0, kelvin: 0, mole: 0, candela: 0)],
  ['Joule', 'J', 'Energy', Hex(second: -2, meter: 2, kilogram: 1, ampere: 0, kelvin: 0, mole: 0, candela: 0)],
  ['Watt', 'W', 'Power', Hex(second: -3, meter: 2, kilogram: 1, ampere: 0, kelvin: 0, mole: 0, candela: 0)],
  ['Coulomb', 'C', 'Electric Charge', Hex(second: 1, meter: 0, kilogram: 0, ampere: 1, kelvin: 0, mole: 0, candela: 0)],
  ['Volt', 'V', 'Electric Potential', Hex(second: -3, meter: 2, kilogram: 1, ampere: -1, kelvin: 0, mole: 0, candela: 0)],
  ['Farad', 'F', 'Capacitance', Hex(second: 4, meter: -2, kilogram: -1, ampere: 2, kelvin: 0, mole: 0, candela: 0)],
  ['Ohm', 'V\n—\nA', 'Resistance', Hex(second: -3, meter: 2, kilogram: 1, ampere: -2, kelvin: 0, mole: 0, candela: 0)],
  ['Siemens', 'S', 'Electrical Conductance', Hex(second: 3, meter: -2, kilogram: -1, ampere: 2, kelvin: 0, mole: 0, candela: 0)],
  ['Weber', 'Wb', 'Magnetic Flux', Hex(second: -2, meter: 2, kilogram: 1, ampere: -1, kelvin: 0, mole: 0, candela: 0)],
  ['Tesla', 'T', 'Magnetic Flux Density', Hex(second: -2, meter: 0, kilogram: 1, ampere: -1, kelvin: 0, mole: 0, candela: 0)],
  ['Henry', 'H', 'Inductance', Hex(second: -2, meter: 2, kilogram: 1, ampere: -2, kelvin: 0, mole: 0, candela: 0)],
  ['Lux', 'lx', 'Illuminance', Hex(second: 0, meter: -2, kilogram: 0, ampere: 0, kelvin: 0, mole: 0, candela: 1)],
  ['Becquerel', 'Bq', 'Activity Referred to a Radionuclide', Hex(second: -1, meter: 0, kilogram: 0, ampere: 0, kelvin: 0, mole: 0, candela: 0)],
  ['Gray', 'Gy', 'Absorbed Dose (of Ionizing Radiation)', Hex(second: -2, meter: 2, kilogram: 0, ampere: 0, kelvin: 0, mole: 0, candela: 0)],
  ['Sievert', 'Sv', 'Equivalent Dose (of Ionizing Radiation)', Hex(second: -2, meter: 2, kilogram: 0, ampere: 0, kelvin: 0, mole: 0, candela: 0)],
  ['Katal', 'kat', 'Catalytic Activity', Hex(second: -1, meter: 0, kilogram: 0, ampere: 0, kelvin: 0, mole: 1, candela: 0)],
  ['Square Meter', 'm²', 'Area', Hex(second: 0, meter: 2, kilogram: 0, ampere: 0, kelvin: 0, mole: 0, candela: 0)],
  ['Cubic Meter', 'm³', 'Volume', Hex(second: 0, meter: 3, kilogram: 0, ampere: 0, kelvin: 0, mole: 0, candela: 0)],
  // Uncomment and complete the rest of the derived units as needed
];
