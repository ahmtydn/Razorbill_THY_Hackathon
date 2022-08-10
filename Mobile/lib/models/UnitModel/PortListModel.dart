// To parse this JSON data, do
//
//     final getPortsListModel = getPortsListModelFromJson(jsonString);

import 'dart:convert';

List<GetPortsListModel> getPortsListModelFromJson(String str) => List<GetPortsListModel>.from(json.decode(str).map((x) => GetPortsListModel.fromJson(x)));

String getPortsListModelToJson(List<GetPortsListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetPortsListModel {
  GetPortsListModel({
   required this.code,
    required this.name,
  });

  String code;
  String name;

  factory GetPortsListModel.fromJson(Map<String, dynamic> json) => GetPortsListModel(
    code: json["Code"],
    name: json["Name"],
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "Name": name,
  };
}
