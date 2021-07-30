import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:petrolimex/constants/stConstant.dart';
import 'package:petrolimex/helper/api_base.dart';
import 'package:petrolimex/helper/app_error.dart';
import 'package:petrolimex/helper/app_localizations.dart';
import 'package:petrolimex/helper/format.dart';
import 'package:petrolimex/helper/hashPassword.dart';
import 'package:petrolimex/models/ChangePassword.dart';
import 'package:petrolimex/models/CustomerQuestions.dart';
import 'package:petrolimex/models/OTP.dart';
import 'package:petrolimex/screens/forgot_password.dart';
import 'package:petrolimex/utils/DeviceInfo.dart';
import 'package:petrolimex/utils/StringUtil.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ForgotPasswordViewModel{
  final requestId = StringUtil.generateUUID();
  final requestTime = Format().f.format(DateTime.now());
  final deviceName = DeviceInfo().getPhoneInfo().toString();
  final channel = STConstant.channel;
  final code = STConstant();
  final api = STConstant();
  final obj = STConstant();
  ApiBaseHelper _helper = ApiBaseHelper();
  String token = "token.json";
  File file;

  Future<void> verifyOtp(BuildContext context, String phoneNumber, String otp) async {
    ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    await pr.show();
    pr.update(message: "Đang xác thực");
    final response = await _helper.postVerifyOtp(
        ValidateOtp(
            requestId: requestId,
            requestTime: requestTime,
            deviceName: deviceName,
            channel: channel,
            phone: phoneNumber,
            otpCode: otp),
        api.apiCusValidateotp);
    if (jsonDecode(response)[obj.resultCode] == code.authValidOTP) {
      await pr.hide();
      var dir = await getTemporaryDirectory();
      file = new File(dir.path + "/" + token);
      file.writeAsStringSync(response.toString(),
          flush: true, mode: FileMode.write);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => InputNewPassword()));
    }
    else {
      log(AppError().error(jsonDecode(response)[obj.errorCode]));
      await pr.hide();
      Fluttertoast.showToast(
          msg: AppError().error(jsonDecode(response)[obj.errorCode]),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    }
  }

  Future<void> changePassword(BuildContext context, String newPass, String confirmNewPass) async {
    ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    await pr.show();
    pr.update(message: AppLocalizations.of(context).translate('msg_loading'));
    final response = await _helper.changePassword(
        ChangePassword(
            requestId: requestId,
            requestTime: requestTime,
            deviceName: deviceName,
            channel: channel,
            newPassword: HasPassword().hasPassword(newPass),
            confirmNewPassword: HasPassword().hasPassword(confirmNewPass),),
        api.apiChangePassword);
    if (jsonDecode(response)[obj.resultCode] == code.changePasswordSuccess) {
      await pr.hide();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => Success(),
        ),
            (route) => false,
      );
      var dir = await getApplicationSupportDirectory();
      dir.deleteSync(recursive: true);
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

  Future<void> customerAnswer(BuildContext context, String phoneNumber, int questionId1, int questionId2, String answer1, String answer2) async {
    ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    await pr.show();
    pr.update(message: AppLocalizations.of(context).translate('msg_loading'));
    final response = await _helper.customerAnswer(
        CustomerAnswer(
            requestId: requestId,
            requestTime: requestTime,
            deviceName: deviceName,
            channel: channel,
            phone: phoneNumber,
            questionId1: questionId1,
            answer1: answer2,
            questionId2: questionId2,
            answer2: answer2),
        api.apiCustomerAnswer);
    if (jsonDecode(response)[obj.resultCode] == code.success) {
      await pr.hide();
      var dir = await getTemporaryDirectory();
      file = new File(dir.path + "/" + token);
      file.writeAsStringSync(response.toString(),
          flush: true, mode: FileMode.write);
      Navigator.pop(context);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => InputNewPassword()));
    }
    else{
      log(AppError().error(jsonDecode(response)[obj.errorCode]));
      await pr.hide();
      Fluttertoast.showToast(
          msg: jsonDecode(response)[obj.errorMessage],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    }
  }
}