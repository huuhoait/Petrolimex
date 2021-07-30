/// To parse this JSON data, do
//
//     final loginSuccess = loginSuccessFromJson(jsonString);

import 'dart:convert';

LoginSuccess loginSuccessFromJson(String str) => LoginSuccess.fromJson(json.decode(str));

String loginSuccessToJson(LoginSuccess data) => json.encode(data.toJson());

class LoginSuccess {
  LoginSuccess({
    this.responseId,
    this.responseTime,
    this.token,
    this.customer,
  });

  String responseId;
  String responseTime;
  String token;
  Customer customer;

  factory LoginSuccess.fromJson(Map<String, dynamic> json) => LoginSuccess(
    responseId: json["responseId"],
    responseTime: json["responseTime"],
    token: json["token"],
    customer: Customer.fromJson(json["customer"]),
  );

  Map<String, dynamic> toJson() => {
    "responseId": responseId,
    "responseTime": responseTime,
    "token": token,
    "customer": customer.toJson(),
  };
}

class Customer {
  Customer({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

// To parse this JSON data, do
//
//     final loginFail = loginFailFromJson(jsonString);

LoginFail loginFailFromJson(String str) => LoginFail.fromJson(json.decode(str));

String loginFailToJson(LoginFail data) => json.encode(data.toJson());

class LoginFail {
  LoginFail({
    this.responseId,
    this.responseTime,
    this.errorCode,
    this.errorMessage,
  });

  String responseId;
  DateTime responseTime;
  int errorCode;
  String errorMessage;

  factory LoginFail.fromJson(Map<String, dynamic> json) => LoginFail(
    responseId: json["responseId"],
    responseTime: json["responseTime"],
    errorCode: json["errorCode"],
    errorMessage: json["errorMessage"],
  );

  Map<String, dynamic> toJson() => {
    "responseId": responseId,
    "responseTime": responseTime,
    "errorCode": errorCode,
    "errorMessage": errorMessage,
  };
}




