import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:telemedicine/helper/APIHelper.dart';
import 'package:telemedicine/helper/contentCreator.dart';

import 'models/data.dart';

class ProfilePage extends StatefulWidget {
  final UserProfile userProfile = Register.userProfile;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // List with months
  var months = ["January", "February", "March",
                "April",   "May",      "June",
                "July",    "August",   "September",
                "October", "November", "December"];

  // Refract birthday
  String _refractBirthday(String birthday) {
    // Default format of birthday is yyyy-MM-ddThh:mm:ss
    // Split birthday by T that indicate time
    // And i
    var splitedBirthday = birthday.split("T").elementAt(0);
    // Split by '-' and extract year, month and day
    var birthNumFormat = splitedBirthday.split("-");
    // Build new format
    var newFormat = birthNumFormat[2] + " " + months[int.parse(birthNumFormat[1]) + 1] + 
                                        " " + birthNumFormat[0];

    return newFormat;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        SizedBox(height: 12,),
        Center(
            child: DottedBorder(
                color: Colors.black12,
                borderType: BorderType.Circle,
                dashPattern: [7],
                child: Container(
                  height: 155,
                  width: 155,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.cover,
                        image: MemoryImage(
                            base64Decode(widget.userProfile.base64Photo)),
                      )),
                ))),
        SizedBox(
          height: 45,
        ),
        createTextContainer(context, "Full Name", defaultTextStyle),
        SizedBox(
          height: 8,
        ),
        createTextContainer(context, "\t\t" + "${Register.userProfile.fullName}",
            TextStyle(color: Colors.grey, fontSize: 16, letterSpacing: 0.8)),
        SizedBox(
          height: 32,
        ),
        createTextContainer(context, "Birthday", defaultTextStyle),
        SizedBox(
          height: 8,
        ),
        createTextContainer(context, "\t\t" + _refractBirthday("${Register.userProfile.birthday}"),
            TextStyle(color: Colors.grey, fontSize: 18, letterSpacing: 0.8)),
        SizedBox(
          height: 32,
        ),
        createTextContainer(context, "Username", defaultTextStyle),
        SizedBox(
          height: 8,
        ),
        createTextContainer(context, "\t\t" + "${Register.userProfile.username}",
            TextStyle(color: Colors.grey, fontSize: 18, letterSpacing: 0.8)),
        SizedBox(
          height: 32,
        ),
        createTextContainer(context, "Email", defaultTextStyle),
        SizedBox(
          height: 8,
        ),
        createTextContainer(context, "\t\t" + "${Register.userProfile.email}",
            TextStyle(color: Colors.grey, fontSize: 18, letterSpacing: 0.8)),
        SizedBox(
          height: 32,
        ),
        createTextContainer(context, "Phone Number", defaultTextStyle),
        SizedBox(
          height: 8,
        ),
        createTextContainer(context, "\t\t" + "${Register.userProfile.phone}",
            TextStyle(color: Colors.grey, fontSize: 16, letterSpacing: 0.8)),
        SizedBox(
          height: 32,
        ),
        createTextContainer(context, "Location", defaultTextStyle),
        SizedBox(
          height: 8,
        ),
        createTextContainer(context, "\t\t" + "${Register.userProfile.address}",
            TextStyle(color: Colors.grey, fontSize: 16, letterSpacing: 0.8)),
        SizedBox(height: 8,)
      ],
    ));
  }
}
