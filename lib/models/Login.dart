// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({
    this.requestId,
    this.requestTime,
    this.deviceName,
    this.channel,
    this.phone,
    this.password,
  });

  String requestId;
  String requestTime;
  String deviceName;
  String channel;
  String phone;
  String password;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    requestId: json["requestId"],
    requestTime: json["requestTime"],
    deviceName: json["deviceName"],
    channel: json["channel"],
    phone: json["phone"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "requestId": requestId,
    "requestTime": requestTime,
    "deviceName": deviceName,
    "channel": channel,
    "phone": phone,
    "password": password,
  };
}
