import 'package:flutter/material.dart';
import 'package:telemedicine/bottomNavBar.dart';
import 'package:telemedicine/helper/APIHelper.dart';
import 'package:telemedicine/helper/validation.dart';

import 'models/data.dart';
import 'helper/contentCreator.dart';

class HomeScreenState extends StatefulWidget {
  HomeScreenState({Key key}) : super(key: key);

  @override
  _HomeScreenStateState createState() => _HomeScreenStateState();
}

class _HomeScreenStateState extends State<HomeScreenState> {
  // Data to stock data from every field
  var homeData = new List(4);
  /*  
                                // (0) Name
                                // (1) Desease
                                // (2) Location
                                // (3) Description
                              */
  // List of focuses for every field
  final List<FocusNode> _fNodes =
      new List<FocusNode>.generate(4, (_) => new FocusNode());

  // Global key for form
  final _key = GlobalKey<FormState>();
  // Variable to validate form
  bool _validate = false;

  // List with profiles of each doctor
  var doctorList = List<DoctorProfile>();
  var userProfile = UserProfile();

  // Url to API
  String urlDocList = "http://81.180.72.17/api/Doctor/GetDoctorList";
  String urlUserProfile = "http://81.180.72.17/api/Profile/GetProfile";

  // Default text style for TextContainer
  TextStyle defaultTextStyle =
      TextStyle(fontSize: 17, letterSpacing: 0.85, fontWeight: FontWeight.bold);

  // Init state and get request
  @override
  void initState() {
    super.initState();
    // Get doctor list from API
    getDoctorList(context, urlDocList, Register.token).then((list) {
      doctorList = list.map((model) => DoctorProfile.fromJson(model)).toList();
    });
    // Get data about user
    getProfile(context, urlUserProfile, Register.token).then((profile) {
      Register.userProfile = profile;
    });
  }

  // Create input fields
  Widget _createInputContainer(
      String hint, Function validateContent, int _maxLength, int index) {
    return Container(
      margin: EdgeInsets.only(left: 21, right: 21, top: 22),
      child: TextFormField(
        focusNode: index >= 0 ? _fNodes[index] : null,
        validator: validateContent,
        maxLength: _maxLength,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 22, top: 20, bottom: 18),
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            counterText: ''),
        onChanged: (str) {
          setState(() {
            homeData[index + 1] = str;
          });
        },
        onSaved: (str) => homeData[index + 1] = str,
        onEditingComplete: () =>
            FocusScope.of(context).requestFocus(_fNodes[index + 1]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
      key: _key,
      autovalidate: _validate,
      child: Column(
        children: <Widget>[
          buttonCreator("VERY URGENT", Colors.white, greenColor, greenColor,
              EdgeInsets.only(right: 85, left: 85, top: 48, bottom: 49), () {}),
          createTextContainer(context, "Name", defaultTextStyle),
          _createInputContainer("Your Name", validateName, 30, -1),
          SizedBox(
            height: 35,
          ),
          createTextContainer(context, "Desease", defaultTextStyle),
          _createInputContainer("What is your illness", validateDesease, 30, 0),
          SizedBox(
            height: 35,
          ),
          createTextContainer(context, "Location", defaultTextStyle),
          _createInputContainer("Where your location", validateLocation, 30, 1),
          SizedBox(
            height: 35,
          ),
          createTextContainer(
              context, "Description (Optional)", defaultTextStyle),
          Container(
            margin: EdgeInsets.only(left: 21, right: 21, top: 22),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black12)),
            child: TextFormField(
              focusNode: _fNodes[2],
              maxLength: 90,
              keyboardType: TextInputType.multiline,
              minLines: 3,
              maxLines: null,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  counterText: '',
                  contentPadding:
                      EdgeInsets.only(left: 22, top: 20, bottom: 18),
                  hintText: "Describe Here",
                  border: InputBorder.none),
              onSaved: (str) {
                homeData[3] = str;
              },
            ),
          ),
          SizedBox(
            height: 35,
          ),
          buttonCreator("Request", greenColor, Colors.white, greenColor,
              EdgeInsets.only(left: 25, right: 25), () {
            if (_key.currentState.validate()) {
              _key.currentState.save();
              // If we don't have response to request on initState()
              // Try doing it again
              if (doctorList == null)
                getDoctorList(context, urlDocList, Register.token).then((list) {
                  doctorList = list
                      .map((model) => DoctorProfile.fromJson(model))
                      .toList();
                });
              // Is list of doctors isn't null,
              // go to Doctor List Page
              else {
                // Stock fields to Register
                Register.doctorList = doctorList;
                Register.homeData = homeData;

                // Go to Bottom Navigation Bar
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BottomNavBar(
                              namePage: "Doctor List",
                            )));
              }
            } else {
              setState(() => _validate = true);
            }
          }),
          SizedBox(
            height: 30,
          )
        ],
      ),
    ));
  }
}
