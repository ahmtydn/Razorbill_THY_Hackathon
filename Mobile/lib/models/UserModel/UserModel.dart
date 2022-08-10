// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.id,
    required this.isDeleted,
    required this.createdTime,
    required this.updatedTime,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  String id;
  bool isDeleted;
  DateTime createdTime;
  DateTime updatedTime;
  String firstName;
  String lastName;
  String email;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      isDeleted: json["isDeleted"],
      createdTime: DateTime.parse(json["createdTime"]),
      updatedTime: DateTime.parse(json["updatedTime"]),
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "isDeleted": isDeleted,
        "createdTime": createdTime.toIso8601String(),
        "updatedTime": updatedTime.toIso8601String(),
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
      };
}
