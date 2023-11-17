// To parse this JSON data, do
//
//     final userEditFormModel = userEditFormModelFromJson(jsonString);

import 'dart:convert';

UserEditFormModel userEditFormModelFromJson(String str) =>
    UserEditFormModel.fromJson(json.decode(str));

String userEditFormModelToJson(UserEditFormModel data) =>
    json.encode(data.toJson());

class UserEditFormModel {
  final String? name;
  final String? username;
  final String? email;
  final String? password;
  final String? ktp;

  UserEditFormModel({
    this.name,
    this.username,
    this.email,
    this.password,
    this.ktp,
  });

  UserEditFormModel copyWith({
    String? name,
    String? username,
    String? email,
    String? password,
    String? ktp,
  }) =>
      UserEditFormModel(
        name: name ?? this.name,
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
        ktp: ktp ?? this.ktp,
      );

  factory UserEditFormModel.fromJson(Map<String, dynamic> json) =>
      UserEditFormModel(
        name: json["name"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        ktp: json["ktp"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "email": email,
        "password": password,
        "ktp": ktp,
      };
}
