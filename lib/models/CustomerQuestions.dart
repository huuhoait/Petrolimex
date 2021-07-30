// To parse this JSON data, do
//
//     final customerQuestion = customerQuestionFromJson(jsonString);

import 'dart:convert';

CustomerQuestion customerQuestionFromJson(String str) => CustomerQuestion.fromJson(json.decode(str));

String customerQuestionToJson(CustomerQuestion data) => json.encode(data.toJson());

class CustomerQuestion {
  CustomerQuestion({
    this.requestId,
    this.requestTime,
    this.deviceName,
    this.channel,
    this.phone,
  });

  String requestId;
  String requestTime;
  String deviceName;
  String channel;
  String phone;

  factory CustomerQuestion.fromJson(Map<String, dynamic> json) => CustomerQuestion(
    requestId: json["requestId"],
    requestTime: json["requestTime"],
    deviceName: json["deviceName"],
    channel: json["channel"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "requestId": requestId,
    "requestTime": requestTime,
    "deviceName": deviceName,
    "channel": channel,
    "phone": phone,
  };
}

CustomerAnswer customerAnswerFromJson(String str) => CustomerAnswer.fromJson(json.decode(str));

String customerAnswerToJson(CustomerAnswer data) => json.encode(data.toJson());

class CustomerAnswer {
  CustomerAnswer({
    this.requestId,
    this.requestTime,
    this.deviceName,
    this.channel,
    this.phone,
    this.questionId1,
    this.answer1,
    this.questionId2,
    this.answer2,
  });

  String requestId;
  String requestTime;
  String deviceName;
  String channel;
  String phone;
  int questionId1;
  String answer1;
  int questionId2;
  String answer2;

  factory CustomerAnswer.fromJson(Map<String, dynamic> json) => CustomerAnswer(
    requestId: json["requestId"],
    requestTime: json["requestTime"],
    deviceName: json["deviceName"],
    channel: json["channel"],
    phone: json["phone"],
    questionId1: json["questionId1"],
    answer1: json["answer1"],
    questionId2: json["questionId2"],
    answer2: json["answer2"],
  );

  Map<String, dynamic> toJson() => {
    "requestId": requestId,
    "requestTime": requestTime,
    "deviceName": deviceName,
    "channel": channel,
    "phone": phone,
    "questionId1": questionId1,
    "answer1": answer1,
    "questionId2": questionId2,
    "answer2": answer2,
  };
}


ResponseQuestion responseQuestionFromJson(String str) => ResponseQuestion.fromJson(json.decode(str));

String responseQuestionToJson(ResponseQuestion data) => json.encode(data.toJson());

class ResponseQuestion {
  ResponseQuestion({
    this.questions,
    this.resultCode,
    this.resultMessage,
    this.responseId,
    this.responseTime,
  });

  List<Question> questions;
  String resultCode;
  String resultMessage;
  String responseId;
  String responseTime;

  factory ResponseQuestion.fromJson(Map<String, dynamic> json) => ResponseQuestion(
    questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
    resultCode: json["resultCode"],
    resultMessage: json["resultMessage"],
    responseId: json["responseId"],
    responseTime: json["responseTime"],
  );

  Map<String, dynamic> toJson() => {
    "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
    "resultCode": resultCode,
    "resultMessage": resultMessage,
    "responseId": responseId,
    "responseTime": responseTime,
  };
}

class Question {
  Question({
    this.value,
    this.display,
  });

  String value;
  String display;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    value: json["value"],
    display: json["display"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "display": display,
  };
}

