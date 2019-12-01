import 'package:flutter/material.dart';
import 'package:telemedicine/login.dart';
import 'package:telemedicine/signup.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover)),
        child: Center(
            child: Column(
          children: <Widget>[
            SizedBox(height: 165),
            Text(
              "Welcome",
              style: TextStyle(fontSize: 36, color: Colors.white),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              width: 283,
              child: Text(
                "   Lorem ipsum dolor sit amet, conse ctetur adipiscing elit, t. Ut enim ad veni am, quis nostrud exercitation ullamco ",
                style: TextStyle(
                    color: Colors.white, height: 1.5, letterSpacing: 1),
              ),
            ),
            SizedBox(height: 80),
            RaisedButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(color: Colors.white)),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpPage()));
              },
              textColor: Colors.green,
              color: Colors.white,
              child: Container(
                width: 280,
                height: 55,
                child: Center(
                    child: Text(
                  "Sign Up",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
              ),
            ),
            SizedBox(height: 40),
            FlatButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(color: Colors.white)),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              textColor: Colors.green,
              color: Colors.transparent,
              child: Container(
                width: 280,
                height: 55,
                child: Center(
                    child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
            SizedBox(
              height: 45,
            ),
            Text(
              "URGENT",
              style: TextStyle(fontSize: 17, color: Colors.white),
            ),
          ],
        )),
      ),
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xff07DA5F),
    );
  }
}
