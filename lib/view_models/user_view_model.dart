import 'package:flutter_application_1/models/user.dart';

class UserViewModel {
  final User user;

  UserViewModel({required this.user});

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
