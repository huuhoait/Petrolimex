import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:petrolimex/constants/stConstant.dart';
import 'package:petrolimex/helper/api_base.dart';
import 'package:petrolimex/helper/format.dart';
import 'package:petrolimex/models/Base.dart';
import 'package:petrolimex/models/CustomerInfo.dart';
import 'package:petrolimex/models/CustomerQuestions.dart';
import 'package:petrolimex/models/District.dart';
import 'package:petrolimex/models/OTP.dart';
import 'package:petrolimex/models/Static.dart';
import 'package:petrolimex/models/VehicleType.dart';
import 'package:petrolimex/models/Ward.dart';
import 'package:petrolimex/utils/DeviceInfo.dart';
import 'package:petrolimex/utils/StringUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:petrolimex/helper/app_error.dart';

class ApiService {
  ApiBaseHelper _helper = ApiBaseHelper();
  final requestId = StringUtil.generateUUID();
  final requestTime = Format().f.format(DateTime.now());
  final deviceName = DeviceInfo().getPhoneInfo().toString();
  final channel = STConstant.channel;
  String staticFile = "staticlist.json";
  String vehicleTypeFile = "vehicleTypeData.json";
  String customInfoFile = "customInfoData.json";
  File file;
  final stConstant = STConstant();
  final api = STConstant();
  final code = STConstant();
  final obj = STConstant();

  Future<void> fetchData() async {
    var dir = await getTemporaryDirectory();
    file = new File(dir.path + "/" + staticFile);
    final response = await _helper.postBase(
        Base(
            requestId: requestId,
            requestTime: requestTime,
            deviceName: deviceName,
            channel: channel),
        api.apiStaticlist);
    if (jsonDecode(response)[obj.resultCode] == code.success) {
      file.writeAsStringSync(response.toString(),
          flush: true, mode: FileMode.write);
      log(jsonDecode(response)[obj.resultMessage]);
    } else {
      log(AppError().error(jsonDecode(response)[obj.errorCode]));
    }
  }

  Future<List<Property>> fetchQuestionOne() async {
    var dir = await getTemporaryDirectory();
    file = new File(dir.path + "/" + staticFile);
    if (file.existsSync()) {
      var jsonData = file.readAsStringSync();
      var questionObjJson = jsonDecode(jsonData)[obj.questionsOne] as List;
      List<Property> questionObj = questionObjJson
          .map((questionJson) => Property.fromJson(questionJson))
          .toList();
      log("Load question data from cache");
      return questionObj;
    }
  }

  Future<List<Property>> fetchQuestionTwo() async {
    var dir = await getTemporaryDirectory();
    file = new File(dir.path + "/" + staticFile);
    if (file.existsSync()) {
      var jsonData = file.readAsStringSync();
      var questionObjJson = jsonDecode(jsonData)[obj.questionsTwo] as List;
      List<Property> questionObj = questionObjJson
          .map((questionJson) => Property.fromJson(questionJson))
          .toList();
      log("Load question data from cache");
      return questionObj;
    }
  }

  Future<List<Property>> fetchGender() async {
    var dir = await getTemporaryDirectory();
    file = new File(dir.path + "/" + staticFile);
    if (file.existsSync()) {
      var jsonData = file.readAsStringSync();
      var genderObjJson = jsonDecode(jsonData)[obj.genders] as List;
      List<Property> genderObj = genderObjJson
          .map((genderJson) => Property.fromJson(genderJson))
          .toList();
      log("Load gender data from cache");
      return genderObj;
    }
  }

  Future<List<Property>> fetchProvince() async {
    var dir = await getTemporaryDirectory();
    file = new File(dir.path + "/" + staticFile);
    if (file.existsSync()) {
      var jsonData = file.readAsStringSync();
      var provinceObjJson = jsonDecode(jsonData)[obj.provinces] as List;
      List<Property> provinceObj = provinceObjJson
          .map((provinceJson) => Property.fromJson(provinceJson))
          .toList();
      log("Load province data from cache");
      return provinceObj;
    }
  }

  Future<List<District>> fetchDistrict(String id) async {
    final response = await _helper.postBase(
        Base(
            requestId: requestId,
            requestTime: requestTime,
            deviceName: deviceName,
            channel: channel),
        "/api/districtlist/$id");
    if (jsonDecode(response)[obj.resultCode] == code.success) {
      var districtObjJson = jsonDecode(response)[obj.districts] as List;
      List<District> districtObj = districtObjJson
          .map((districtJson) => District.fromJson(districtJson))
          .toList();
      return districtObj;
    } else {
      log(AppError().error(jsonDecode(response)[obj.errorCode]));
    }
  }

  Future<List<Ward>> fetchWard(String id) async {
    final response = await _helper.postBase(
        Base(
            requestId: requestId,
            requestTime: requestTime,
            deviceName: deviceName,
            channel: channel),
        "/api/wardlist/$id");
    if (jsonDecode(response)[obj.resultCode] == code.success) {
      var wardObjJson = jsonDecode(response)[obj.wards] as List;
      List<Ward> wardObj =
          wardObjJson.map((wardJson) => Ward.fromJson(wardJson)).toList();
      return wardObj;
    } else {
      log(AppError().error(jsonDecode(response)[obj.errorCode]));
    }
  }

  Future<List<VehicleTypeElement>> fetchVehicleType() async {
    var dir = await getTemporaryDirectory();
    file = new File(dir.path + "/" + vehicleTypeFile);
    if (file.existsSync()) {
      var jsonData = file.readAsStringSync();
      var vehicleTypesObjJson = jsonDecode(jsonData)['vehicleTypes'] as List;
      List<VehicleTypeElement> vehicleTypesObj = vehicleTypesObjJson
          .map((vehicleTypesJson) =>
              VehicleTypeElement.fromJson(vehicleTypesJson))
          .toList();
      log("Load vehicle type data from cache");
      return vehicleTypesObj;
    } else {
      final response = await _helper.postBase(
          Base(
              requestId: requestId,
              requestTime: requestTime,
              deviceName: deviceName,
              channel: channel),
          "/api/getvehicletypelist");
      if (jsonDecode(response)['resultCode'] == "10005") {
        file.writeAsStringSync(response.toString(),
            flush: true, mode: FileMode.write);
        var vehicleTypesObjJson = jsonDecode(response)['vehicleTypes'] as List;
        List<VehicleTypeElement> vehicleTypesObj = vehicleTypesObjJson
            .map((vehicleTypesJson) =>
                VehicleTypeElement.fromJson(vehicleTypesJson))
            .toList();
        log("Load vehicle type data from api");
        return vehicleTypesObj;
      } else {
        log(AppError().error(jsonDecode(response)[obj.errorCode]));
      }
    }
  }

  Future<void> generateOTP(String phoneNumber, String type) async {
    final response = await _helper.postGenerateOTP(
        GenerateOtp(
            requestId: requestId,
            requestTime: requestTime,
            deviceName: deviceName,
            channel: channel,
            phone: phoneNumber,
            transactionType: type),
        stConstant.apiGenerateOTP);
    if (jsonDecode(response)[obj.resultCode] == code.success) {
      log(jsonDecode(response)[obj.resultMessage]);
    } else  {
      log(AppError().error(jsonDecode(response)[obj.errorCode]));
    }
  }

  Future<CustomerInfo> fetchCustomInfo(bool status) async {
    var dir = await getTemporaryDirectory();
    file = new File(dir.path + "/" + customInfoFile);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getInt('id').toString();
    if (status == true) {
      final response = await _helper.getCustomerInfo(
          Base(
              requestId: requestId,
              requestTime: requestTime,
              deviceName: deviceName,
              channel: channel),
          stConstant.apiGetcustomer + "/$id");
      if (jsonDecode(response)[obj.resultCode] == code.success) {
        file.writeAsStringSync(response.toString(),
            flush: true, mode: FileMode.write);
        CustomerInfo customerObjJson =
            CustomerInfo.fromJson(jsonDecode(response));
        log(jsonDecode(response)[obj.resultMessage]);
        return customerObjJson;
      } else {
        log(AppError().error(jsonDecode(response)[obj.errorCode]));
      }
    } else if (status == false) {
      var jsonData = file.readAsStringSync();
      CustomerInfo customerObjJson =
          CustomerInfo.fromJson(jsonDecode(jsonData));
      log('Load custom info from cache');
      return customerObjJson;
    }
  }

  Future<ResponseQuestion> customerQuestion(String phoneNumber) async {
    final response = await _helper.customerQuestions(
        CustomerQuestion(
            requestId: requestId,
            requestTime: requestTime,
            deviceName: deviceName,
            channel: channel,
            phone: phoneNumber),
        stConstant.apiCustomerQuestions);
    if (jsonDecode(response)[obj.resultCode] == code.success) {
      ResponseQuestion quesObjJson =
          ResponseQuestion.fromJson(jsonDecode(response));
      log(jsonDecode(response)[obj.resultMessage]);
      return quesObjJson;
    } else {
      log(AppError().error(jsonDecode(response)[obj.errorCode]));
    }
  }
}
