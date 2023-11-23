import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? email;
  String? name;
  String? phone;
  String? uid;

  UserModel({
    this.email,
    this.name,
    this.phone,
    this.uid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    email: json["email"],
    name: json["name"],
    phone: json["phone"],
    uid: json["uid"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "name": name,
    "phone": phone,
    "uid": uid,
  };
}
