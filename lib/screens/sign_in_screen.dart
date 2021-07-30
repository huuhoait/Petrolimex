
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:petrolimex/helper/app_localizations.dart';
import 'package:petrolimex/helper/format.dart';
import 'package:petrolimex/helper/validation.dart';
import 'package:petrolimex/screens/forgot_password.dart';
import 'package:petrolimex/utils/DeviceInfo.dart';
import 'package:petrolimex/utils/StringUtil.dart';
import 'package:petrolimex/viewModels/login_viewModel.dart';
import 'package:petrolimex/widgets/appBarWidget.dart';
import 'package:petrolimex/widgets/bottomNavigationBarWidget.dart';
import 'package:petrolimex/widgets/drawerWidget.dart';
import 'package:petrolimex/widgets/floatingActionButtonWidget.dart';

class SignIn extends StatefulWidget {
   const SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isRememberMe = false;

  final phoneCon = TextEditingController();
  final passCon = TextEditingController();

  final loginViewModel = LoginViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      appBar: newAppBar(context),
      drawer: Drawer(
        child: NewDrawer(
          onOff: true,
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffFFF9E5),
              Color(0xffFFECB3),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 70,
          ),
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context).translate('login_title'),
                style: TextStyle(
                  color: Color(0xff454f5b),
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                AppLocalizations.of(context).translate('login_subTitle'),
                style: TextStyle(
                  color: Color(0xffffc20e),
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: phoneCon,
                cursorColor: Colors.grey,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  hintText: AppLocalizations.of(context)
                      .translate('hintText_phoneNumber'),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  contentPadding: EdgeInsets.only(left: 10),
                  errorText: phoneCon.text.length == 0
                      ? null
                      : !Validation.validationPhone(phoneCon.text)
                      ? AppLocalizations.of(context).translate('msg_valid_phone')
                      : null,
                  errorStyle: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: passCon,
                cursorColor: Colors.grey,
                obscureText: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  hintText: AppLocalizations.of(context)
                      .translate('hintText_password'),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  contentPadding: EdgeInsets.only(left: 10),
                  errorText: passCon.text.length == 0
                      ? null
                      : !Validation.validationPass(passCon.text)
                      ? AppLocalizations.of(context).translate('msg_valid_pass')
                      : null,
                  errorStyle: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
              buildRememberCb(),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // Navigator.of(context).pop();
                  // Navigator.pushNamed(context, onPressed);
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgotPassword()));
                },
                child: Text(
                  AppLocalizations.of(context)
                      .translate('text_btn_forgot_password'),
                  style: TextStyle(
                    color: Color(0xff1890ff),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 5.0),
              RaisedButton(
                elevation: 5,
                onPressed: () {
                  loginViewModel.savePref(
                      isRememberMe, phoneCon.text, passCon.text);
                  if (Validation.validationPhone(phoneCon.text) != true)
                    Fluttertoast.showToast(
                        msg:
                        AppLocalizations.of(context).translate('msg_login'),
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM);
                  if (Validation.validationPass(passCon.text) != true)
                    Fluttertoast.showToast(
                        msg:
                        AppLocalizations.of(context).translate('msg_login'),
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM);
                  else if (Validation.validationPhone(phoneCon.text) == true &&
                      Validation.validationPass(passCon.text) == true) {
                    loginViewModel.login(
                        context,
                        phoneCon.text,
                        passCon.text);
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: Color(0xffffc20e),
                child: Text(
                  AppLocalizations.of(context).translate('btn_login'),
                  style: TextStyle(
                    color: Color(0xff454f5b),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context).translate('dont_have_account'),
                    style: TextStyle(
                      color: Color(0xff454f5b),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 1.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.pushNamed(context, '/SignUp');
                      },
                      child: Text(
                        AppLocalizations.of(context)
                            .translate('text_btn_register'),
                        style: TextStyle(
                          color: Color(0xff1890ff),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: !keyboardIsOpen,
        child: NewFloatingActionButton(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: NewBottomNavigationBar(),
    );
  }

  Widget buildRememberCb() {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Color(0xffffc20e),
      value: isRememberMe,
      title: Text(
        AppLocalizations.of(context).translate('remember_me'),
        style: TextStyle(
          color: Color(0xff454f5b),
          fontWeight: FontWeight.w500,
        ),
      ),
      onChanged: (value) {
        setState(() {
          isRememberMe = value;
        });
      },
      contentPadding: EdgeInsets.only(left: 0.0),
    );
  }
}
