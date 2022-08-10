// To parse this JSON data, do
//
//     final getIdFlightModel = getIdFlightModelFromJson(jsonString);

import 'dart:convert';

GetIdFlightModel getIdFlightModelFromJson(String str) => GetIdFlightModel.fromJson(json.decode(str));

String getIdFlightModelToJson(GetIdFlightModel data) => json.encode(data.toJson());

class GetIdFlightModel {
  GetIdFlightModel({
    required  this.id,
    required  this.isDeleted,
    required  this.createdTime,
    required  this.updatedTime,
    required  this.arrival,
    required  this.departure,
    required  this.from,
    required   this.to,
    required   this.price,
    required   this.capacity,
    required   this.duration,
    required   this.tickets,
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
  List<Ticket> tickets;

  factory GetIdFlightModel.fromJson(Map<String, dynamic> json) => GetIdFlightModel(
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
    tickets: List<Ticket>.from(json["tickets"].map((x) => Ticket.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "isDeleted": isDeleted,
    "createdTime": createdTime.toIso8601String(),
    "updatedTime": updatedTime.toIso8601String(),
    "arrival": "${arrival.year.toString().padLeft(4, '0')}-${arrival.month.toString().padLeft(2, '0')}-${arrival.day.toString().padLeft(2, '0')}",
    "departure": "${departure.year.toString().padLeft(4, '0')}-${departure.month.toString().padLeft(2, '0')}-${departure.day.toString().padLeft(2, '0')}",
    "from": from,
    "to": to,
    "price": price,
    "capacity": capacity,
    "duration": duration,
    "tickets": List<dynamic>.from(tickets.map((x) => x.toJson())),
  };
}

class Ticket {
  Ticket({
    required this.id,
    required  this.isDeleted,
    required  this.createdTime,
    required  this.updatedTime,
    required  this.pnr,
    required  this.seatNumber,
    required  this.ticketClass,
    required   this.meal,
    required   this.baggage,
    required   this.cabinBaggage,
    required   this.passengerId,
    required   this.airFlightId,
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

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
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
