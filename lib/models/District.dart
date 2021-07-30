// To parse this JSON data, do
//
//     final district = districtFromJson(jsonString);

import 'dart:convert';

List<District> districtFromJson(String str) => List<District>.from(json.decode(str).map((x) => District.fromJson(x)));

String districtToJson(List<District> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class District {
  District({
    this.value,
    this.display,
    this.deviceName,
    this.channel
  });

  String value;
  String display;
  String deviceName;
  String channel;

  factory District.fromJson(Map<String, dynamic> json) => District(
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
