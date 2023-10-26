import 'package:flutter/material.dart';
import 'constants.dart';
import 'main.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box('generalBox').listenable(),
      builder: (context, box, widget) {
        return Scaffold(
          backgroundColor: darkTeal,
          appBar: AppBar(
            backgroundColor: darkTeal,
            foregroundColor: white,
          ),
          body: Center(
            child: NiceButton(
              onPressed: () {
                // Show the confirmation dialog
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: mediumTeal,
                    title: const Text(
                      'Delete Saved Highscore?',
                      style: TextStyle(color: white, fontSize: 35),
                    ),
                    content: const Text(
                      'This cannot be reversed. Are you sure?',
                      style: TextStyle(color: white, fontSize: 20),
                    ),
                    actions: [
                      NiceButton(
                        color: lightTeal,
                        onPressed: () {
                          // Perform the delete action here
                          // For now, just close the dialog
                          box.delete('highscore');
                          box.delete('highscoreNew');
                          Navigator.of(context).pop();
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
                          child: Text(
                            'Yes',
                            style: TextStyle(color: white, fontSize: 20),
                          ),
                        ),
                      ),
                      NiceButton(
                        color: lightTeal,
                        onPressed: () {
                          // Close the dialog
                          Navigator.of(context).pop();
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
                          child: Text(
                            'No',
                            style: TextStyle(color: white, fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Delete Progress',
                  style: TextStyle(color: white, fontSize: 30),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box('generalBox').listenable(),
      builder: (context, box, widget) {
        return Scaffold(
            backgroundColor: darkTeal,
            appBar: AppBar(
              backgroundColor: darkTeal,
              foregroundColor: white,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: const [
                  Text(
                    'About',
                    style: TextStyle(color: white, fontSize: 40),
                  ),
                  Text(
                    'SI-entific is an educational app for learning SI Units',
                    style: TextStyle(color: white, fontSize: 20),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'How to Play',
                    style: TextStyle(color: white, fontSize: 40),
                  ),
                  Text(
                    'Tap on a hex once to select it. It will be in multiplication mode. Tap again to go into division mode. ',
                    style: TextStyle(color: white, fontSize: 20),
                  ),
                  Image(image: AssetImage('assets/info1.png')),
                  Text(
                    'While a hex is selected, tap an ajacent hex to multiply or divide it.',
                    style: TextStyle(color: white, fontSize: 20),
                  ),
                  Image(image: AssetImage('assets/info2.png')),
                  Text(
                    'Every time you make a move, a new SI base unit will spawn randomly. Use these units to make the orders above. When you are ready to submit a hex, tap on it, then tap on the order. It does not matter if you are in multiplication mode or division mode.',
                    style: TextStyle(color: white, fontSize: 20),
                  ),
                  Image(image: AssetImage('assets/info3.png')),
                  Text(
                    'Now, get ready to think SI-entifically!',
                    style: TextStyle(color: white, fontSize: 20),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Credits',
                    style: TextStyle(color: white, fontSize: 40),
                  ),
                  Text(
                    'Built by Saebyul Hong \nBased on HexSIgon by Saebyul Hong and Austin McGregor',
                    style: TextStyle(color: white, fontSize: 20),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
