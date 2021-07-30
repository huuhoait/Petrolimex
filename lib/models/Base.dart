// To parse this JSON data, do
//
//     final base = baseFromJson(jsonString);

import 'dart:convert';

Base baseFromJson(String str) => Base.fromJson(json.decode(str));

String baseToJson(Base data) => json.encode(data.toJson());

class Base {
  Base({
    this.requestId,
    this.requestTime,
    this.deviceName,
    this.channel,
  });

  String requestId;
  String requestTime;
  String deviceName;
  String channel;

  factory Base.fromJson(Map<String, dynamic> json) => Base(
    requestId: json["requestId"],
    requestTime: json["requestTime"],
    deviceName: json["deviceName"],
    channel: json["channel"],
  );

  Map<String, dynamic> toJson() => {
    "requestId": requestId,
    "requestTime": requestTime,
    "deviceName": deviceName,
    "channel": channel,
  };
}
