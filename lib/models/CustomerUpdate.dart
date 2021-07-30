// To parse this JSON data, do
//
//     final customerUpdate = customerUpdateFromJson(jsonString);

import 'dart:convert';

import 'package:petrolimex/models/CustomerInfo.dart';

CustomerUpdate customerUpdateFromJson(String str) => CustomerUpdate.fromJson(json.decode(str));

String customerUpdateToJson(CustomerUpdate data) => json.encode(data.toJson());

class CustomerUpdate {
  CustomerUpdate({
    this.requestId,
    this.requestTime,
    this.deviceName,
    this.channel,
    this.customer,
    this.questions,
    this.vehicles,
    this.linkedCards,
  });

  String requestId;
  String requestTime;
  String deviceName;
  String channel;
  CustomerU customer;
  List<Question> questions;
  List<Vehicle> vehicles;
  List<LinkedCard> linkedCards;

  factory CustomerUpdate.fromJson(Map<String, dynamic> json) => CustomerUpdate(
    requestId: json["requestId"],
    requestTime: json["requestTime"],
    deviceName: json["deviceName"],
    channel: json["channel"],
    customer: CustomerU.fromJson(json["customer"]),
    questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
    vehicles: List<Vehicle>.from(json["vehicles"].map((x) => Vehicle.fromJson(x))),
    linkedCards: List<LinkedCard>.from(json["linkedCards"].map((x) => LinkedCard.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "requestId": requestId,
    "requestTime": requestTime,
    "deviceName": deviceName,
    "channel": channel,
    "customer": customer.toJson(),
    "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
    "vehicles": List<dynamic>.from(vehicles.map((x) => x.toJson())),
    "linkedCards": List<dynamic>.from(linkedCards.map((x) => x.toJson())),
  };
}

class CustomerU {
  CustomerU({
    this.name,
    this.email,
    this.cardId,
    this.phone,
    this.date,
    this.gender,
    this.taxCode,
    this.provinceId,
    this.districtId,
    this.wardId,
    this.address,
  });

  String name;
  String email;
  String cardId;
  String phone;
  String date;
  String gender;
  String taxCode;
  int provinceId;
  int districtId;
  int wardId;
  String address;

  factory CustomerU.fromJson(Map<String, dynamic> json) => CustomerU(
    name: json["name"],
    email: json["email"],
    cardId: json["cardId"],
    phone: json["phone"],
    date: json["date"],
    gender: json["gender"],
    taxCode: json["taxCode"],
    provinceId: json["provinceId"],
    districtId: json["districtId"],
    wardId: json["wardId"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "cardId": cardId,
    "phone": phone,
    "date": date,
    "gender": gender,
    "taxCode": taxCode,
    "provinceId": provinceId,
    "districtId": districtId,
    "wardId": wardId,
    "address": address,
  };
}

// class LinkedCard {
//   LinkedCard({
//     this.id,
//     this.name,
//     this.cardNumber,
//     this.recordType,
//   });
//
//   int id;
//   String name;
//   String cardNumber;
//   int recordType;
//
//   factory LinkedCard.fromJson(Map<String, dynamic> json) => LinkedCard(
//     id: json["id"],
//     name: json["name"],
//     cardNumber: json["cardNumber"],
//     recordType: json["recordType"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "cardNumber": cardNumber,
//     "recordType": recordType,
//   };
// }
//
// class Question {
//   Question({
//     this.id,
//     this.answer,
//     this.recordType,
//   });
//
//   int id;
//   String answer;
//   int recordType;
//
//   factory Question.fromJson(Map<String, dynamic> json) => Question(
//     id: json["id"],
//     answer: json["answer"],
//     recordType: json["recordType"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "answer": answer,
//     "recordType": recordType,
//   };
// }
//
// class Vehicle {
//   Vehicle({
//     this.id,
//     this.name,
//     this.licensePlate,
//     this.vehicleTypeId,
//     this.recordType,
//   });
//
//   int id;
//   String name;
//   String licensePlate;
//   int vehicleTypeId;
//   int recordType;
//
//   factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
//     id: json["id"],
//     name: json["name"],
//     licensePlate: json["licensePlate"],
//     vehicleTypeId: json["vehicleTypeId"],
//     recordType: json["recordType"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "licensePlate": licensePlate,
//     "vehicleTypeId": vehicleTypeId,
//     "recordType": recordType,
//   };
// }
