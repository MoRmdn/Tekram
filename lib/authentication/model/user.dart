class Users {
  Users(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      this.descreption,
      this.titel});

  String? id;
  String? name;
  String? email;
  String? titel;
  String? phone;
  String? descreption;

  factory Users.fromJson(Map json) => Users(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, Object?> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "descreption": descreption,
        "titel": titel
      };
}
