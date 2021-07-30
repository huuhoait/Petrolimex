import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:petrolimex/constants/stConstant.dart';
import 'package:petrolimex/helper/api_base.dart';
import 'package:petrolimex/helper/app_error.dart';
import 'package:petrolimex/helper/app_localizations.dart';
import 'package:petrolimex/helper/format.dart';
import 'package:petrolimex/models/CustomerInfo.dart';
import 'package:petrolimex/models/CustomerUpdate.dart';
import 'package:petrolimex/models/OTP.dart';
import 'package:petrolimex/utils/DeviceInfo.dart';
import 'package:petrolimex/utils/StringUtil.dart';
import 'package:progress_dialog/progress_dialog.dart';

class UpdateViewModel {
  final requestId = StringUtil.generateUUID();
  final requestTime = Format().f.format(DateTime.now());
  final deviceName = DeviceInfo().getPhoneInfo().toString();
  final channel = STConstant.channel;
  final code = STConstant();
  final api = STConstant();
  final obj = STConstant();
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<void> verifyOtp(BuildContext context, String phoneNumber, String otp, CustomerUpdate _update,
      PageController pageController,
      int pageChanged) async {
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
      await pr.hide();
      log(jsonDecode(response)[obj.resultMessage]);
      update(context, _update, pageController, pageChanged);
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

  Future<void> update(BuildContext context, CustomerUpdate update,
      PageController pageController, int pageChanged) async {
    ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    final response = await _helper.update(
        update, api.apiUpdate);
    if (jsonDecode(response)[obj.resultCode] == code.updateSuccess) {
      pageController.animateToPage(++pageChanged,
          duration: Duration(milliseconds: 5), curve: Curves.bounceInOut);
      await pr.hide();
      Fluttertoast.showToast(
          msg: jsonDecode(response)[obj.resultMessage],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    }
    else {
      log(AppError().error(jsonDecode(response)[obj.errorCode]));
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
}



