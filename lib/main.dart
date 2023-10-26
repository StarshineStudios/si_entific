import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:hexagon/hexagon.dart';
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
              AnimatedPositioned(
                duration: const Duration(seconds: 10),
                child: LogoRotate(
                  duration: const Duration(seconds: 7),
                  clockwise: true,
                  child: HexagonWidget.pointy(
                    width: 200,
                    color: const Color.fromARGB(255, 117, 219, 0),
                    elevation: 0,
                    child: const Text(
                      'N',
                      style: TextStyle(color: white, fontSize: 40),
                    ),
                  ),
                ),
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
