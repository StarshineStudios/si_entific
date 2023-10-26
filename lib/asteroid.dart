import 'package:flutter/material.dart';

class Asteroid extends StatefulWidget {
  final double startingDistance;
  final double maxDistance;
  final double speed;
  final Widget child;

  Asteroid({
    required this.startingDistance,
    required this.maxDistance,
    required this.speed,
    required this.child,
  });

  @override
  _AsteroidState createState() => _AsteroidState();
}

class _AsteroidState extends State<Asteroid> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: (widget.maxDistance - widget.startingDistance) ~/ widget.speed),
    );

    _animation = Tween<double>(
      begin: widget.startingDistance,
      end: widget.maxDistance,
    ).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Positioned(
          top: _animation.value,
          child: child!,
        );
      },
      child: widget.child,
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Asteroid Animation'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Asteroid(
                startingDistance: 0.0,
                maxDistance: 100.0,
                speed: 50.0,
                child: Container(
                  width: 30,
                  height: 30,
                  color: Colors.red,
                ),
              ),
              Asteroid(
                startingDistance: 50.0,
                maxDistance: 150.0,
                speed: 40.0,
                child: Container(
                  width: 30,
                  height: 30,
                  color: Colors.green,
                ),
              ),
              Asteroid(
                startingDistance: 20.0,
                maxDistance: 200.0,
                speed: 30.0,
                child: Container(
                  width: 30,
                  height: 30,
                  color: Colors.blue,
                ),
              ),
              Asteroid(
                startingDistance: 80.0,
                maxDistance: 250.0,
                speed: 20.0,
                child: Container(
                  width: 30,
                  height: 30,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
