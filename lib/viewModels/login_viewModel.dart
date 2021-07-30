import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:petrolimex/constants/stConstant.dart';
import 'package:petrolimex/helper/api_base.dart';
import 'package:petrolimex/helper/app_error.dart';
import 'package:petrolimex/helper/app_localizations.dart';
import 'package:petrolimex/helper/format.dart';
import 'package:petrolimex/helper/hashPassword.dart';
import 'package:petrolimex/models/Login.dart';
import 'package:petrolimex/models/Response.dart';
import 'package:petrolimex/screens/sign_in_screen.dart';
import 'package:petrolimex/utils/DeviceInfo.dart';
import 'package:petrolimex/utils/StringUtil.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel {
  ApiBaseHelper _helper = ApiBaseHelper();
  final requestId = StringUtil.generateUUID();
  final requestTime = Format().f.format(DateTime.now());
  final deviceName = DeviceInfo().getPhoneInfo().toString();
  final channel = STConstant.channel;
  final code = STConstant();
  final api = STConstant();
  final obj = STConstant();
  Timer _authTimer;

  Future<void> login(
      BuildContext context, String phoneNumber, String password) async {
    ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    await pr.show();
    pr.update(message: AppLocalizations.of(context).translate('msg_loading'));
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
        await pr.hide();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final name = loginSuccessFromJson(response).customer.name;
        final id = loginSuccessFromJson(response).customer.id;
        final token = loginSuccessFromJson(response).token;
        await prefs.setString('name', name);
        await prefs.setString('session', 'logged');
        await prefs.setInt('id', id);
        await prefs.setString('token', token);
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed('/Home');
        Fluttertoast.showToast(
            msg: AppLocalizations.of(context).translate('msg_login_success'),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
        log(jsonDecode(response)[obj.resultMessage]);
      } else {
        await pr.hide();
        Fluttertoast.showToast(
            msg: AppError().error(jsonDecode(response)[obj.errorCode]),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
        log(AppError().error(jsonDecode(response)[obj.errorCode]));
      }
    } on TimeoutException catch (_) {
      await pr.hide();
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)
              .translate('msg_login_TimeoutException'),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    } finally {
      client.close();
    }
  }

  Future<void> savePref(bool value, String phoneNumber, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value) {
      await prefs.setString('phoneNumber', phoneNumber);
      await prefs.setString('password', password);
    } else {
      await prefs.remove('phoneNumber');
      await prefs.remove('password');
    }

  }
}
