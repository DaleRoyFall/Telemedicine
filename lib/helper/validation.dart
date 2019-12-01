String validateFullName(String value) {
  String patttern = r"^[\w'\-,.][^0-9_!¡?÷?¿/\\+=@#$%ˆ&*(){}|~<>;:[\]]{2,}$";
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Full Name can't be empty";
  } else if (value.length < 5) {
    return "Full Name can't be shorter than 5 caracters";
  } else if (!regExp.hasMatch(value)) {
    return "Invalid form of full name";
  }
  return null;
}

String validateName(String value) {
  String patttern = r"^[a-zA-Z\s]+$";
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Name can't be empty";
  } else if (!regExp.hasMatch(value)) {
    return "Invalid form of name";
  }
  return null;
}

String validateDesease(String value) {
  String patttern = r"^[a-zA-Z\s]+$";
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Desease can't be empty";
  } else if (!regExp.hasMatch(value)) {
    return "Invalid form of desease";
  }
  return null;
}

String validateBirthday(String value) {
  String pattern = r'^\d{4}\/(0[1-9]|1[012])\/(0[1-9]|[12][0-9]|3[01])$';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0)
    return "Birthday can't be empty";
  else if (!regExp.hasMatch(value)) return "Birthday must be yyyy/mm/dd";

  return null;
}

String validateEmail(String value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0 || value == null) {
    return "Email can't be empty";
  } else if (!regExp.hasMatch(value)) {
    return "Invalid Email";
  } else {
    return null;
  }
}

String validateMobile(String value) {
  String patttern = r'(^[+]{0,1}[0-9]*$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Mobile can't be empty";
  } else if (!regExp.hasMatch(value)) {
    return "Mobile number must be digits";
  }
  return null;
}

String validateUsername(String value) {
  String patttern =
      r'^(?=.{5,30}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Username can't be empty";
  } else if (value.length < 5) {
    return "Username can't be shorter than 5 caracters";
  } else if (!regExp.hasMatch(value)) {
    return "Incorrect form of username";
  }
  return null;
}

String validatePassword(String value) {
  String patttern =
      r'^(?=.{8,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Password can't be empty";
  } else if (value.length < 8) {
    return "Password can't be shorter than 8 caracters";
  } else if (!regExp.hasMatch(value)) {
    return "Password must contain at least eight characters, \nat least one letter and one number";
  }
  return null;
}

String validateLocation(String value) {
  if (value.length == 0) return "Location can't be empty.";

  return null;
}
