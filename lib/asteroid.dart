import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';
import 'package:si_entific/constants.dart';
import 'package:si_entific/rotator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Falling Asteroids'),
        ),
        body: const AsteroidStack(),
      ),
    );
  }
}

class AsteroidStack extends StatelessWidget {
  const AsteroidStack({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        SpinnyAsteroid(50.0, 2.0 / 2, color1, 's', 60.0, true, const Duration(seconds: 5), screenWidth), // Set the initial X-position and falling speed
        SpinnyAsteroid(100.0, 1.5 / 2, color2, 'm', 70.0, false, const Duration(seconds: 7), screenWidth),
        SpinnyAsteroid(150.0, 2.5 / 2, color3, 'kg', 70.0, true, const Duration(seconds: 4), screenWidth),
        SpinnyAsteroid(200.0, 1.0 / 2, color4, 'A', 65.0, false, const Duration(seconds: 8), screenWidth),
        SpinnyAsteroid(250.0, 2.0 / 2, color5, 'K', 65.0, true, const Duration(seconds: 3), screenWidth),
        SpinnyAsteroid(150.0, 2.5 / 2, color3, 'mol', 90.0, false, const Duration(seconds: 5), screenWidth),
        SpinnyAsteroid(200.0, 1.0 / 2, color4, 'cd', 85.0, true, const Duration(seconds: 4), screenWidth),
      ],

      // [
      //   PositionedAsteroid(50.0, 2.0, Colors.red, "A", 50.0), // Set the initial X-position and falling speed
      //   PositionedAsteroid(100.0, 1.5, Colors.green, "B", 40.0),
      //   PositionedAsteroid(150.0, 2.5, Colors.blue, "C", 60.0),
      //   PositionedAsteroid(200.0, 1.0, Colors.orange, "D", 45.0),
      //   PositionedAsteroid(250.0, 2.0, Colors.purple, "E", 55.0),
      // ],
    );
  }
}

class PositionedAsteroid extends StatelessWidget {
  final double initialX;
  final double fallingSpeed;
  final Color color;
  final String text;
  final double width;

  const PositionedAsteroid(this.initialX, this.fallingSpeed, this.color, this.text, this.width, {super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Get the screen width

    return Asteroid(
      initialX: initialX,
      fallingSpeed: fallingSpeed,
      screenWidth: screenWidth,
      child: HexagonWidget.pointy(
        width: width,
        color: color,
        elevation: 0,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 40),
        ),
      ),
    );
  }
}

class SpinnyAsteroid extends StatelessWidget {
  final double initialX;
  final double fallingSpeed;
  final Color color;
  final String text;
  final double width;
  final bool clockwise;
  final Duration duration;
  final double screenWidth;

  const SpinnyAsteroid(this.initialX, this.fallingSpeed, this.color, this.text, this.width, this.clockwise, this.duration, this.screenWidth, {super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen width

    return Asteroid(
      initialX: initialX,
      fallingSpeed: fallingSpeed,
      screenWidth: screenWidth,
      child: LogoRotate(
        duration: duration,
        clockwise: true,
        child: HexagonWidget.pointy(
          width: width,
          color: color,
          elevation: 0,
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 40),
          ),
        ),
      ),
    );
  }
}

class Asteroid extends StatefulWidget {
  final Widget child;
  final double initialX;
  final double fallingSpeed;
  final double screenWidth; // Add the screen width parameter

  const Asteroid({super.key, required this.child, required this.initialX, required this.fallingSpeed, required this.screenWidth});

  @override
  State<Asteroid> createState() => _AsteroidState();
}

class _AsteroidState extends State<Asteroid> with TickerProviderStateMixin {
  late AnimationController _controller;
  double positionX = 0.0;
  double positionY = 0.0;
  final Random random = Random(); // Create a Random object

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Adjust the base animation duration
      vsync: this,
    );

    _controller.addListener(() {
      setState(() {
        // Calculate the Y-position based on the animation value
        positionY = _controller.value * MediaQuery.of(context).size.height;
      });
    });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        positionY = -750.0; // Set the Y-position above the screen

        // Generate a random X position within the screen width
        positionX = random.nextDouble() * widget.screenWidth;

        _controller.forward(from: 0.0); // Teleport the asteroid to the top
      }
    });

    // Adjust the animation duration based on the falling speed
    _controller.duration = Duration(milliseconds: 2000 ~/ widget.fallingSpeed);

    // Set the initial X-position
    positionX = widget.initialX;

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: positionY,
      left: positionX, // Set the X-position
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
