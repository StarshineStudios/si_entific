import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';


class RotatingPulser extends StatefulWidget {
  final double minSize;
  final double maxSize;
  final Duration duration;
  final Color color;

  const RotatingPulser({super.key, 
    required this.minSize,
    required this.maxSize,
    required this.duration,
    required this.color,
  });

  @override
  _RotatingPulserState createState() => _RotatingPulserState();
}

class _RotatingPulserState extends State<RotatingPulser> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    // Create a curved animation
    final curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Adjust the curve as needed
    );

    // Tween for the size animation
    final sizeTween = Tween<double>(
      begin: widget.minSize,
      end: widget.maxSize,
    );

    // Create the size animation
    _animation = sizeTween.animate(curvedAnimation);

    // Set up listener to reverse the animation and repeat
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });

    // Start the animation
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return HexagonWidget.pointy(
          width: _animation.value,
          color: widget.color,
          elevation: 0,
        );

        // Container(
        //   width: _animation.value,
        //   height: _animation.value,
        //   color: widget.color,
        // );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Rotating Pulser Example'),
      ),
      body: const Center(
        child: RotatingPulser(
          minSize: 50.0,
          maxSize: 100.0,
          duration: Duration(seconds: 2),
          color: Colors.blue,
        ),
      ),
    ),
  ));
}
