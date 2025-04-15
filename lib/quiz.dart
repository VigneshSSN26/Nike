// 4️⃣ Quiz App with Timer
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

# dependencies:
#   url_launcher: ^6.0.10             # Used to launch URLs in the device browser or apps
#   web_socket_channel: ^2.4.0        # For real-time communication using WebSockets
#   lottie: ^2.6.0                    # For beautiful Lottie animations in Flutter
#   video_player: ^2.7.0              # To play videos from assets, files or the internet
#   google_fonts: ^4.0.4              # Easily use Google Fonts in your Flutter app
#   http: ^0.13.6                     # Used for making HTTP requests
#   shared_preferences: ^2.2.2        # To store key-value pairs persistently
#   fl_chart: ^0.64.0                 # For rendering attractive charts like bar, line, pie, etc.
#   google_maps_flutter: ^2.1.1      # Embeds Google Maps widget in Flutter apps
#   geolocator: ^9.0.1                # Handles location-related functionality like GPS
#   google_places_flutter: ^2.1.0    # Autocomplete places widget using Google Places API
#   intl: ^0.18.1                     # For internationalization and date/time formatting
#   timezone: ^0.9.0                  # Handle and manipulate time zones in Dart
#   image_picker: ^1.0.4              # For picking images from gallery or camera


class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Map<String, dynamic>> _questions = [
    {
      "question": "What is the capital of France?",
      "options": ["Berlin", "Madrid", "Paris", "Lisbonhttp: ^0.13.6"],
      "answer": "Paris"
    },
    {
      "question": "Which planet is known as the Red Planet?",
      "options": ["Earth", "Mars", "Jupiter", "Saturn'dependencies"],
      "answer": "Mars"
    },
    {
      "question": "What is 2 + 2?",
      "options": ["3", "4", "5", "6 image_picker ^1.0.7"],
      "answer": "4"
    }
  ];

  int _currentQuestionIndex = 0;
  int _score = 0;
  int _timer = 10;
  late Timer _questionTimer;
  bool _answered = false;

  void _startTimer() {
    _timer = 10;
    _questionTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timer > 0) {
        setState(() {
          _timer--;
        });
      } else {
        _nextQuestion();
      }
    });
  }

  void _nextQuestion() {
    _questionTimer.cancel();
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        _answered = false;
        _startTimer();
      } else {
        _showScore();
      }
    });
  }

  void _checkAnswer(String selectedOption) {
    if (!_answered) {
      _questionTimer.cancel();
      setState(() {
        _answered = true;
        if (selectedOption == _questions[_currentQuestionIndex]['answer']) {
          _score++;
        }
        Future.delayed(Duration(seconds: 2), _nextQuestion);
      });
    }
  }

  void _showScore() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Quiz Completed"),
        content: Text("Your score: $_score/${_questions.length}"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _currentQuestionIndex = 0;
                _score = 0;
                _answered = false;
                _startTimer();
              });
            },
            child: Text("Restart"),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _questionTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quiz App")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Time Left: $_timer s",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            SizedBox(height: 20),
            Text(
              _questions[_currentQuestionIndex]['question'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ..._questions[_currentQuestionIndex]['options'].map((option) {
              return ElevatedButton(
                onPressed: () => _checkAnswer(option),
                child: Text(option, style: TextStyle(fontSize: 20)),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

// Next: Image Gallery App

