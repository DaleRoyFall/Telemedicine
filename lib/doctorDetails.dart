import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:telemedicine/bottomNavBar.dart';
import 'models/data.dart';
import 'helper/contentCreator.dart';
import 'helper/APIHelper.dart';

class DoctorDetailsPage extends StatelessWidget {
  DoctorDetailsPage({Key key, @required this.doctor}) : super(key: key);

  final DoctorProfile doctor;

  // Build default text style
  final TextStyle defaultTextStyle =
      TextStyle(fontSize: 17, letterSpacing: 0.85, fontWeight: FontWeight.bold);

  _buildlistTile() {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 10, top: 21, bottom: 17),
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: MemoryImage(base64Decode(doctor.photo)),
        backgroundColor: Colors.grey,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "${doctor.fullName}",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 17, letterSpacing: 0.85),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "${doctor.speciality}",
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
                rating: doctor.stars,
                itemBuilder: (context, index) =>
                    Icon(Icons.star, color: Colors.yellow[600]),
                itemCount: 5,
                itemSize: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "${doctor.stars}",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          )
        ],
      ),
    );
  }

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  /*static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);*/

  Widget _googleMap() {
    return Container(
      height: 300,
      width: 300,
      child: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        _buildlistTile(),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: EdgeInsets.only(left: 28, right: 28),
          height: 2,
          color: Color(0xffeceff1),
        ),
        SizedBox(
          height: 33,
        ),
        createTextContainer(context, "Short Description", defaultTextStyle),
        SizedBox(
          height: 25,
        ),
        Container(
          padding: EdgeInsets.only(left: 27, right: 56),
          child: Text(
            "${doctor.about}",
            style: TextStyle(color: Colors.grey, height: 1.5, letterSpacing: 1),
          ),
        ),
        SizedBox(
          height: 54,
        ),
        createTextContainer(context, "Location", defaultTextStyle),
        SizedBox(
          height: 23,
        ),
        Container(
          padding: EdgeInsets.only(left: 31),
          child: Row(
            children: <Widget>[
              Image.asset(
                "assets/images/icon_location.png",
                scale: 2,
              ),
              SizedBox(
                width: 9,
              ),
              Text(
                "${doctor.address}",
                style: TextStyle(
                    fontSize: 16, letterSpacing: 0.8, color: Colors.grey),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 22,
        ),
        //_googleMap(),
        buttonCreator("Request", greenColor, Colors.white, greenColor,
            EdgeInsets.only(left: 25, right: 25), () {
          // Stock doctor to Register class
          Register.doctor = doctor;
          // Go to Bottom Navigation Bar
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BottomNavBar(
                        namePage: "Home",
                      )));
        }),
      ],
    ));
  }

  /*Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }*/
}
