import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:telemedicine/welcome.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover)),
        child: SplashPageState(),
      ),
      backgroundColor: Color(0xff07DA5F),
    );
  }
}

class SplashPageState extends StatefulWidget {
  @override
  _SplashPageStateState createState() => _SplashPageStateState();
}

class _SplashPageStateState extends State<SplashPageState> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Animator(
        duration: Duration(seconds: 3),
        cycles: 2,
        builder: (anim) => FadeTransition(
          opacity: anim,
          child: Text(
            "Telemedicine",
            style: TextStyle(
                fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        endAnimationListener: (anim) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => WelcomeScreen()));
        },
      ),
    );
  }
}
