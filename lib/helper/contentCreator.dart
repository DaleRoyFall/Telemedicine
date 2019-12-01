import 'package:flutter/material.dart';

// Color for background and buttons
final Color greenColor = Color(0xff07DA5F);

// Build default text style
TextStyle defaultTextStyle =
    TextStyle(fontSize: 17, letterSpacing: 0.85, fontWeight: FontWeight.bold);

// Create container(before text field) with text
Widget createTextContainer(
    BuildContext context, String text, TextStyle textStyle) {
  return Container(
    padding: EdgeInsets.only(left: 21, right: 26),
    width: MediaQuery.of(context).size.width,
    child: Text(text,
        // If our text style is null then use default text style
        // Else use our custom style
        style: textStyle),
  );
}

// Create button with onPress function
Widget buttonCreator(String text, Color backgroundColor, Color textColor,
        Color borderColor, EdgeInsets buttonPadding, Function onPress) =>
    Container(
      padding: buttonPadding,
      child: RaisedButton(
        shape: new RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(color: borderColor)),
        onPressed: onPress,
        textColor: textColor,
        color: backgroundColor,
        child: Container(
          height: 55,
          child: Center(
              child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );

// Build ordinar SnackBar
void buildSnackBar(BuildContext context, String title, String message) {
  final snackbar = new SnackBar(
      content: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 4,
      ),
      Text(message)
    ],
  ));

  // Show snackbar
  Scaffold.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackbar);
}
