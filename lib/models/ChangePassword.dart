// To parse this JSON data, do
//
//     final changePassword = changePasswordFromJson(jsonString);

import 'dart:convert';

ChangePassword changePasswordFromJson(String str) => ChangePassword.fromJson(json.decode(str));

String changePasswordToJson(ChangePassword data) => json.encode(data.toJson());

class ChangePassword {
  ChangePassword({
    this.requestId,
    this.requestTime,
    this.deviceName,
    this.channel,
    this.newPassword,
    this.confirmNewPassword,
  });

  String requestId;
  String requestTime;
  String deviceName;
  String channel;
  String newPassword;
  String confirmNewPassword;

  factory ChangePassword.fromJson(Map<String, dynamic> json) => ChangePassword(
    requestId: json["requestId"],
    requestTime: json["requestTime"],
    deviceName: json["deviceName"],
    channel: json["channel"],
    newPassword: json["newPassword"],
    confirmNewPassword: json["confirmNewPassword"],
  );

  Map<String, dynamic> toJson() => {
    "requestId": requestId,
    "requestTime": requestTime,
    "deviceName": deviceName,
    "channel": channel,
    "newPassword": newPassword,
    "confirmNewPassword": confirmNewPassword,
  };
}
