import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:petrolimex/constants/stConstant.dart';
import 'package:petrolimex/helper/api_base.dart';
import 'package:petrolimex/helper/app_error.dart';
import 'package:petrolimex/helper/app_localizations.dart';
import 'package:petrolimex/helper/format.dart';
import 'package:petrolimex/helper/hashPassword.dart';
import 'package:petrolimex/helper/validation.dart';
import 'package:petrolimex/models/Login.dart';
import 'package:petrolimex/models/OTP.dart';
import 'package:petrolimex/models/Register.dart';
import 'package:petrolimex/models/Response.dart';
import 'package:petrolimex/services/api_service.dart';
import 'package:petrolimex/utils/DeviceInfo.dart';
import 'package:petrolimex/utils/StringUtil.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterViewModel {
  final requestId = StringUtil.generateUUID();
  final requestTime = Format().f.format(DateTime.now());
  final deviceName = DeviceInfo().getPhoneInfo().toString();
  final channel = STConstant.channel;
  final code = STConstant();
  final api = STConstant();
  final obj = STConstant();
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<void> verifyOtp(BuildContext context, String phoneNumber, String password, String otp,
      Register regis, PageController pageController, int pageChanged) async {
    ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    await pr.show();
    pr.update(message: AppLocalizations.of(context).translate('msg_loading'));
    final response = await _helper.postVerifyOtp(
        ValidateOtp(
            requestId: requestId,
            requestTime: requestTime,
            deviceName: deviceName,
            channel: channel,
            phone: phoneNumber,
            otpCode: otp),
        api.apiValidateotp);
    if (jsonDecode(response)[obj.resultCode] == code.authValidOTP) {
      log(jsonDecode(response)[obj.resultMessage]);
      register(context, regis, pageController, pageChanged, phoneNumber, password);
    }
    else{
      log(AppError().error(jsonDecode(response)[obj.errorCode]));
      await pr.hide();
      Fluttertoast.showToast(
          msg: AppError().error(jsonDecode(response)[obj.errorCode]),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    }
  }

  Future<void> register(BuildContext context, Register register,
      PageController pageController, int pageChanged, String phoneNumber, String password) async {
    ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    final response = await _helper.register(
        register, api.apiRegister);
    if (jsonDecode(response)[obj.resultCode] == code.registerSuccess) {
      login(phoneNumber, password);
      pageController.animateToPage(++pageChanged,
          duration: Duration(milliseconds: 5), curve: Curves.bounceInOut);
      await pr.hide();
      Fluttertoast.showToast(
          msg: jsonDecode(response)[obj.resultMessage],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    }
    else {
      await pr.hide();
      Fluttertoast.showToast(
          msg: AppError().error(jsonDecode(response)[obj.errorCode]),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
      pageController.animateToPage(pageChanged,
          duration: Duration(milliseconds: 10), curve: Curves.bounceInOut);
      return jsonDecode(response)[obj.errorMessage];
    }
  }

  bool confirmPass(BuildContext context, String pass, String conPass) {
    if (Validation.confirmPass(pass, conPass) != true) {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context).translate('msg_confirm_pass'),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
      return false;
    }
    return true;
  }

  bool checkNullValue(BuildContext context, String value, String msg) {
    if (Validation.checkNullValue(value) != false) {
      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
      return false;
    }
    return true;
  }

  bool checkEmptyValue(BuildContext context, String value, String msg) {
    if (Validation.checkNullValue(value) != false) {
      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
      return false;
    }
    return true;
  }

  bool compareValue(
      BuildContext context, String value1, String value2, String msg) {
    if (Validation.compareValue(value1, value2) != false) {
      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
      return false;
    }
    return true;
  }

  checkData() async {
    String staticFile = "staticlist.json";
    var dir = await getTemporaryDirectory();
    File file = new File(dir.path + "/" + staticFile);
    if(!file.existsSync()){
     ApiService().fetchData() ;
    }
  }

  Future<void> login(String phoneNumber, String password) async {
    var client = Client();
    String hashedPassword = HasPassword().hasPassword(password);
    try {
      final response = await _helper.login(
          Login(
              requestId: requestId,
              requestTime: requestTime,
              deviceName: deviceName,
              channel: channel,
              phone: phoneNumber,
              password: hashedPassword),
          api.apiLogin);
      if (jsonDecode(response)[obj.resultCode] == code.authSuccessLogin) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final name = loginSuccessFromJson(response).customer.name;
        final id = loginSuccessFromJson(response).customer.id;
        final token = loginSuccessFromJson(response).token;
        await prefs.setString('name', name);
        await prefs.setString('session', 'logged');
        await prefs.setInt('id', id);
        await prefs.setString('token', token);
        log(jsonDecode(response)[obj.resultMessage]);
      } else {
        Fluttertoast.showToast(
            msg: AppError().error(jsonDecode(response)[obj.errorCode]),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
        log(AppError().error(jsonDecode(response)[obj.errorCode]));
      }
    } on TimeoutException catch(_){
    }
    finally{
      client.close();
    }
  }
}
