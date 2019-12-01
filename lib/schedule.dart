import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset("assets/images/unicorn_kill_man.svg", color: Colors.grey[350]),
            SizedBox(height: 10),
            Text(
              "Atention!",
              style: TextStyle(
                  color: Colors.grey[350],
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Don't anger unicorns.",
              style: TextStyle(
                  color: Colors.grey[350],
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            )
          ]),
    );
  }
}
