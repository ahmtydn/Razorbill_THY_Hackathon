// To parse this JSON data, do
//
//     final userUpdateModel = userUpdateModelFromJson(jsonString);

import 'dart:convert';

UserUpdateModel userUpdateModelFromJson(String str) => UserUpdateModel.fromJson(json.decode(str));

String userUpdateModelToJson(UserUpdateModel data) => json.encode(data.toJson());

class UserUpdateModel {
  UserUpdateModel({
   required this.firstName,
    required  this.lastName,
    required  this.email,
    required  this.password,
  });

  String firstName;
  String lastName;
  String email;
  String password;

  factory UserUpdateModel.fromJson(Map<String, dynamic> json) => UserUpdateModel(
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "password": password,
  };
}
