class User {
  // attribute of user account
  String name;
  String email;
  String pin;
  String userID;
  User({required this.email, required this.name, required this.pin, required this.userID});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(email: json["email"], name: json["name"], pin: json["pin"],
    userID: json["user_id"]
    );
  }
}
