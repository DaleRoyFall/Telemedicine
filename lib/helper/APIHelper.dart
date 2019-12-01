import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

import 'contentCreator.dart';

// Verify if are connected to network
Future<bool> verifyConection(BuildContext context) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) return false;

  return true;
}

// Build snackbar if not connected
void buildLostConnectionSnackBar(BuildContext context) {
  final snackbar = new SnackBar(
    content: Text("Lost connection",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    action: SnackBarAction(
      label: "Undo",
      onPressed: () {},
    ),
  );

  // Show snackbar
  Scaffold.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackbar);
}

// Build snack bar with loading bar
void builIndicatorSnackBar(BuildContext context) {
  final snackbar = new SnackBar(
    content: Container(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: Row(
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(
            width: 40,
          ),
          Text(
            "Please wait...",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )
        ],
      ),
    ),
    duration: Duration(seconds: 10),
  );

  // Show snackbar
  Scaffold.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackbar);
}

// Fetching register post
Future<LoginPost> fetchRegPost(BuildContext context, String url,
    List<dynamic> regData, String image64) async {
  // Verify if connected to the network
  if (await verifyConection(context)) {
    // Build Progress Indicator
    builIndicatorSnackBar(context);
    // Build header and body to request
    Map<String, String> header = {"Content-Type": "application/json"};
    String body = json.encode({
      'Content-Type': "application/json",
      'FullName': "${regData[0]}",
      'Birthday': "${regData[1]}",
      'Email': "${regData[2]}",
      'Phone': "${regData[3]}",
      'Address': "${regData[6]}",
      'Username': "${regData[4]}",
      'Password': "${regData[5]}",
      'Base64Photo': "$image64",
    });

    // Send loginPost to API
    http.Response response = await http.post(url, headers: header, body: body);
    // Hide Progress Indicator
    Scaffold.of(context).hideCurrentSnackBar();
    // StatusCode:
    //  200 - SUCCESS
    //  417 - Invalid data
    if (response.statusCode == 201) {
      // Build succesfull response
      var errorResponse = json.encode({'Status': "SUCCESS", 'Message': ""});
      // Else if problem with posting return null status
      return LoginPost.fromJson(json.decode(errorResponse));
    } else if (response.statusCode == 417) {
      // If the call to the server was successful, parse the JSON.
      return LoginPost.fromJson(json.decode(response.body));
    }
  } else {
    // Build Lost Connection snackbar
    buildLostConnectionSnackBar(context);
    // Return nullable variable
    return null;
  }

  // Build snackbar with error
  buildSnackBar(context, "Error", "Can't access API");
  // Else if problem with posting return null status
  return null;
}

// Class that contain API responde
class LoginPost {
  final String status;
  final String message;

  LoginPost({this.status, this.message});

  // From Json to LoginPost class
  factory LoginPost.fromJson(Map<String, dynamic> json) {
    return LoginPost(
      status: json['Status'],
      message: json['Message'],
    );
  }
}

// Fetching login post
Future<LoginPost> fetchloginPost(
    BuildContext context, String url, String email, String password) async {
  // Verify if connected to the network
  if (await verifyConection(context)) {
    // Build Progress Indicator
    builIndicatorSnackBar(context);
    // Build header and body to request
    Map<String, String> header = {"Content-Type": "application/json"};
    String body = json.encode({
      'Content-Type': "application/json",
      'Email': "$email",
      'Password': "$password",
    });

    // Send loginPost to API
    http.Response response = await http.post(url, headers: header, body: body);
    // Hide Progress Indicator
    Scaffold.of(context).hideCurrentSnackBar();
    // StatusCode:
    //  200 - Succes
    //  417 - Invalid data
    if (response.statusCode == 200 || response.statusCode == 417) {
      // If the call to the server was successful, parse the JSON.
      return LoginPost.fromJson(json.decode(response.body));
    }
  } else {
    // Build SnackBar for lost connection
    buildLostConnectionSnackBar(context);
    // Return nullable variable
    return null;
  }

  // Build snackbar with error
  buildSnackBar(context, "Error", "Can't access API");
  // Else if problem with posting return null status
  return null;
}

// Class with Doctor data
class DoctorProfile {
  final int id;
  final String fullName;
  final String speciality;
  final String address;
  final String about;
  final double stars;
  final String photo;

  DoctorProfile(
      {this.id,
      this.fullName,
      this.speciality,
      this.address,
      this.about,
      this.stars,
      this.photo});

  // From Json to DoctorProfile class
  factory DoctorProfile.fromJson(Map<String, dynamic> json) {
    return DoctorProfile(
      id: json['DocId'],
      fullName: json['FullName'],
      speciality: json['Specs'],
      address: json['Address'],
      about: json['About'],
      stars: json['Stars'],
      photo: json['Photo'],
    );
  }
}

// Get doctor with id
Future<DoctorProfile> getDoctor(
    BuildContext context, String url, String token) async {
  // Verify if connected to the network
  if (await verifyConection(context)) {
    // Build header and body to request
    Map<String, String> header = {
      "Content-Type": "application/json",
      "token": "$token"
    };

    // Send token to API
    http.Response response = await http.get(url, headers: header);
    // StatusCode:
    //  200 - SUCCESS
    //  417 - Invalid data
    if (response.statusCode == 200) {
      // If the call to the server was successful,
      // Parse JSON and return DoctorProfile
      return DoctorProfile.fromJson(json.decode(response.body));
    }
  } else {
    // Build Lost Connection snackbar
    buildLostConnectionSnackBar(context);
    return null;
  }

  // Build snackbar with error
  buildSnackBar(context, "Error", "Can't access API");
  // Else if problem with posting return null status
  return null;
}

// Get doctor list
Future<Iterable> getDoctorList(
    BuildContext context, String url, String token) async {
  // Verify if connected to the network
  if (await verifyConection(context)) {
    // Build header and body to request
    Map<String, String> header = {
      "Content-Type": "application/json",
      "token": "$token"
    };

    // Send token to API
    http.Response response = await http.get(url, headers: header);
    // StatusCode:
    //  200 - SUCCESS
    //  417 - Invalid data
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      Iterable list = json.decode(response.body);
      // Return list with doctor list
      return list;
    }
  } else {
    // Build Lost Connection snackbar
    buildLostConnectionSnackBar(context);
    return null;
  }

  // Build snackbar with error
  buildSnackBar(context, "Error", "Can't access API");
  // Else if problem with posting return null status
  return null;
}

// Consultant response
class ConsultantResponse {
  final int consId;
  final String name;
  final String disease;
  final String address;
  final String description;
  final int docId;
  final bool isConfirmed;

  ConsultantResponse(
      {this.consId,
      this.name,
      this.disease,
      this.address,
      this.description,
      this.docId,
      this.isConfirmed});

  // From Json to ConsultantResponse class
  factory ConsultantResponse.fromJson(Map<String, dynamic> json) {
    return ConsultantResponse(
        consId: json['ConsId'],
        name: json['Name'],
        disease: json['DIsease'],
        address: json['Address'],
        description: json['Description'],
        docId: json['DocId'],
        isConfirmed: json['IsConfirmed']);
  }
}

void buildToat(String message) {
  Fluttertoast.showToast(
      msg: message,//"Can't add consultant yet\nTry again later.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0);
}

Future<ConsultantResponse> addConsultant(BuildContext context, String url,
    String token, List<dynamic> homeData, DoctorProfile doctor) async {
  // Verify if connected to the network
  var verifyConnection = await verifyConection(context);

  if (verifyConnection) {
    // Build header and body to request
    Map<String, String> header = {
      'Content-Type': "application/json",
      "token": "$token"
    };
    String body = json.encode({
      'Name': "${homeData[0]}",
      'Disease': "${homeData[1]}",
      'Address': "${homeData[2]}",
      'Description': "${homeData[3]}",
    });

    // Send token to API
    http.Response response = await http.post(url, headers: header, body: body);
    // StatusCode:
    //  200 - SUCCESS
    //  401 - Unauthorized
    //  417 - Invalid data
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON and
      // Return Consultant response
      return ConsultantResponse.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      buildToat("Incorect form of deasease");
      return null;
    }
    else if(response.statusCode == 417) {
      buildToat("Can't add consultant yet\nTry again later.");
      return null;
    }
  } else if(!verifyConnection) {
    // Build Lost Connection snackbar
    buildLostConnectionSnackBar(context);
    return null;
  }

  // Build toast with error
  buildToat("Error\nCan't access API");
  // Else if problem with posting return null status
  return null;
}

// User profile
class UserProfile {
  final String fullName;
  final String birthday;
  final String email;
  final String phone;
  final String address;
  final String username;
  final String base64Photo;
  final String status;

  UserProfile(
      {this.fullName,
      this.birthday,
      this.email,
      this.phone,
      this.address,
      this.username,
      this.base64Photo,
      this.status});

  // From Json to DoctorProfile class
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
        fullName: json['FullName'],
        birthday: json['Birthday'],
        email: json['Email'],
        phone: json['Phone'],
        address: json['Address'],
        username: json['Username'],
        base64Photo: json['Base64Photo'],
        status: json['Status']);
  }
}

// Get doctor with id
Future<UserProfile> getProfile(
    BuildContext context, String url, String token) async {
  // Verify if connected to the network
  if (await verifyConection(context)) {
    // Build header and body to request
    Map<String, String> header = {
      "Content-Type": "application/json",
      "token": "$token"
    };

    // Send token to API
    http.Response response = await http.get(url, headers: header);
    // StatusCode:
    //  200 - SUCCESS
    //  417 - Invalid data
    if (response.statusCode == 200) {
      // If the call to the server was successful,
      // Parse JSON and return DoctorProfile
      return UserProfile.fromJson(json.decode(response.body));
    }
  } else {
    // Build Lost Connection snackbar
    buildLostConnectionSnackBar(context);
    return null;
  }

  // Build snackbar with error
  buildSnackBar(context, "Error", "Can't access API");
  // Else if problem with posting return null status
  return null;
}
