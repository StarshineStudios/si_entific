// import 'package:flutter/material.dart';

// class LogoRotate extends StatefulWidget {
//   final Widget child;

//   const LogoRotate({
//     Key? key,
//     required this.child,
//   }) : super(key: key);

//   @override
//   State<LogoRotate> createState() => LogoRotateState();
// }

// class LogoRotateState extends State<LogoRotate> {
//   double turns = 0.0;

//   void _changeRotation() {
//     setState(() => turns += 1.0 / 8.0);
//   }

//   @override
//   Widget build(BuildContext context) {

//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         ElevatedButton(
//           onPressed: _changeRotation,
//           child: const Text('Rotate Logo'),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(50),
//           child: AnimatedRotation(
//             turns: turns,
//             duration: const Duration(seconds: 1),
//             child: widget.child,
//           ),
//         ),
//       ],
//     );
//   }
// }

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Rotate Square'),
//         ),
//         body: LogoRotate(
//           child: const FlutterLogo(size: 150), // Example child
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';

import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Rotate Square'),
        ),
        body: const LogoRotate(
          duration: Duration(seconds: 3), // Example child
          clockwise: true,
          child: FlutterLogo(size: 150),
        ),
      ),
    );
  }
}

class LogoRotate extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final bool clockwise;
  const LogoRotate({
    Key? key,
    required this.child,
    required this.duration,
    required this.clockwise,
  }) : super(key: key);

  @override
  State<LogoRotate> createState() => LogoRotateState();
}

class LogoRotateState extends State<LogoRotate> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration, // Adjust the duration as needed
    )..repeat(); // Make the animation repeat
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AnimatedRotation(
          controller: _controller,
          clockwise: widget.clockwise,
          child: widget.child,
        ),
      ],
    );
  }
}

class AnimatedRotation extends StatelessWidget {
  final AnimationController controller;
  final Widget child;
  final bool clockwise;
  const AnimatedRotation({
    super.key,
    required this.controller,
    required this.child,
    required this.clockwise,
  });

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: clockwise ? Tween(begin: 0.0, end: 1.0).animate(controller) : Tween(begin: 1.0, end: 0.0).animate(controller),
      child: child,
    );
  }
}
