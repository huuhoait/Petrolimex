import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:petrolimex/constants/stConstant.dart';
import 'package:petrolimex/helper/app_exception.dart';
import 'package:petrolimex/models/Base.dart';
import 'package:petrolimex/models/ChangePassword.dart';
import 'package:petrolimex/models/CustomerQuestions.dart';
import 'package:petrolimex/models/CustomerUpdate.dart';
import 'package:petrolimex/models/Login.dart';
import 'package:petrolimex/models/OTP.dart';
import 'package:petrolimex/models/Register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiBaseHelper{
  final String _baseUrl = STConstant.BASE_URL;
  final headers = STConstant().requestHeaders;
  File file;

  Future<dynamic> postBase(Base _base, String url) async{
    var responseJson;
    try{
      final Response response = await http.post( Uri.parse(_baseUrl + url),headers: headers,body: jsonEncode(_base.toJson()));
      responseJson = _returnResponse(response);
    } on SocketException {
     throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 400:
      case 401:
      case 404:
        return response.body.toString();
      case 500:
        throw InternalServerException();
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  Future<dynamic> postGenerateOTP(GenerateOtp _generateOtp, String url) async{
    var responseJson;
    try{
      final Response response = await http.post( Uri.parse(_baseUrl + url),headers: headers,body: jsonEncode(_generateOtp.toJson()));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postVerifyOtp(ValidateOtp _validateOtp, String url) async{
    var responseJson;
    try{
      final Response response = await http.post( Uri.parse(_baseUrl + url),headers: headers,body: jsonEncode(_validateOtp.toJson()));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> register(Register _register, String url) async{
    var responseJson;
    try{
      final Response response = await http.post( Uri.parse(_baseUrl + url),headers: headers,body: jsonEncode(_register.toJson()));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> login(Login _login, String url) async{
    var responseJson;
    try{
      final Response response = await http.post( Uri.parse(_baseUrl + url),headers: headers,body: jsonEncode(_login.toJson()));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> getCustomerInfo(Base _base, String url) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    Map<String, String> requestHeadersAuth = {
      'Content-type': 'application/json',
      'Accept': 'text/plain',
      'Authorization': 'Bearer $token'
    };
    var responseJson;
    try{
      final Response response = await http.post( Uri.parse(_baseUrl + url),headers: requestHeadersAuth,body: jsonEncode(_base.toJson()));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> update(CustomerUpdate _update, String url) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('id');
    var responseJson;
    try{
      final Response response = await http.post( Uri.parse(_baseUrl + url+"/$id"),headers: headers,body: jsonEncode(_update.toJson()));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> customerQuestions(CustomerQuestion _cusQes, String url) async{
    var responseJson;
    try{
      final Response response = await http.post( Uri.parse(_baseUrl + url),headers: headers,body: jsonEncode(_cusQes.toJson()));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> customerAnswer(CustomerAnswer _cusAnS, String url) async{
    var responseJson;
    try{
      final Response response = await http.post( Uri.parse(_baseUrl + url),headers: headers,body: jsonEncode(_cusAnS.toJson()));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> changePassword(ChangePassword changePassword, String url) async{
    var dir = await getTemporaryDirectory();
    file = new File(dir.path + "/" + "token.json");
    var jsonData = file.readAsStringSync();
    String token = jsonDecode(jsonData)["token"];
    Map<String, String> requestHeadersAuth = {
      'Content-type': 'application/json',
      'Accept': 'text/plain',
      'Authorization': 'Bearer $token'
    };
    var responseJson;
    try{
      final Response response = await http.post( Uri.parse(_baseUrl + url),headers: requestHeadersAuth,body: jsonEncode(changePassword.toJson()));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

}