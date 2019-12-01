import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:telemedicine/helper/APIHelper.dart';
import 'package:telemedicine/helper/validation.dart';
import 'dart:convert';

import 'package:telemedicine/login.dart';

import 'helper/contentCreator.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Register",
        ),
        backgroundColor: greenColor,
      ),
      body: SingleChildScrollView(child: SignUpPageState()),
    );
  }
}

class SignUpPageState extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPageState> {
  // Data colected for registration
  var regData = new List(7);
  /*  // (0) Full Name
                                // (1) Birthday
                                // (2) Email
                                // (3) Phone Number
                                // (4) Location/Adress
                          */

  // Focuses for every text form field
  final List<FocusNode> _fNodes =
      new List<FocusNode>.generate(7, (_) => new FocusNode());

  // Global key for form
  final _key = GlobalKey<FormState>();
  // Variable to validate form
  bool _validate = false;
  bool _validateImage = false;

  // Validate obscure text for password field
  bool _obscureText = true;

  // Get image route
  File _image;
  String image64;

  // Get image from gallery
  Future getImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 200,
        maxWidth: 200);

    if (image != null) {
      // Read image as bytes
      var imageBytes = await image.readAsBytes();

      setState(() {
        _image = image;
        _validateImage = false;
        // Encode bytes in string
        image64 = base64Encode(imageBytes);
      });
    }
  }

  // Url for API to register
  String url = "http://81.180.72.17/api/Register/UserReg";

  // Build default text style
  TextStyle defaultTextStyle = TextStyle(
          fontSize: 17, letterSpacing: 0.85, fontWeight: FontWeight.bold);

  // Create container with text field
  Widget _createInputContainer(String hint,
      Function validateContent, int _maxLength, int index) {
    return Container(
      margin: EdgeInsets.only(left: 21, right: 21, top: 22),
      child: TextFormField(
        focusNode: _fNodes[index],
        validator: validateContent,
        maxLength: _maxLength,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 22, top: 20, bottom: 18),
          hintText: hint,
          counterText: '',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onSaved: (str) {
          regData[index] = str;
        },
        onFieldSubmitted: (str) {
          FocusScope.of(context).requestFocus(_fNodes[index + 1]);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 60),
        Center(
            child: new GestureDetector(
          onTap: () {
            getImage();
          },
          child: DottedBorder(
            color: Colors.black12,
            borderType: BorderType.Circle,
            dashPattern: [7],
            child: _image != null
                ? Container(
                    height: 155,
                    width: 155,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: new FileImage(_image),
                        )),
                  )
                : Container(
                    width: 155,
                    height: 155,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 9,
                        ),
                        CircleAvatar(
                            radius: 46,
                            backgroundColor: Colors.transparent,
                            child: Icon(
                              Icons.person,
                              size: 86,
                              color: Color(0xff8fa4ae),
                            )),
                        const Text(
                          "ADD PHOTOS",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff8fa4ae)),
                        ),
                      ],
                    )),
          ),
        )),

        // Validate image
        _validateImage == true
            ? Text(
                "Image can't be empty",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              )
            : const SizedBox(
                height: 12,
              ),

        // Form with fields for regiter
        Form(
            key: _key,
            autovalidate: _validate,
            child: Column(
              children: <Widget>[
                createTextContainer(context, "Full Name", defaultTextStyle),
                _createInputContainer(
                    "Your Full Name", validateFullName, 30, 0),
                const SizedBox(
                  height: 35,
                ),
                createTextContainer(context, "Birthday", defaultTextStyle),
                _createInputContainer(
                    "yyyy/mm/dd", validateBirthday, 10, 1),
                const SizedBox(
                  height: 35,
                ),
                createTextContainer(context, "Email", defaultTextStyle),
                _createInputContainer(
                    "Your Email", validateEmail, 30, 2),
                const SizedBox(
                  height: 35,
                ),
                createTextContainer(context, "Phone Number", defaultTextStyle),
                _createInputContainer("Your Phone Number",
                    validateMobile, 30, 3),
                const SizedBox(
                  height: 35,
                ),
                createTextContainer(context, "Username", defaultTextStyle),
                _createInputContainer(
                    "Your username", validateUsername, 30, 4),
                const SizedBox(
                  height: 35,
                ),
                createTextContainer(context, "Password", defaultTextStyle),
                Container(
                  margin: EdgeInsets.only(left: 21, right: 21, top: 22),
                  child: TextFormField(
                    focusNode: _fNodes[5],
                    obscureText: _obscureText,
                    validator: validatePassword,
                    maxLength: 30,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      counterText: '',              
                      suffixIcon: GestureDetector(
                        dragStartBehavior: DragStartBehavior.down,
                        onTap: () {
                          setState(() => _obscureText = !_obscureText);
                        },
                        child: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          semanticLabel:
                              _obscureText ? 'show passward' : 'hide password',
                          color: Colors.grey,
                        ),
                      ),
                      contentPadding:
                          EdgeInsets.only(left: 22, top: 20, bottom: 18),
                      hintText: "Your Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onSaved: (str) {
                      regData[5] = str;
                    },
                    onFieldSubmitted: (str) {
                      FocusScope.of(context).requestFocus(_fNodes[6]);
                    },
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                createTextContainer(context, "Location/Adress", defaultTextStyle),
                _createInputContainer(
                    "Your Location", validateLocation, 30, 6),
                const SizedBox(
                  height: 35,
                ),
              ],
            )),

        // Register button
        Container(
          padding: EdgeInsets.only(left: 28, right: 28),
          child: RaisedButton(
            shape: new RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
                side: BorderSide(color: Color(0xff07DA5F))),
            onPressed: () {
              if (_key.currentState.validate() && _validateImage == false) {
                _key.currentState.save();

                fetchRegPost(context, url, regData, image64).then((response) {
                  if (response.status == "SUCCESS") {
                    buildSnackBar(context, "Created successfully",
                        "After 4 seconds you will be redirect to login page.");
                    Future.delayed(const Duration(seconds: 4), () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    });
                  } else if (response.status != null && response.status != null)
                    buildSnackBar(context, response.status, response.message);
                });
              } else {
                setState(() => _validate = true);
              }
            },
            textColor: Colors.white,
            color: Color(0xff07DA5F),
            child: Container(
              padding: EdgeInsets.only(left: 22, right: 22),
              height: 55,
              child: Center(
                  child: Text(
                "Next",
                style: TextStyle(
                    fontSize: 17,
                    letterSpacing: 0.85,
                    fontWeight: FontWeight.bold),
              )),
            ),
          ),
        ),
        SizedBox(height: 40),
      ],
    );
  }
}
