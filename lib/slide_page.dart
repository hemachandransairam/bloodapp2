import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'blood_app.dart';

class SlidePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: "Save Lives",
            body: "Your blood donation can save multiple lives.",
            image: Center(child: Image.asset("assets/slide1.png", height: 250)),
          ),
          PageViewModel(
            title: "Be a Hero",
            body: "Donating blood is a noble cause.",
            image: Center(child: Image.asset("assets/slide2.png", height: 250)),
          ),
          PageViewModel(
            title: "Join Us",
            body: "Become a regular donor and make a difference.",
            image: Center(child: Image.asset("assets/slide3.png", height: 250)),
          ),
        ],
        onDone: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BloodApp()),
          );
        },
        showSkipButton: true,
        skip: Text("Skip"),
        next: Icon(Icons.arrow_forward),
        done: Text("Done", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
