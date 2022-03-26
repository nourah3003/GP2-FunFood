class User {
  String name;
  String email;
  String id;
  String code;
  User({required this.email, required this.id, required this.name,required this.code});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(email: json["email"], name: json["name"], id: json["id"],code:json["code"]);
  }
}
