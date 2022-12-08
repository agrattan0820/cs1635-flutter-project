import 'package:flutter/material.dart';
import 'package:grosseries/models/user.dart';

final Map<String, User> initialData = {
  "alex@grattan.me": User(
    id: 1,
    firstName: "Alexander",
    lastName: "Grattan",
    email: "alex@grattan.me",
    password: "password",
  ),
  "jennzheng12315@gmail.com": User(
    id: 2,
    firstName: "Jennifer",
    lastName: "Zheng",
    email: "jennzheng12315@gmail.com",
    password: "password",
  ),
  "licrystal33@gmail.com": User(
    id: 3,
    firstName: "Crystal",
    lastName: "Li",
    email: "licrystal33@gmail.com",
    password: "password",
  ),
};

class UserViewModel with ChangeNotifier {
  final Map<String, User> _userDatabase = initialData;
  User? _currentUser;

  bool login(String email, String password) {
    if (_userDatabase[email]?.password == password) {
      _currentUser = _userDatabase[email];
      notifyListeners();
      return true;
    }

    return false;
  }

  List createAccount(String firstName, String lastName, String email,
      String password, String confirmPassword) {
    if (_userDatabase.containsKey(email)) {
      return [false, "Account with email already exists"];
    }
    if (password != confirmPassword) {
      return [false, "Passwords do not match"];
    }

    var newId = _userDatabase.length + 1;
    _userDatabase[email] = User(
        id: newId,
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password);
    // Do we want the create account to also login?
    // _currentUser = _userDatabase[email];
    notifyListeners();
    return [true];
  }

  bool editProfile(
    String firstName,
    String lastName,
    String email,
    String password,
  ) {
    String previousEmail = currentUser!.email;

    User loggedInUser = _userDatabase[previousEmail]!;

    loggedInUser.firstName = firstName;
    loggedInUser.lastName = lastName;
    loggedInUser.email = email;
    loggedInUser.password = password;

    _userDatabase[email] = loggedInUser;

    if (email != previousEmail) {
      _userDatabase.remove(previousEmail);
    }

    currentUser!.firstName = firstName;
    currentUser!.lastName = lastName;
    currentUser!.email = email;
    currentUser!.password = password;

    return true;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  void deleteAccount() {
    _userDatabase.remove(_currentUser!.email);
    _currentUser = null;
    notifyListeners();
  }

  User? get currentUser => _currentUser;
  set currentUser(User? newUser) {
    currentUser = newUser;
  }

  set notificationsEnabled(bool? value) {
    notificationsEnabled = value;
  }

  int? get notificationDayAmount {
    return _currentUser?.notificationDayAmount;
  }
}
