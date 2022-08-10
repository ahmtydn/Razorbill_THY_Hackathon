// To parse this JSON data, do
//
//     final passengerModel = passengerModelFromJson(jsonString);

import 'dart:convert';

List<PassengerModel> passengerModelFromJson(String str) =>
    List<PassengerModel>.from(
        json.decode(str).map((x) => PassengerModel.fromJson(x)));

String passengerModelToJson(List<PassengerModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PassengerModel {
  PassengerModel({
    required  this.id,
    required  this.isDeleted,
    required  this.createdTime,
    required  this.updatedTime,
    required  this.firstName,
    required   this.lastName,
    required   this.email,
    required   this.phoneNumber,
    required  this.birthDay,
    required  this.gender,
    required this.isTurkish,
    required  this.identityNumber,
    required  this.spp,
    required  this.userId,
    required  this.tickets,
  });

  String id;
  bool isDeleted;
  DateTime createdTime;
  DateTime updatedTime;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  DateTime birthDay;
  int gender;
  bool isTurkish;
  String identityNumber;
  dynamic spp;
  String userId;
  List<TicketsPassenger> tickets;

  factory PassengerModel.fromJson(Map<String, dynamic> json) => PassengerModel(
        id: json["id"],
        isDeleted: json["isDeleted"],
        createdTime: DateTime.parse(json["createdTime"]),
        updatedTime: DateTime.parse(json["updatedTime"]),
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        birthDay: DateTime.parse(json["birthDay"]),
        gender: json["gender"],
        isTurkish: json["isTurkish"],
        identityNumber: json["identityNumber"],
        spp: json["spp"],
        userId: json["userId"],
        tickets:
            List<TicketsPassenger>.from(json["tickets"].map((x) => TicketsPassenger.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "isDeleted": isDeleted,
        "createdTime": createdTime.toIso8601String(),
        "updatedTime": updatedTime.toIso8601String(),
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "birthDay":
            "${birthDay.year.toString().padLeft(4, '0')}-${birthDay.month.toString().padLeft(2, '0')}-${birthDay.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "isTurkish": isTurkish,
        "identityNumber": identityNumber,
        "spp": spp,
        "userId": userId,
        "tickets": List<dynamic>.from(tickets.map((x) => x.toJson())),
      };
}

class TicketsPassenger {
  TicketsPassenger({
    required this.id,
    required this.isDeleted,
    required this.createdTime,
    required this.updatedTime,
    required this.pnr,
    required this.seatNumber,
    required this.ticketClass,
    required this.meal,
    required this.baggage,
    required this.cabinBaggage,
    required this.passengerId,
    required this.airFlightId,
  });

  String id;
  bool isDeleted;
  DateTime createdTime;
  DateTime updatedTime;
  String pnr;
  String seatNumber;
  int ticketClass;
  String meal;
  int baggage;
  int cabinBaggage;
  String passengerId;
  String airFlightId;

  factory TicketsPassenger.fromJson(Map<String, dynamic> json) => TicketsPassenger(
        id: json["id"],
        isDeleted: json["isDeleted"],
        createdTime: DateTime.parse(json["createdTime"]),
        updatedTime: DateTime.parse(json["updatedTime"]),
        pnr: json["pnr"],
        seatNumber: json["seatNumber"],
        ticketClass: json["class"],
        meal: json["meal"],
        baggage: json["baggage"],
        cabinBaggage: json["cabinBaggage"],
        passengerId: json["passengerId"],
        airFlightId: json["airFlightId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "isDeleted": isDeleted,
        "createdTime": createdTime.toIso8601String(),
        "updatedTime": updatedTime.toIso8601String(),
        "pnr": pnr,
        "seatNumber": seatNumber,
        "class": ticketClass,
        "meal": meal,
        "baggage": baggage,
        "cabinBaggage": cabinBaggage,
        "passengerId": passengerId,
        "airFlightId": airFlightId,
      };
}
