import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:hexagon/hexagon.dart';
import 'package:si_entific/constants.dart';
import 'game_screen.dart';

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
        textTheme: nunitoTextTheme,
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          const AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            top: 75, //!gameStarted ? 75 : -MediaQuery.of(context).size.height * 0.1,
            left: 0,
            right: 0,
            child: Center(
              child: Text('SI-entific'),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            top: 180, //!gameStarted ? 180 : -MediaQuery.of(context).size.height * 0.1,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
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
                  width: 100,
                  color: const Color.fromARGB(255, 54, 244, 54),
                  elevation: 8,
                  child: const Text('PLAY'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
