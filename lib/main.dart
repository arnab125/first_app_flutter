import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Board();
  }
}

class Board extends StatefulWidget {
  const Board({Key? key}) : super(key: key);

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  var leftDiceIndex = 0;
  var rightDiceIndex = 0;
  var sum = 0;
  String verdict = "";
  bool isRolling = false;
  bool published = false;
  final Random random = Random.secure();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("My First App", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.blue[900],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('images/dice-${leftDiceIndex + 1}.png', width: 100),
                  const SizedBox(width: 20),
                  Image.asset('images/dice-${rightDiceIndex + 1}.png', width: 100),
                ],
              ),
              Text("Sum = $sum", style: const TextStyle(fontSize: 30)),
              const SizedBox(height: 20),
              !published?
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: 200,
                  height: 120, // Adjust height as needed
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: published ? reset : roll,
                        child: Text(
                          published ? "Play Again" : "Roll",
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: reset,
                        child: const Text(
                          "Reset",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ):
              ElevatedButton(
                onPressed: reset,
                child: const Text(
                  "Play Again",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              )
              ,
              SizedBox(height: 20),
              if (verdict.isNotEmpty && verdict=="You Win!") 
                Text(verdict, style: const TextStyle(fontSize: 30, color: Colors.green)),
              if (verdict.isNotEmpty && verdict=="You Lose!") 
                Text(verdict, style: const TextStyle(fontSize: 30, color: Colors.red)),
              if (verdict.isEmpty)
                const SizedBox(height: 30), // Add a SizedBox with height 30 when verdict is empty
            ],
          ),
        ),
      ),
    );
  }

  void roll() {
    setState(() {
      leftDiceIndex = random.nextInt(6);
      rightDiceIndex = random.nextInt(6);
      sum = leftDiceIndex + rightDiceIndex + 2;
      if (sum == 7 || sum == 11) {
        verdict = "You Win!";
        published=true;
      } else if (sum == 2 || sum == 3 || sum == 12) {
        verdict = "You Lose!";
        published=true;
      } else {
        verdict = "";
      }
    });
  }

  void reset() {
    setState(() {
      leftDiceIndex = 0;
      rightDiceIndex = 0;
      sum = 0;
      verdict = "";
      isRolling = false;
      published=false;
    });
  }
}
