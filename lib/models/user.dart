class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String image;
  final bool notificationsEnabled;
  final int notificationDayAmount;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.image,
    this.notificationsEnabled = true,
    this.notificationDayAmount = 3,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      password: json["password"],
      image: json["image"],
      notificationsEnabled: json["notificationsEnabled"],
      notificationDayAmount: json["notificationDayAmount"],
    );
  }
}
