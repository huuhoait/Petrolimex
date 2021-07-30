// To parse this JSON data, do
//
//     final register = registerFromJson(jsonString);

import 'dart:convert';

Register registerFromJson(String str) => Register.fromJson(json.decode(str));

String registerToJson(Register data) => json.encode(data.toJson());

class Register {
  Register({
    this.requestId,
    this.requestTime,
    this.deviceName,
    this.channel,
    this.customerInfo,
    this.vehicles,
    this.linkedCards,
  });

  String requestId;
  String requestTime;
  String deviceName;
  String channel;
  CustomerInfo customerInfo;
  List<Vehicle> vehicles;
  List<LinkedCard> linkedCards;

  factory Register.fromJson(Map<String, dynamic> json) => Register(
    requestId: json["requestId"],
    requestTime: json["requestTime"],
    deviceName: json["deviceName"],
    channel: json["channel"],
    customerInfo: CustomerInfo.fromJson(json["customerInfo"]),
    vehicles: List<Vehicle>.from(json["vehicles"].map((x) => Vehicle.fromJson(x))),
    linkedCards: List<LinkedCard>.from(json["linkedCards"].map((x) => LinkedCard.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "requestId": requestId,
    "requestTime": requestTime,
    "deviceName": deviceName,
    "channel": channel,
    "customerInfo": customerInfo.toJson(),
    "vehicles": List<dynamic>.from(vehicles.map((x) => x.toJson())),
    "linkedCards": List<dynamic>.from(linkedCards.map((x) => x.toJson())),
  };

}

class CustomerInfo {
  CustomerInfo({
    this.customerBasic,
    this.customerCard,
  });

  CustomerBasic customerBasic;
  CustomerCard customerCard;

  factory CustomerInfo.fromJson(Map<String, dynamic> json) => CustomerInfo(
    customerBasic: CustomerBasic.fromJson(json["customerBasic"]),
    customerCard: CustomerCard.fromJson(json["customerCard"]),
  );

  Map<String, dynamic> toJson() => {
    "customerBasic": customerBasic.toJson(),
    "customerCard": customerCard.toJson(),
  };
}

class CustomerBasic {
  CustomerBasic({
    this.name,
    this.phone,
    this.email,
    this.password,
    this.questions,
    this.customerTypeId,
  });

  String name;
  String phone;
  String email;
  String password;
  List<Question> questions;
  int customerTypeId;

  factory CustomerBasic.fromJson(Map<String, dynamic> json) => CustomerBasic(
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    password: json["password"],
    questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
    customerTypeId: json["customerTypeId"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone,
    "email": email,
    "password": password,
    "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
    "customerTypeId": customerTypeId,
  };
}

class Question {
  Question({
    this.questionId,
    this.answer,
  });

  int questionId;
  String answer;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    questionId: json["questionId"],
    answer: json["answer"],
  );

  Map<String, dynamic> toJson() => {
    "questionId": questionId,
    "answer": answer,
  };
}

class CustomerCard {
  CustomerCard({
    this.cardId,
    this.date,
    this.gender,
    this.taxCode,
    this.provinceId,
    this.districtId,
    this.wardId,
    this.address,
  });

  String cardId;
  String date;
  String gender;
  String taxCode;
  int provinceId;
  int districtId;
  int wardId;
  String address;

  factory CustomerCard.fromJson(Map<String, dynamic> json) => CustomerCard(
    cardId: json["cardId"],
    date: json["date"],
    gender: json["gender"],
    taxCode: json["taxCode"],
    provinceId: json["provinceId"],
    districtId: json["districtId"],
    wardId: json["wardId"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "cardId": cardId,
    "date": date,
    "gender": gender,
    "taxCode": taxCode,
    "provinceId": provinceId,
    "districtId": districtId,
    "wardId": wardId,
    "address": address,
  };
}

class LinkedCard {
  LinkedCard({
    this.name,
    this.cardNumber,
  });

  String name;
  String cardNumber;

  factory LinkedCard.fromJson(Map<String, dynamic> json) => LinkedCard(
    name: json["name"],
    cardNumber: json["cardNumber"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "cardNumber": cardNumber,
  };
}

class Vehicle {
  Vehicle({
    this.name,
    this.licensePlate,
    this.vehicleTypeId,
    this.nameVehicleType
  });

  String name;
  String licensePlate;
  int vehicleTypeId;
  String nameVehicleType;

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
    name: json["name"],
    licensePlate: json["licensePlate"],
    vehicleTypeId: json["vehicleTypeId"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "licensePlate": licensePlate,
    "vehicleTypeId": vehicleTypeId,
  };
}
