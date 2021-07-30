// To parse this JSON data, do
//
//     final genarateOtp = genarateOtpFromJson(jsonString);

import 'dart:convert';

GenerateOtp generateOtpFromJson(String str) => GenerateOtp.fromJson(json.decode(str));

String generateOtpToJson(GenerateOtp data) => json.encode(data.toJson());

class GenerateOtp {
  GenerateOtp({
    this.requestId,
    this.requestTime,
    this.deviceName,
    this.channel,
    this.phone,
    this.transactionType
  });

  String requestId;
  String requestTime;
  String deviceName;
  String channel;
  String phone;
  String transactionType;

  factory GenerateOtp.fromJson(Map<String, dynamic> json) => GenerateOtp(
    requestId: json["requestId"],
    requestTime: json["requestTime"],
    deviceName: json["deviceName"],
    channel: json["channel"],
    phone: json["phone"],
    transactionType: json["transactionType"],
  );

  Map<String, dynamic> toJson() => {
    "requestId": requestId,
    "requestTime": requestTime,
    "deviceName": deviceName,
    "channel": channel,
    "phone": phone,
    "transactionType": transactionType,
  };
}
// To parse this JSON data, do
//
//     final validateOtp = validateOtpFromJson(jsonString);

ValidateOtp validateOtpFromJson(String str) => ValidateOtp.fromJson(json.decode(str));

String validateOtpToJson(ValidateOtp data) => json.encode(data.toJson());

class ValidateOtp {
  ValidateOtp({
    this.requestId,
    this.requestTime,
    this.deviceName,
    this.channel,
    this.phone,
    this.otpCode,
  });

  String requestId;
  String requestTime;
  String deviceName;
  String channel;
  String phone;
  String otpCode;

  factory ValidateOtp.fromJson(Map<String, dynamic> json) => ValidateOtp(
    requestId: json["requestId"],
    requestTime: json["requestTime"],
    deviceName: json["deviceName"],
    channel: json["channel"],
    phone: json["phone"],
    otpCode: json["otpCode"],
  );

  Map<String, dynamic> toJson() => {
    "requestId": requestId,
    "requestTime": requestTime,
    "deviceName": deviceName,
    "channel": channel,
    "phone": phone,
    "otpCode": otpCode,
  };
}

