import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:hexagon/hexagon.dart';
import 'package:si_entific/asteroid.dart';
import 'package:si_entific/constants.dart';
import 'game_screen.dart';
import 'rotator.dart';
import 'pulser.dart';

void main() async {
  // await Hive.initFlutter();
  // await Hive.openBox('generalBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'SI-entific',

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 8, 145, 127)),
        useMaterial3: true,
        textTheme: josefinSansTextTheme,
      ),
      home: const MyHomePage(title: 'SI-entific'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool gameStarted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mediumTeal,
      // appBar: AppBar(
      //   backgroundColor: darkTeal,
      //   title: Text(widget.title),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'SI-ENTIFIC',
              style: TextStyle(color: white, fontSize: 70),
            ),
          ),
          Stack(
            children: [
              //Asteroid 1
              const Stack(
                children: [
                  SpinnyAsteroid(50.0, 2.0, color1, 's', 50.0, true, Duration(seconds: 5)), // Set the initial X-position and falling speed
                  SpinnyAsteroid(100.0, 1.5, color2, 'm', 40.0, false, Duration(seconds: 7)),
                  SpinnyAsteroid(150.0, 2.5, color3, 'kg', 60.0, true, Duration(seconds: 4)),
                  SpinnyAsteroid(200.0, 1.0, color4, 'A', 45.0, false, Duration(seconds: 8)),
                  SpinnyAsteroid(250.0, 2.0, color5, 'K', 55.0, true, Duration(seconds: 3)),
                  SpinnyAsteroid(150.0, 2.5, color3, 'mol', 60.0, false, Duration(seconds: 5)),
                  SpinnyAsteroid(200.0, 1.0, color4, 'cd', 45.0, true, Duration(seconds: 4)),
                ],
              ),

              //HEX AND TITLE
              Stack(
                alignment: Alignment.center,
                children: [
                  HexagonWidget.pointy(
                    height: 300,
                    color: const Color.fromARGB(0, 152, 212, 187),
                    elevation: 0,
                  ),
                  const LogoRotate(
                    duration: Duration(seconds: 7),
                    clockwise: true,
                    child: RotatingPulser(
                      minSize: 200,
                      maxSize: 250,
                      color: Color.fromARGB(50, 152, 212, 187),
                      duration: Duration(seconds: 4),
                    ),
                  ),
                  const LogoRotate(
                    duration: Duration(seconds: 7),
                    clockwise: false,
                    child: RotatingPulser(
                      minSize: 250,
                      maxSize: 200,
                      color: Color.fromARGB(50, 152, 212, 187),
                      duration: Duration(seconds: 4),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        gameStarted = true;
                      });

                      // Navigate to the game screen
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const GameScreen(),
                        ),
                      );
                    },
                    child: HexagonWidget.pointy(
                      width: 200,
                      color: const Color.fromARGB(0, 152, 212, 187),
                      elevation: 0,
                      child: const Text(
                        'PLAY',
                        style: TextStyle(color: white, fontSize: 40),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
