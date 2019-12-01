import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:telemedicine/bottomNavBar.dart';
import 'package:telemedicine/signup.dart';
import 'package:telemedicine/helper/validation.dart';

import 'models/data.dart';
import 'helper/APIHelper.dart';
import 'helper/contentCreator.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 125,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Telemedicine",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 36,
                        letterSpacing: 1.6,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 110,
                ),
                LoginPageState(),
                SizedBox(
                  height: 20,
                ),
                FlatButton(
                  child: Text(
                    "SIGNUP",
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                )
              ],
            ),
          )),
      backgroundColor: Color(0xff07DA5F),
    );
  }
}

class LoginPageState extends StatefulWidget {
  @override
  _LoginPageStateState createState() => _LoginPageStateState();
}

class _LoginPageStateState extends State<LoginPageState> {
  // Login data
  String email;
  String password;

  // Focus for changing email with password field
  final FocusNode currFocus = new FocusNode();

  // Validation form
  final _key = GlobalKey<FormState>();
  bool _validate = false;

  bool _obscureText = true;

  // Url to login
  String url = "http://81.180.72.17/api/Login/UserAuth";

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _key,
        autovalidate: _validate,
        child: Column(
          children: <Widget>[
            // Email field
            Container(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 7),
                child: TextFormField(
                  validator: validateEmail,
                  style: TextStyle(color: Colors.white),
                  maxLength: 30,
                  decoration: InputDecoration(
                    counterText: '',
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: Colors.white,
                    ),
                    labelText: 'Email Adress',
                    labelStyle: TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  onSaved: (str) {
                    email = str;
                  },
                  onFieldSubmitted: (str) {
                    FocusScope.of(context).requestFocus(currFocus);
                  },
                )),
            SizedBox(
              height: 36,
            ),

            // Password field
            Container(
                padding: EdgeInsets.fromLTRB(30, 7, 30, 50),
                child: TextFormField(
                  focusNode: currFocus,
                  obscureText: _obscureText,
                  validator: validatePassword,
                  style: TextStyle(color: Colors.white),
                  maxLength: 30,
                  decoration: InputDecoration(
                    counterText: '',
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Colors.white,
                    ),
                    suffixIcon: GestureDetector(
                      dragStartBehavior: DragStartBehavior.down,
                      onTap: () {
                        setState(() => _obscureText = !_obscureText);
                      },
                      child: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        semanticLabel:
                            _obscureText ? 'show passward' : 'hide password',
                        color: Colors.white,
                      ),
                    ),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  onSaved: (str) {
                    password = str;
                  },
                  onFieldSubmitted: (str) {
                    password = str;
                  },
                )),
            // Login button
            Container(
              padding: EdgeInsets.only(left: 22, right: 22),
              child: RaisedButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.white)),
                onPressed: () async {
                  if (_key.currentState.validate()) {
                    _key.currentState.save();

                    // Send post
                    fetchloginPost(context, url, email, password)
                        .then((response) {
                      // If status from API is SUCCESS
                      // Go to Bottom Navigate Bar
                      if (response.status == "SUCCESS") {
                        // Stock token to Register
                        Register.token = response.message;
                        // Go to Bottom Navigation Bar
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BottomNavBar(namePage: "Home",)));
                      } else if (response.status != null &&
                          response.status != null)
                        buildSnackBar(
                            context, response.status, response.message);
                    });
                  } else {
                    setState(() {
                      _validate = true;
                    });
                  }
                },
                textColor: Colors.green,
                color: Colors.white,
                child: Container(
                  height: 55,
                  child: Center(
                      child: Text(
                    "Login",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ),
          ],
        ));
  }
}
