// To parse this JSON data, do
//
//     final static = staticFromJson(jsonString);

import 'dart:convert';

Static staticFromJson(String str) => Static.fromJson(json.decode(str));

String staticToJson(Static data) => json.encode(data.toJson());

class Static {
  Static({
    this.questions,
    this.genders,
    this.provinces,
  });

  List<Property> questions;
  List<Property> genders;
  List<Property> provinces;

  factory Static.fromJson(Map<String, dynamic> json) => Static(
    questions: List<Property>.from(json["questions"].map((x) => Property.fromJson(x))),
    genders: List<Property>.from(json["genders"].map((x) => Property.fromJson(x))),
    provinces: List<Property>.from(json["provinces"].map((x) => Property.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
    "genders": List<dynamic>.from(genders.map((x) => x.toJson())),
    "provinces": List<dynamic>.from(provinces.map((x) => x.toJson())),
  };
}

class Property {
  Property({
    this.value,
    this.display,
    this.deviceName,
    this.channel
  });

  String value;
  String display;
  String deviceName;
  String channel;

  factory Property.fromJson(Map<String, dynamic> json) => Property(
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

  @override
  String toString() {
    return '{ ${this.value}, ${this.display} }';
  }
}
