// To parse this JSON data, do
//
//     final ward = wardFromJson(jsonString);

import 'dart:convert';

List<Ward> wardFromJson(String str) => List<Ward>.from(json.decode(str).map((x) => Ward.fromJson(x)));

String wardToJson(List<Ward> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ward {
  Ward({
    this.value,
    this.display,
    this.deviceName,
    this.channel

  });

  String value;
  String display;
  String deviceName;
  String channel;

  factory Ward.fromJson(Map<String, dynamic> json) => Ward(
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
