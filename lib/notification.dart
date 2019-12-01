import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:telemedicine/bottomNavBar.dart';
import 'package:telemedicine/helper/contentCreator.dart';
import 'package:telemedicine/helper/APIHelper.dart';

import 'models/data.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key key}) : super(key: key);

  // Extract doctor from Data class
  final DoctorProfile doctor = Register.doctor;

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  // Url to API
  String url = "http://81.180.72.17/api/Doctor/AddConsultation";

  _buildlistTile() {
    return Container(
      margin: EdgeInsets.only(top: 28, bottom: 57, left: 27, right: 27),
      decoration:
          BoxDecoration(border: Border.all(width: 2, color: Color(0xffeceff1))),
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 20, top: 16, bottom: 16),
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: MemoryImage(base64Decode(widget.doctor.photo)),
          backgroundColor: Colors.grey,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "${widget.doctor.fullName}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  letterSpacing: 0.85),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "${widget.doctor.speciality}",
              style: TextStyle(
                  color: greenColor,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 0.8,
                  fontSize: 16),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: <Widget>[
                RatingBarIndicator(
                  rating: widget.doctor.stars,
                  itemBuilder: (context, index) =>
                      Icon(Icons.star, color: Colors.yellow[600]),
                  itemCount: 5,
                  itemSize: 20,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "${widget.doctor.stars}",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _builPageWithNotification() {
    return SingleChildScrollView(
        child: Center(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 45,
          ),
          Container(
            height: 145,
            width: 145,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/bg.png")),
            ),
            child: Image.asset(
              "assets/images/icon_check.png",
              scale: 2,
            ),
          ),
          SizedBox(
            height: 47,
          ),
          Text(
            "Your Request Has Been",
            style: TextStyle(
                fontSize: 19, fontWeight: FontWeight.bold, letterSpacing: 0.85),
          ),
          Text(
            "Approved",
            style: TextStyle(
                fontSize: 19, fontWeight: FontWeight.bold, letterSpacing: 0.85),
          ),
          SizedBox(
            height: 46,
          ),
          Container(
              padding: EdgeInsets.only(left: 39, right: 39),
              child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, t. Ut enim ad minim venia m, quis nostrud exercitation ullamco",
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    letterSpacing: 0.70,
                    color: Colors.grey,
                  ))),
          SizedBox(
            height: 70,
          ),
          Container(
            padding: EdgeInsets.only(left: 21),
            width: MediaQuery.of(context).size.width,
            child: Text(
              "Request Details",
              style: TextStyle(
                  fontSize: 19,
                  letterSpacing: 0.85,
                  fontWeight: FontWeight.bold,
                  color: greenColor),
            ),
          ),
          SizedBox(
            height: 45,
          ),
          createTextContainer(context, "Name", defaultTextStyle),
          SizedBox(
            height: 8,
          ),
          createTextContainer(context, "${Register.homeData[0]}",
              TextStyle(color: Colors.grey, fontSize: 18, letterSpacing: 0.8)),
          SizedBox(
            height: 32,
          ),
          createTextContainer(context, "Desease", defaultTextStyle),
          SizedBox(
            height: 8,
          ),
          createTextContainer(context, "${Register.homeData[1]}",
              TextStyle(color: Colors.grey, fontSize: 18, letterSpacing: 0.8)),
          SizedBox(
            height: 32,
          ),
          createTextContainer(context, "Location", defaultTextStyle),
          SizedBox(
            height: 8,
          ),
          createTextContainer(context, "${Register.homeData[2]}",
              TextStyle(color: Colors.grey, fontSize: 18, letterSpacing: 0.8)),
          SizedBox(
            height: 32,
          ),
          createTextContainer(context, "Description", defaultTextStyle),
          SizedBox(
            height: 8,
          ),
          createTextContainer(context, "${Register.homeData[3]}",
              TextStyle(color: Colors.grey, fontSize: 16, letterSpacing: 0.8)),
          SizedBox(
            height: 50,
          ),
          Container(
            padding: EdgeInsets.only(left: 21),
            width: MediaQuery.of(context).size.width,
            child: Text(
              "Doctor",
              style: TextStyle(
                  fontSize: 19,
                  letterSpacing: 0.85,
                  fontWeight: FontWeight.bold,
                  color: greenColor),
            ),
          ),
          _buildlistTile(),
          buttonCreator("Confirm", greenColor, Colors.white, greenColor,
              EdgeInsets.only(left: 25, right: 25), () {
            addConsultant(context, url, Register.token, Register.homeData,
                    Register.doctor)
                .then((response) {
              // Build toast with message
              if (response != null) {
                Fluttertoast.showToast(
                    msg: "Consultant Added",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIos: 1,
                    backgroundColor: Colors.black54,
                    textColor: Colors.white,
                    fontSize: 16.0);

                // Rebuild page
                Future.delayed(Duration(seconds: 2), () {
                  // Delete doctor from register
                  Register.doctor = null;
                  // Go to bottom navigation bar
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BottomNavBar(
                                namePage: "Home",
                              )));
                });
              }
            });
          }),
          SizedBox(
            height: 36,
          ),
          buttonCreator("Cancel Request", Colors.white, Colors.grey,
              Colors.grey, EdgeInsets.only(left: 25, right: 25), () {
            // Build toast with message
            Fluttertoast.showToast(
                msg: "You Cancel Request",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                backgroundColor: Colors.grey,
                textColor: Colors.white,
                fontSize: 16.0);

            // Rebuild page
            Future.delayed(Duration(seconds: 2), () {
              // Delete doctor from register
              Register.doctor = null;
              // Go to bottom navigation bar
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BottomNavBar(
                            namePage: "Home",
                          )));
            });
          }),
          SizedBox(
            height: 30,
          )
        ],
      ),
    ));
  }

  _buildPageWithoutNotification() {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.notifications_off,
              color: Colors.grey[350],
              size: 150,
            ),
            Text(
              "No new notification",
              style: TextStyle(
                  color: Colors.grey[350],
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            )
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.doctor == null
        ? _buildPageWithoutNotification()
        : _builPageWithNotification();
  }
}
