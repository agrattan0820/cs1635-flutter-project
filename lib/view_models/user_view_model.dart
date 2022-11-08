import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user.dart';

final User initialData = User(
    firstName: "Alexander",
    lastName: "Grattan",
    email: "alex@grattan.me",
    password: "password",
    image: "image");

class UserViewModel with ChangeNotifier {
  final User user = initialData;

  String get firstName {
    return user.firstName;
  }

  String get lastName {
    return user.lastName;
  }

  String get fullName {
    return "${user.firstName} ${user.lastName}";
  }

  String get email {
    return user.email;
  }

  String get password {
    return user.password;
  }

  String get image {
    return user.image;
  }

  bool get notificationsEnabled {
    return user.notificationsEnabled;
  }

  int get notificationDayAmount {
    return user.notificationDayAmount;
  }
}
