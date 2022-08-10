// To parse this JSON data, do
//
//     final getFlightModel = getFlightModelFromJson(jsonString);

import 'dart:convert';

List<GetFlightModel> getFlightModelFromJson(String str) => List<GetFlightModel>.from(json.decode(str).map((x) => GetFlightModel.fromJson(x)));

String getFlightModelToJson(List<GetFlightModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetFlightModel {
  GetFlightModel({
   required this.price,
    required  this.flightTime,
    required  this.scheduledDepartureAirport,
    required  this.scheduledArrivalAirport,
    required this.scheduledLocalArrivalDatetime,
    required  this.scheduledLocalDepartureDatetime,
  });

  String price;
  String flightTime;
  String scheduledDepartureAirport;
  String scheduledArrivalAirport;
  String scheduledLocalArrivalDatetime;
  String scheduledLocalDepartureDatetime;

  factory GetFlightModel.fromJson(Map<String, dynamic> json) => GetFlightModel(
    price: json["price"],
    flightTime: json["flightTime"],
    scheduledDepartureAirport: json["scheduledDepartureAirport"],
    scheduledArrivalAirport: json["scheduledArrivalAirport"],
    scheduledLocalArrivalDatetime: json["scheduledLocalArrivalDatetime"],
    scheduledLocalDepartureDatetime: json["scheduledLocalDepartureDatetime"],
  );

  Map<String, dynamic> toJson() => {
    "price": price,
    "flightTime": flightTime,
    "scheduledDepartureAirport": scheduledDepartureAirport,
    "scheduledArrivalAirport": scheduledArrivalAirport,
    "scheduledLocalArrivalDatetime": scheduledLocalArrivalDatetime,
    "scheduledLocalDepartureDatetime": scheduledLocalDepartureDatetime,
  };
}
