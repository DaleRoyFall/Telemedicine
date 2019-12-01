import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:telemedicine/doctorDetails.dart';
import 'package:telemedicine/doctorlist.dart';
import 'package:telemedicine/home.dart';
import 'package:telemedicine/models/data.dart';
import 'package:telemedicine/notification.dart';
import 'package:telemedicine/profile.dart';
import 'package:telemedicine/schedule.dart';

import 'helper/APIHelper.dart';
import 'helper/contentCreator.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key key, this.doctor, @required this.namePage})
      : super(key: key);

  final DoctorProfile doctor;
  // Name of the page
  final String namePage;

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  // Index of current bottom navigation item
  int _currIndex = 0;

  // Choose root from BottomNavigationBar body
  builRoot(BuildContext context, String namePage, int tabIndex) {
    if (tabIndex == 0)
      switch (namePage) {
        case "Home":
          return HomeScreenState();
          break;
        case "Doctor List":
          return DoctorListPage();
          break;

        case "Doctor Details":
          return DoctorDetailsPage(doctor: widget.doctor);
          break;
      }
    else if (tabIndex == 1)
      return NotificationPage();
    else if (tabIndex == 3)
      return SchedulePage();
    else if (tabIndex == 4) return ProfilePage();
  }

  choosePageName(String widgetName, int index) {
    switch (index) {
      case (0):
        return widgetName;
        break;
      case (1):
        return "Notification";
        break;
      case (3):
        return "Schedule";
        break;
      case (4):
        return "Profile";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: widget.namePage == "Home" ? Container() : null,
        actions: <Widget>[
          Container(
            child: Icon(Icons.more_horiz),
            padding: EdgeInsets.only(right: 28),
          )
        ],
        centerTitle: true,
        title: Text(choosePageName(widget.namePage, _currIndex)),
        backgroundColor: greenColor,
      ),
      body: builRoot(context, widget.namePage, _currIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Align(
        alignment: Alignment(0, 0.97),
        child: FloatingActionButton(
            elevation: 0,
            backgroundColor: greenColor,
            child: Icon(
              Icons.add,
            ),
            onPressed: () {
              if (widget.namePage != "Home" || _currIndex != 0)
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BottomNavBar(
                              namePage: "Home",
                            )));
            }),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 20,
          currentIndex: _currIndex,
          selectedItemColor: greenColor,
          selectedFontSize: 12,
          onTap: (index) {
            setState(() {
              _currIndex = index;
            });
          },
          items: <BottomNavigationBarItem>[
            // Home item
            BottomNavigationBarItem(
                icon: Image.asset("assets/images/home.png", scale: 4),
                activeIcon: Image.asset(
                  "assets/images/home.png",
                  scale: 4,
                  color: greenColor,
                ),
                title: Text("Home")),
            // Notification item
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  Register.doctor == null
                      ? "assets/images/noNotification.svg"
                      : "assets/images/newNotification.svg",
                  width: 30,
                ),
                activeIcon: SvgPicture.asset(
                  Register.doctor == null
                      ? "assets/images/noNotification.svg"
                      : "assets/images/activeNewNotification.svg",
                  width: 30,
                  color: Register.doctor == null ? greenColor : null,
                ),
                title: Text("Notification")),
            BottomNavigationBarItem(icon: Container(), title: Text("")),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/schedule.png",
                  scale: 4,
                ),
                activeIcon: Image.asset(
                  "assets/images/schedule.png",
                  scale: 4,
                  color: greenColor,
                ),
                title: Text("Schedule")),
            BottomNavigationBarItem(
                icon: Image.asset("assets/images/profile.png", scale: 4),
                activeIcon: Image.asset(
                  "assets/images/profile.png",
                  scale: 4,
                  color: greenColor,
                ),
                title: Text("Profile"))
          ]),
    );
  }
}
