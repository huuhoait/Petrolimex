// To parse this JSON data, do
//
//     final vehicleType = vehicleTypeFromJson(jsonString);

import 'dart:convert';

VehicleType vehicleTypeFromJson(String str) => VehicleType.fromJson(json.decode(str));

String vehicleTypeToJson(VehicleType data) => json.encode(data.toJson());

class VehicleType {
  VehicleType({
    this.vehicleTypes,
  });

  List<VehicleTypeElement> vehicleTypes;

  factory VehicleType.fromJson(Map<String, dynamic> json) => VehicleType(
    vehicleTypes: List<VehicleTypeElement>.from(json["vehicleTypes"].map((x) => VehicleTypeElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "vehicleTypes": List<dynamic>.from(vehicleTypes.map((x) => x.toJson())),
  };
}

class VehicleTypeElement {
  VehicleTypeElement({
    this.value,
    this.display,
    this.deviceName,
    this.channel,
  });

  String value;
  String display;
  String deviceName;
  String channel;

  factory VehicleTypeElement.fromJson(Map<String, dynamic> json) => VehicleTypeElement(
    value: json["value"],
    display: json["display"],
    deviceName: json["deviceName"],
    channel: json["channel"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "display": display,
    "deviceName": deviceName,
    "channel": channel,
  };
}
