import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _randomNumber = Random().nextInt(100) + 1;
  int _userGuess = 0;
  String _message = "";
  int _tries = 0;
  TextEditingController _guessController = TextEditingController();

  void _submitGuess(int guess) {
    setState(() {
      _userGuess = guess;
      _tries++;
      _message = _checkGuess(guess);
    });
    _guessController.clear();
  }

  String _checkGuess(int guess) {
    if (guess == _randomNumber) {
      return "Correct! You guessed the number in $_tries tries.";
    } else if (guess > _randomNumber) {
      return "Too high! Try again.";
    } else {
      return "Too low! Try again.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.indigo,
        hintColor: Colors.pinkAccent,
        fontFamily: 'Roboto',
        textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: 18.0, color: Colors.black87),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Number Guessing Game',
            style: TextStyle(color: Colors.white),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color.fromARGB(255, 197, 197, 201), Color.fromARGB(255, 200, 255, 250)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Guess a number between 1 and 100:",
                style: TextStyle(fontSize: 16.0),
              ),
              TextField(
                controller: _guessController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter your guess",
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white70,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onSubmitted: (value) => _submitGuess(int.parse(value)),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  _message,
                  style: TextStyle(
                    color: _message.contains("Correct")
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _userGuess == _randomNumber
                        ? Icons.check_circle
                        : _userGuess > _randomNumber
                            ? Icons.arrow_upward
                            : Icons.arrow_downward,
                    color: _userGuess == _randomNumber
                        ? Colors.green
                        : _userGuess > _randomNumber
                            ? Colors.red
                            : Colors.blue,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    "Number of tries: $_tries",
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _randomNumber = Random().nextInt(100) + 1;
                    _userGuess = 0;
                    _message = "";
                    _tries = 0;
                  });
                  _guessController.clear();
                },
                child: Text("Start New Game"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
