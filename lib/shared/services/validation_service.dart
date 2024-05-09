class MyFormValidator {
  String? userName(String? username) {
    var phoneNumberPattern = RegExp(r'9[87][0-9]{8}');
    if (username!.isEmpty) {
      return "Please provide your username";
    } else if (!phoneNumberPattern.hasMatch(username)) {
      return "Username should be 10 digit mobile number !";
    } else {
      return null;
    }
  }

  String? required(String? value) {
    if (value!.isEmpty) return "This field cannot be empty";
    return null;
  }

  String? mobileNumber(String? mobilenumber) {
    var phoneNumberPattern = RegExp(r'9[87][0-9]{8}');
    if (mobilenumber!.isEmpty) {
      return "Please provide your mobile number";
    } else if (!phoneNumberPattern.hasMatch(mobilenumber)) {
      return "Invalid mobile number !";
    } else {
      return null;
    }
  }

  String? email(String? email) {
    var emailPattern = RegExp(r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})$');
    if (email!.isEmpty) {
      return null;
    } else if (!emailPattern.hasMatch(email)) {
      return "Invalid email address !";
    } else {
      return null;
    }
  }

  String? wardNumber(String? value) {
    if (value!.isEmpty) {
      return 'Ward Number cannot be emmpty';
    } else if (int.parse(value) < 1 || int.parse(value) > 36) {
      return 'Ward Number should be between 1 and 36';
    } else {
      return null;
    }
  }
}
