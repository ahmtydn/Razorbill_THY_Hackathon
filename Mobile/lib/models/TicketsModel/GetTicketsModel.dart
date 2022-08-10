// To parse this JSON data, do
//
//     final getTicketsModel = getTicketsModelFromJson(jsonString);

import 'dart:convert';

GetTicketsModel getTicketsModelFromJson(String str) =>
    GetTicketsModel.fromJson(json.decode(str));

String getTicketsModelToJson(GetTicketsModel data) =>
    json.encode(data.toJson());

class GetTicketsModel {
  GetTicketsModel({
    required this.id,
    required this.isDeleted,
    required this.createdTime,
    required this.updatedTime,
    required this.pnr,
    required this.seatNumber,
    required this.getTicketsModelClass,
    required this.meal,
    required this.baggage,
    required this.cabinBaggage,
    required this.passengerId,
    required this.airFlightId,
    required this.passenger,
    required this.airFlight,
  });

  String id;
  bool isDeleted;
  DateTime createdTime;
  DateTime updatedTime;
  String pnr;
  String seatNumber;
  int getTicketsModelClass;
  String meal;
  int baggage;
  int cabinBaggage;
  String passengerId;
  String airFlightId;
  Passenger passenger;
  AirFlight airFlight;

  factory GetTicketsModel.fromJson(Map<String, dynamic> json) =>
      GetTicketsModel(
        id: json["id"],
        isDeleted: json["isDeleted"],
        createdTime: DateTime.parse(json["createdTime"]),
        updatedTime: DateTime.parse(json["updatedTime"]),
        pnr: json["pnr"],
        seatNumber: json["seatNumber"],
        getTicketsModelClass: json["class"],
        meal: json["meal"],
        baggage: json["baggage"],
        cabinBaggage: json["cabinBaggage"],
        passengerId: json["passengerId"],
        airFlightId: json["airFlightId"],
        passenger: Passenger.fromJson(json["passenger"]),
        airFlight: AirFlight.fromJson(json["airFlight"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "isDeleted": isDeleted,
        "createdTime": createdTime.toIso8601String(),
        "updatedTime": updatedTime.toIso8601String(),
        "pnr": pnr,
        "seatNumber": seatNumber,
        "class": getTicketsModelClass,
        "meal": meal,
        "baggage": baggage,
        "cabinBaggage": cabinBaggage,
        "passengerId": passengerId,
        "airFlightId": airFlightId,
        "passenger": passenger.toJson(),
        "airFlight": airFlight.toJson(),
      };
}

class AirFlight {
  AirFlight({
    required this.id,
    required this.isDeleted,
    required this.createdTime,
    required this.updatedTime,
    required this.arrival,
    required this.departure,
    required this.from,
    required this.to,
    required this.price,
    required this.capacity,
    required this.duration,
  });

  String id;
  bool isDeleted;
  DateTime createdTime;
  DateTime updatedTime;
  DateTime arrival;
  DateTime departure;
  String from;
  String to;
  String price;
  int capacity;
  String duration;

  factory AirFlight.fromJson(Map<String, dynamic> json) => AirFlight(
        id: json["id"],
        isDeleted: json["isDeleted"],
        createdTime: DateTime.parse(json["createdTime"]),
        updatedTime: DateTime.parse(json["updatedTime"]),
        arrival: DateTime.parse(json["arrival"]),
        departure: DateTime.parse(json["departure"]),
        from: json["from"],
        to: json["to"],
        price: json["price"],
        capacity: json["capacity"],
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "isDeleted": isDeleted,
        "createdTime": createdTime.toIso8601String(),
        "updatedTime": updatedTime.toIso8601String(),
        "arrival":
            "${arrival.year.toString().padLeft(4, '0')}-${arrival.month.toString().padLeft(2, '0')}-${arrival.day.toString().padLeft(2, '0')}",
        "departure":
            "${departure.year.toString().padLeft(4, '0')}-${departure.month.toString().padLeft(2, '0')}-${departure.day.toString().padLeft(2, '0')}",
        "from": from,
        "to": to,
        "price": price,
        "capacity": capacity,
        "duration": duration,
      };
}

class Passenger {
  Passenger({
    required this.id,
    required this.isDeleted,
    required this.createdTime,
    required this.updatedTime,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.birthDay,
    required this.gender,
    required this.isTurkish,
    required this.identityNumber,
    required this.spp,
    required this.userId,
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

  factory Passenger.fromJson(Map<String, dynamic> json) => Passenger(
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
      };
}
