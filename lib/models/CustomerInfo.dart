// To parse this JSON data, do
//
//     final customerInfo = customerInfoFromJson(jsonString);

import 'dart:convert';

CustomerInfo customerInfoFromJson(String str) => CustomerInfo.fromJson(json.decode(str));

String customerInfoToJson(CustomerInfo data) => json.encode(data.toJson());

class CustomerInfo {
  CustomerInfo({
    this.responseId,
    this.responseTime,
    this.resultCode,
    this.resultMessage,
    this.customer,
    this.vehicles,
    this.linkedCards,
    this.questions,
  });

  String responseId;
  String responseTime;
  String resultCode;
  String resultMessage;
  Customer customer;
  List<Vehicle> vehicles;
  List<LinkedCard> linkedCards;
  List<Question> questions;

  factory CustomerInfo.fromJson(Map<String, dynamic> json) => CustomerInfo(
    responseId: json["responseId"],
    responseTime: json["responseTime"],
    resultCode: json["resultCode"],
    resultMessage: json["resultMessage"],
    customer: Customer.fromJson(json["customer"]),
    vehicles: List<Vehicle>.from(json["vehicles"].map((x) => Vehicle.fromJson(x))),
    linkedCards: List<LinkedCard>.from(json["linkedCards"].map((x) => LinkedCard.fromJson(x))),
    questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "responseId": responseId,
    "responseTime": responseTime,
    "resultCode": resultCode,
    "resultMessage": resultMessage,
    "customer": customer.toJson(),
    "vehicles": List<dynamic>.from(vehicles.map((x) => x.toJson())),
    "linkedCards": List<dynamic>.from(linkedCards.map((x) => x.toJson())),
    "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
  };
}

class Customer {
  Customer({
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
    this.customerTypeId
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
  int customerTypeId;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
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
    customerTypeId: json["customerTypeId"],
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
    "customerTypeId": customerTypeId,
  };
}

class LinkedCard {
  LinkedCard({
    this.id,
    this.name,
    this.cardNumber,
    this.recordType,
  });

  int id;
  String name;
  String cardNumber;
  int recordType;

  factory LinkedCard.fromJson(Map<String, dynamic> json) => LinkedCard(
    id: json["id"],
    name: json["name"],
    cardNumber: json["cardNumber"],
    recordType: json["recordType"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "cardNumber": cardNumber,
    "recordType": recordType,
  };
}

class Question {
  Question({
    this.id,
    this.answer,
    this.recordType,
  });

  int id;
  String answer;
  int recordType;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["id"],
    answer: json["answer"],
    recordType: json["recordType"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "answer": answer,
    "recordType": recordType,
  };
}

class Vehicle {
  Vehicle({
    this.id,
    this.name,
    this.licensePlate,
    this.vehicleTypeId,
    this.recordType,
  });

  int id;
  String name;
  String licensePlate;
  int vehicleTypeId;
  int recordType;

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
    id: json["id"],
    name: json["name"],
    licensePlate: json["licensePlate"],
    vehicleTypeId: json["vehicleTypeId"],
    recordType: json["recordType"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "licensePlate": licensePlate,
    "vehicleTypeId": vehicleTypeId,
    "recordType": recordType,
  };
}
