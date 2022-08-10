// To parse this JSON data, do
//
//     final userUpdateErrorModel = userUpdateErrorModelFromJson(jsonString);

import 'dart:convert';

UserUpdateErrorModel userUpdateErrorModelFromJson(String str) => UserUpdateErrorModel.fromJson(json.decode(str));

String userUpdateErrorModelToJson(UserUpdateErrorModel data) => json.encode(data.toJson());

class UserUpdateErrorModel {
  UserUpdateErrorModel({
    required this.message,
    required this.statusCode,
    required this.timestamp,
    required this.path,
  });

  String message;
  int statusCode;
  DateTime timestamp;
  String path;

  factory UserUpdateErrorModel.fromJson(Map<String, dynamic> json) => UserUpdateErrorModel(
    message: json["message"],
    statusCode: json["statusCode"],
    timestamp: DateTime.parse(json["timestamp"]),
    path: json["path"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "statusCode": statusCode,
    "timestamp": timestamp.toIso8601String(),
    "path": path,
  };
}
