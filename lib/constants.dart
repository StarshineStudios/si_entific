import 'package:flutter/material.dart';
import 'hex_code.dart';
import 'unit.dart';

const mediumTeal = Color.fromARGB(255, 33, 139, 130);
const lightTeal = Color.fromARGB(255, 152, 212, 187);
const darkTeal = Color.fromARGB(255, 7, 71, 65);
const white = Color.fromARGB(255, 255, 255, 255);

// Define a custom TextTheme with Nunito font
const TextTheme nunitoTextTheme = TextTheme(
  displayLarge: TextStyle(fontFamily: 'Nunito', fontSize: 96.0, fontWeight: FontWeight.w300),
  displayMedium: TextStyle(fontFamily: 'Nunito', fontSize: 60.0, fontWeight: FontWeight.w300),
  displaySmall: TextStyle(fontFamily: 'Nunito', fontSize: 48.0, fontWeight: FontWeight.w400),
  headlineMedium: TextStyle(fontFamily: 'Nunito', fontSize: 34.0, fontWeight: FontWeight.w400),
  headlineSmall: TextStyle(fontFamily: 'Nunito', fontSize: 24.0, fontWeight: FontWeight.w400),
  titleLarge: TextStyle(fontFamily: 'Nunito', fontSize: 20.0, fontWeight: FontWeight.w500),
  titleMedium: TextStyle(fontFamily: 'Nunito', fontSize: 16.0, fontWeight: FontWeight.w400),
  titleSmall: TextStyle(fontFamily: 'Nunito', fontSize: 14.0, fontWeight: FontWeight.w500),
  bodyLarge: TextStyle(fontFamily: 'Nunito', fontSize: 16.0, fontWeight: FontWeight.w400),
  bodyMedium: TextStyle(fontFamily: 'Nunito', fontSize: 14.0, fontWeight: FontWeight.w400),
  labelLarge: TextStyle(fontFamily: 'Nunito', fontSize: 14.0, fontWeight: FontWeight.w700),
  bodySmall: TextStyle(fontFamily: 'Nunito', fontSize: 12.0, fontWeight: FontWeight.w400),
  labelSmall: TextStyle(fontFamily: 'Nunito', fontSize: 10.0, fontWeight: FontWeight.w400),
);

const TextTheme josefinSansTextTheme = TextTheme(
  displayLarge: TextStyle(fontFamily: 'JosefinSans', fontSize: 96.0, fontWeight: FontWeight.w300),
  displayMedium: TextStyle(fontFamily: 'JosefinSans', fontSize: 60.0, fontWeight: FontWeight.w300),
  displaySmall: TextStyle(fontFamily: 'JosefinSans', fontSize: 48.0, fontWeight: FontWeight.w400),
  headlineMedium: TextStyle(fontFamily: 'JosefinSans', fontSize: 34.0, fontWeight: FontWeight.w400),
  headlineSmall: TextStyle(fontFamily: 'JosefinSans', fontSize: 24.0, fontWeight: FontWeight.w400),
  titleLarge: TextStyle(fontFamily: 'JosefinSans', fontSize: 20.0, fontWeight: FontWeight.w500),
  titleMedium: TextStyle(fontFamily: 'JosefinSans', fontSize: 16.0, fontWeight: FontWeight.w400),
  titleSmall: TextStyle(fontFamily: 'JosefinSans', fontSize: 14.0, fontWeight: FontWeight.w500),
  bodyLarge: TextStyle(fontFamily: 'JosefinSans', fontSize: 16.0, fontWeight: FontWeight.w400),
  bodyMedium: TextStyle(fontFamily: 'JosefinSans', fontSize: 14.0, fontWeight: FontWeight.w400),
  labelLarge: TextStyle(fontFamily: 'JosefinSans', fontSize: 14.0, fontWeight: FontWeight.w700),
  bodySmall: TextStyle(fontFamily: 'JosefinSans', fontSize: 12.0, fontWeight: FontWeight.w400),
  labelSmall: TextStyle(fontFamily: 'JosefinSans', fontSize: 10.0, fontWeight: FontWeight.w400),
);

List<Unit> baseUnits = [
  Unit('second', 's', 'time', Hex(second: 1, meter: 0, kilogram: 0, ampere: 0, kelvin: 0, mole: 0, candela: 0)),
  Unit('meter', 'm', 'length', Hex(second: 0, meter: 1, kilogram: 0, ampere: 0, kelvin: 0, mole: 0, candela: 0)),
  Unit('ampere', 'kg', 'mass', Hex(second: 0, meter: 0, kilogram: 1, ampere: 0, kelvin: 0, mole: 0, candela: 0)),
  Unit('kelvin', 'A', 'electric current', Hex(second: 0, meter: 0, kilogram: 0, ampere: 1, kelvin: 0, mole: 0, candela: 0)),
  Unit('kelvin', 'K', 'thermodynamic temperature', Hex(second: 0, meter: 0, kilogram: 0, ampere: 0, kelvin: 1, mole: 0, candela: 0)),
  Unit('mole', 'mol', 'amount of substance', Hex(second: 0, meter: 0, kilogram: 0, ampere: 0, kelvin: 0, mole: 1, candela: 0)),
  Unit('candela', 'cd', 'time', Hex(second: 0, meter: 0, kilogram: 0, ampere: 0, kelvin: 0, mole: 0, candela: 1)),
];

List<Unit> derivedUnits = [
  Unit('Hertz', 'Hz', 'Frequency', Hex(second: -1, meter: 0, kilogram: 0, ampere: 0, kelvin: 0, mole: 0, candela: 0)),
  Unit('Newton', 'N', 'Force', Hex(second: -2, meter: 1, kilogram: 1, ampere: 0, kelvin: 0, mole: 0, candela: 0)),
  Unit('Pascal', 'Pa', 'Pressure', Hex(second: -2, meter: -1, kilogram: 1, ampere: 0, kelvin: 0, mole: 0, candela: 0)),
  Unit('Joule', 'J', 'Energy', Hex(second: -2, meter: 2, kilogram: 1, ampere: 0, kelvin: 0, mole: 0, candela: 0)),
  Unit('Watt', 'W', 'Power', Hex(second: -3, meter: 2, kilogram: 1, ampere: 0, kelvin: 0, mole: 0, candela: 0)),
  Unit('Coulomb', 'C', 'Electric Charge', Hex(second: 1, meter: 0, kilogram: 0, ampere: 1, kelvin: 0, mole: 0, candela: 0)),
  Unit('Volt', 'V', 'Electric Potential', Hex(second: -3, meter: 2, kilogram: 1, ampere: -1, kelvin: 0, mole: 0, candela: 0)),
  Unit('Farad', 'F', 'Capacitance', Hex(second: 4, meter: -2, kilogram: -1, ampere: 2, kelvin: 0, mole: 0, candela: 0)),
  Unit('Ohm', 'Ω', 'Resistance', Hex(second: -3, meter: 2, kilogram: 1, ampere: -2, kelvin: 0, mole: 0, candela: 0)),
  Unit('Siemens', 'S', 'Electrical Conductance', Hex(second: 3, meter: -2, kilogram: -1, ampere: 2, kelvin: 0, mole: 0, candela: 0)),
  Unit('Weber', 'Wb', 'Magnetic Flux', Hex(second: -2, meter: 2, kilogram: 1, ampere: -1, kelvin: 0, mole: 0, candela: 0)),
  Unit('Tesla', 'T', 'Magnetic Flux Density', Hex(second: -2, meter: 0, kilogram: 1, ampere: -1, kelvin: 0, mole: 0, candela: 0)),
  Unit('Henry', 'H', 'Inductance', Hex(second: -2, meter: 2, kilogram: 1, ampere: -2, kelvin: 0, mole: 0, candela: 0)),
  Unit('Lux', 'lx', 'Illuminance', Hex(second: 0, meter: -2, kilogram: 0, ampere: 0, kelvin: 0, mole: 0, candela: 1)),
  Unit('Becquerel', 'Bq', 'Activity Referred to a Radionuclide', Hex(second: -1, meter: 0, kilogram: 0, ampere: 0, kelvin: 0, mole: 0, candela: 0)),
  Unit('Gray', 'Gy', 'Absorbed Dose', Hex(second: -2, meter: 2, kilogram: 0, ampere: 0, kelvin: 0, mole: 0, candela: 0)),
  Unit('Sievert', 'Sv', 'Equivalent Dose', Hex(second: -2, meter: 2, kilogram: 0, ampere: 0, kelvin: 0, mole: 0, candela: 0)),
  Unit('Katal', 'kat', 'Catalytic Activity', Hex(second: -1, meter: 0, kilogram: 0, ampere: 0, kelvin: 0, mole: 1, candela: 0)),
  Unit('Square Meter', 'm²', 'Area', Hex(second: 0, meter: 2, kilogram: 0, ampere: 0, kelvin: 0, mole: 0, candela: 0)),
  Unit('Cubic Meter', 'm³', 'Volume', Hex(second: 0, meter: 3, kilogram: 0, ampere: 0, kelvin: 0, mole: 0, candela: 0)),
  Unit('Meter per Second', 'm\n―\ns', 'Velocity', Hex(second: -1, meter: 1, kilogram: 0, ampere: 0, kelvin: 0, mole: 0, candela: 0)),
  Unit('Meter per Second Squared', 'm\n―\ns²', 'Acceleration', Hex(second: -2, meter: 1, kilogram: 0, ampere: 0, kelvin: 0, mole: 0, candela: 0)),
  Unit('Reciprocal Meter', 'm⁻¹', 'Wavenumber', Hex(second: 0, meter: -1, kilogram: 0, ampere: 0, kelvin: 0, mole: 0, candela: 0)),
  Unit('Kilogram per Cubic Meter', 'kg\n―\nm³', 'Density', Hex(second: 0, meter: -3, kilogram: 1, ampere: 0, kelvin: 0, mole: 0, candela: 0)),
  Unit('Kilogram per Square Meter', 'kg\n―\nm²', 'Surface Density', Hex(second: 0, meter: -2, kilogram: 1, ampere: 0, kelvin: 0, mole: 0, candela: 0)),
  Unit('Cubic Meter per Kilogram', 'm³\n―\nkg', 'Specific Volume', Hex(second: 0, meter: 3, kilogram: -1, ampere: 0, kelvin: 0, mole: 0, candela: 0)),
  Unit('Ampere per Square Meter', 'A\n―\nm²', 'Current Density', Hex(second: 0, meter: -2, kilogram: 0, ampere: 1, kelvin: 0, mole: 0, candela: 0)),
  Unit('Ampere per Meter', 'A\n―\nm', 'Magnetic Field Strength', Hex(second: 0, meter: -1, kilogram: 0, ampere: 1, kelvin: 0, mole: 0, candela: 0)),
  Unit('Mole per Cubic Meter', 'mol\n―\nm³', 'Concentration', Hex(second: 0, meter: -3, kilogram: 0, ampere: 0, kelvin: 0, mole: 1, candela: 0)),
  Unit('Kilogram per Cubic Meter', 'kg\n―\nm³', 'Mass Concentration', Hex(second: 0, meter: -3, kilogram: 1, ampere: 0, kelvin: 0, mole: 0, candela: 0)),
  Unit('Candela per Square Meter', 'cd\n―\nm²', 'Luminance', Hex(second: 0, meter: -2, kilogram: 0, ampere: 0, kelvin: 0, mole: 0, candela: 1)),
  Unit('Pascal-Second', 'Pa·s', 'Dynamic Viscosity', Hex(second: -1, meter: -1, kilogram: 1, ampere: 0, kelvin: 0, mole: 0, candela: 0)),
  Unit('Newton-Metre', 'N·m', 'Moment of Force', Hex(second: -2, meter: 2, kilogram: 1, ampere: 0, kelvin: 0, mole: 0, candela: 0)),
  Unit('Newton per Meter', 'N\n―\nm', 'Surface Tension', Hex(second: -2, meter: 0, kilogram: 1, ampere: 0, kelvin: 0, mole: 0, candela: 0)),
  Unit('Radian per Second', 'rad\n―\ns', 'Angular Velocity', Hex(second: -1, meter: 0, kilogram: 0, ampere: 0, kelvin: 0, mole: 0, candela: 0)),
  Unit('Radian per Second Squared', 'rad\n―\ns²', 'Angular Acceleration', Hex(second: -2, meter: 0, kilogram: 0, ampere: 0, kelvin: 0, mole: 0, candela: 0)),
  Unit('Watt per Square Meter', 'W\n―\nm²', 'Heat Flux Density', Hex(second: -3, meter: 0, kilogram: 1, ampere: 0, kelvin: 0, mole: 0, candela: 0)),
  Unit('Joule per Kelvin', 'J\n―\nK', 'Entropy', Hex(second: -2, meter: 2, kilogram: 1, ampere: 0, kelvin: -1, mole: 0, candela: 0)),
  Unit('Joule per Kilogram-Kelvin', 'J\n―\n(kg·K)', 'Specific Heat Capacity',
      Hex(second: -2, meter: 2, kilogram: 0, ampere: 0, kelvin: -1, mole: 0, candela: 0)),
  Unit('Joule per Kilogram', 'J\n―\nkg', 'Specific Energy', Hex(second: -2, meter: 2, kilogram: 0, ampere: 0, kelvin: 0, mole: 0, candela: 0)),
  Unit('Watt per Meter-Kelvin', 'W\n―\n(m·K)', 'Thermal Conductivity', Hex(second: -3, meter: 1, kilogram: 1, ampere: 0, kelvin: -1, mole: 0, candela: 0)),
  Unit('Joule per Cubic Meter', 'J\n―\nm³', 'Energy Density', Hex(second: -2, meter: -1, kilogram: 1, ampere: 0, kelvin: 0, mole: 0, candela: 0)),
  Unit('Volt per Meter', 'V\n―\nm', 'Electric Field Strength', Hex(second: -3, meter: 1, kilogram: 1, ampere: -1, kelvin: 0, mole: 0, candela: 0)),
  Unit('Coulomb per Cubic Meter', 'C\n―\nm³', 'Electric Charge Density', Hex(second: 1, meter: -3, kilogram: 0, ampere: 1, kelvin: 0, mole: 0, candela: 0)),
  Unit('Coulomb per Square Meter', 'C\n―\nm²', 'Surface Charge Density', Hex(second: 1, meter: -2, kilogram: 0, ampere: 1, kelvin: 0, mole: 0, candela: 0)),
  Unit('Farad per Meter', 'F\n―\nm', 'Permittivity', Hex(second: 4, meter: -3, kilogram: -1, ampere: 2, kelvin: 0, mole: 0, candela: 0)),
  Unit('Henry per Meter', 'H\n―\nm', 'Permeability', Hex(second: -2, meter: 1, kilogram: 1, ampere: -2, kelvin: 0, mole: 0, candela: 0)),
  Unit('Joule per Mole', 'J\n―\nmol', 'Molar Energy', Hex(second: -2, meter: 2, kilogram: 1, ampere: 0, kelvin: 0, mole: -1, candela: 0)),
  Unit('Joule per Mole-Kelvin', 'J\n―\n(mol·K)', 'Molar Entropy', Hex(second: -2, meter: 2, kilogram: 1, ampere: 0, kelvin: -1, mole: -1, candela: 0)),
  Unit('Coulomb per Kilogram', 'C\n―\nkg', 'Exposure', Hex(second: 1, meter: 0, kilogram: -1, ampere: 1, kelvin: 0, mole: 0, candela: 0)),
  Unit('Gray per Second', 'Gy\n―\ns', 'Absorbed Dose Rate', Hex(second: -3, meter: 2, kilogram: 0, ampere: 0, kelvin: 0, mole: 0, candela: 0)),
  Unit('Watt per Steradian', 'W\n―\nsr', 'Radiant Intensity', Hex(second: -3, meter: 2, kilogram: 1, ampere: 0, kelvin: 0, mole: 0, candela: 0)),
  Unit('Katal per Cubic Meter', 'kat\n―\nm³', 'Catalytic Activity Concentration',
      Hex(second: -1, meter: -3, kilogram: 0, ampere: 0, kelvin: 0, mole: 1, candela: 0)),
];
