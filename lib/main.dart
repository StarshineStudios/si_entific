import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:hexagon/hexagon.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:si_entific/asteroid.dart';
import 'package:si_entific/constants.dart';
import 'package:si_entific/extra_screens.dart';
import 'game_screen.dart';
import 'rotator.dart';
import 'pulser.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('generalBox');
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
    final double screenWidth = MediaQuery.of(context).size.width;
    return ValueListenableBuilder(
      valueListenable: Hive.box('generalBox').listenable(),
      builder: (context, box, widget) {
        int highscore = box.get('highscore', defaultValue: 0);
        return Scaffold(
          backgroundColor: mediumTeal,
          // appBar: AppBar(
          //   backgroundColor: darkTeal,
          //   title: Text(widget.title),
          // ),
          body: Stack(
            children: [
              //Asteroid 1

              SpinnyAsteroid(50.0, 4 / 3, color1, 's', 60.0, true, const Duration(seconds: 5), screenWidth), // Set the initial X-position and falling speed
              SpinnyAsteroid(100.0, 3 / 3, color2, 'm', 70.0, false, const Duration(seconds: 7), screenWidth),
              SpinnyAsteroid(150.0, 5 / 3, color3, 'kg', 70.0, true, const Duration(seconds: 4), screenWidth),
              SpinnyAsteroid(200.0, 7 / 3, color4, 'A', 65.0, false, const Duration(seconds: 8), screenWidth),
              SpinnyAsteroid(250.0, 3.4 / 3, color5, 'K', 65.0, true, const Duration(seconds: 3), screenWidth),
              SpinnyAsteroid(150.0, 2.5 / 3, color3, 'mol', 90.0, false, const Duration(seconds: 5), screenWidth),
              SpinnyAsteroid(200.0, 4.0 / 3, color4, 'cd', 85.0, true, const Duration(seconds: 4), screenWidth),

              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [mediumTeal, mediumTealTransp, Transp, Transp, mediumTealTransp, mediumTeal],
                    //stops: [0.25, 0.4, 0.6, 0.75],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
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
                  Positioned(
                    top: 100,
                    child: Center(
                      child: Text(
                        'SI-ENTIFIC',
                        style: TextStyle(color: white, fontSize: 70),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 130,
                    child: Center(
                      child: Text(
                        'HIGHSCORE: $highscore',
                        style: TextStyle(color: white, fontSize: 30),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    right: 30,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SettingsScreen(),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.settings,
                        size: 60,
                        color: white,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    left: 30,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const InfoScreen(),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.info,
                        size: 60,
                        color: white,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
