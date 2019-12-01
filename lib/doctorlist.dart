import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:telemedicine/bottomNavBar.dart';
import 'package:telemedicine/doctorDetails.dart';
import 'package:telemedicine/helper/APIHelper.dart';

import 'models/data.dart';
import 'helper/contentCreator.dart';

class DoctorListPage extends StatefulWidget {
  DoctorListPage({Key key}) : super(key: key);

  @override
  _DoctorListPageState createState() => _DoctorListPageState();
}

class _DoctorListPageState extends State<DoctorListPage> {
  // List with speciality
  List<String> speciality = [];
  // List of doctors with this [speciality]
  List<DoctorProfile> doctorList = [];

  _detSpeciality(String desease) {
    var keyWords = desease.split(" ");

    keyWords.forEach((word) {
      // Oculist
      ["ochi", "ochiul", "ochelari", "ochii", "vedere", "vederea", "vad"]
          .forEach((simptom) {
        if (word.toLowerCase() == simptom) speciality.add("Oculist");
      });
      // Pediatru
      ["copilul", "copil", "baiatul", "fetita"].forEach((simptom) {
        if (word.toLowerCase() == simptom) speciality.add("Pediatru");
      });
      // Chirurg
      ["operatie", "operat", "interventie", "chirurgical", "chirurgicala"]
          .forEach((simptom) {
        if (word.toLowerCase() == simptom) speciality.add("Chirurg");
      });
      // Terapeut
      [
        "picior",
        "mina",
        "coloana",
        "vertebrala",
        "muschi",
        "ligamente",
        "fractura",
        "fracturat",
        "spinare",
        "vertebre",
        "dislocat",
        "dislocate"
      ].forEach((simptom) {
        if (word.toLowerCase() == simptom) speciality.add("Terapeut");
      });
    });
  }

  _buildDoctorListBySpeciality(List<DoctorProfile> docList) {
    if (speciality.length == 0)
      doctorList = docList;
    else
      docList.forEach((doctor) {
        speciality.forEach((currSpeciality) {
          if (doctor.speciality == currSpeciality) doctorList.add(doctor);
        });
      });

    //if(doctorList == null)
    //doctorList = docList;
  }

  @override
  void initState() {
    super.initState();

    _detSpeciality(Register.homeData[1]);
    _buildDoctorListBySpeciality(Register.doctorList);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: doctorList == null ? 0 : doctorList.length,
      itemBuilder: (context, index) {
        Uint8List bytes = base64Decode(doctorList[index].photo);
        return Card(
            child: ListTile(
                contentPadding: EdgeInsets.only(left: 10, top: 21, bottom: 17),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: MemoryImage(bytes),
                  backgroundColor: Colors.grey,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "${doctorList[index].fullName}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              letterSpacing: 0.85),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Icon(Icons.star, size: 20, color: Colors.yellow[600]),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${doctorList[index].stars}",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 8,
                        )
                      ],
                    ),
                    Text(
                      "${doctorList[index].speciality}",
                      style: TextStyle(
                          color: greenColor,
                          fontStyle: FontStyle.italic,
                          letterSpacing: 0.8,
                          fontSize: 16),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/icon_location.png",
                          scale: 2,
                        ),
                        SizedBox(
                          width: 9,
                        ),
                        Text(
                          "${doctorList[index].address}",
                          style: TextStyle(
                              fontSize: 16,
                              letterSpacing: 0.8,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                onTap: () {
                  String url =
                      "http://81.180.72.17/api/Doctor/GetDoctor/${index + 1}";
                  getDoctor(context, url, Register.token).then((doctor) {
                    // Go to Bottom Navigation Bar
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomNavBar(
                                  doctor: doctor,
                                  namePage: "Doctor Details",
                                )));
                  });
                }));
      },
    );
  }
}
