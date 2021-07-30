import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:petrolimex/constants/stConstant.dart';
import 'package:petrolimex/helper/app_localizations.dart';
import 'package:petrolimex/helper/validation.dart';
import 'package:petrolimex/services/api_service.dart';
import 'package:petrolimex/viewModels/forgot_password_viewModel.dart';
import 'package:petrolimex/viewModels/register_viewModel.dart';
import 'package:petrolimex/widgets/appBarWidget.dart';
import 'package:petrolimex/widgets/bottomNavigationBarWidget.dart';
import 'package:petrolimex/widgets/drawerWidget.dart';
import 'package:petrolimex/widgets/floatingActionButtonWidget.dart';
import 'package:petrolimex/widgets/labelWidget.dart';
import 'package:petrolimex/widgets/pinNumberWidget.dart';
import 'package:petrolimex/widgets/textFieldWidget.dart';
import 'package:petrolimex/widgets/titleWidget.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({Key key}) : super(key: key);

  final phoneCon = TextEditingController();

  RegisterViewModel regis = RegisterViewModel();

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
                AppLocalizations.of(context).translate('forgot_password_title'),
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
              SizedBox(height: 35),
              Text(
                AppLocalizations.of(context)
                    .translate('description_get_phoneNumber'),
                style: TextStyle(
                  color: Color(0xff454f5b),
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
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
                          ? AppLocalizations.of(context)
                              .translate('msg_valid_phone')
                          : null,
                  errorStyle: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
              SizedBox(height: 25),
              RaisedButton(
                elevation: 5,
                onPressed: () {
                  phoneCon.text.length != 0 ?
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChooseRecovery(phoneNumber: phoneCon.text,
                              ))): Fluttertoast.showToast(
                          msg: "Vui lòng nhập số điện thoai",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM);
                    },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: Color(0xffffc20e),
                child: Text(
                  AppLocalizations.of(context)
                      .translate('btn_password_retrieval'),
                  style: TextStyle(
                    color: Color(0xff454f5b),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  AppLocalizations.of(context)
                      .translate('text_btn_back_signIn'),
                  style: TextStyle(
                    color: Color(0xff1890ff),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
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
}

class ChooseRecovery extends StatefulWidget {
  ChooseRecovery({Key key, @required this.phoneNumber}) : super(key: key);
  String phoneNumber;

  @override
  _ChooseRecoveryState createState() => _ChooseRecoveryState();
}

class _ChooseRecoveryState extends State<ChooseRecovery> {
  int _selectedRadio;
  final stConstant = STConstant();

  @override
  void initState() {
    super.initState();
    _selectedRadio = 1;
  }

  setSelectedRadio(int val) {
    setState(() {
      _selectedRadio = val;
    });
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
                AppLocalizations.of(context).translate('forgot_password_title'),
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
              SizedBox(height: 35),
              Text(
                AppLocalizations.of(context)
                        .translate('description_choose_recovery') +
                    widget.phoneNumber,
                style: TextStyle(
                  color: Color(0xff454f5b),
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Radio(
                      value: 1,
                      groupValue: _selectedRadio,
                      activeColor: Color(0xffffc20e),
                      onChanged: (val) {
                        setSelectedRadio(val);
                      }),
                  Text(
                    AppLocalizations.of(context)
                        .translate('hintText_phoneNumber'),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 40.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '(Chúng tôi sẽ gửi mã OTP đến số điện thoại đã đăng ký PLX ID của bạn)',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Radio(
                      value: 2,
                      groupValue: _selectedRadio,
                      activeColor: Color(0xffffc20e),
                      onChanged: (val) {
                        setSelectedRadio(val);
                      }),
                  Text(
                    AppLocalizations.of(context).translate('rd_answer'),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 40.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '(Trả lời các câu hỏi bảo mật khi tạo PLX ID)',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    elevation: 5,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    color: Color(0xffEAEEF2),
                    child: Text(
                      AppLocalizations.of(context).translate('come_back'),
                      style: TextStyle(
                        color: Color(0xff454f5b),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(width: 20.0),
                  RaisedButton(
                    elevation: 5,
                    onPressed: () {
                      if(_selectedRadio == 1)
                        {
                          ApiService().generateOTP(widget.phoneNumber, stConstant.changePassword);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => VerifyOTP(
                                    phoneNumber: widget.phoneNumber,
                                  )));
                        }
                      else if(_selectedRadio == 2)
                        {
                           Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AnswerSecretQuestion(phoneNumber: widget.phoneNumber,)));
                        }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    color: Color(0xffffc20e),
                    child: Text(
                      AppLocalizations.of(context).translate('next'),
                      style: TextStyle(
                        color: Color(0xff454f5b),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
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
}

class AnswerSecretQuestion extends StatelessWidget {
  String phoneNumber;
  AnswerSecretQuestion({Key key, this.phoneNumber}) : super(key: key);

  final answer1Con = new TextEditingController();
  final answer2Con = new TextEditingController();
  int questID1;
  int questID2;

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
            begin: Alignment.center,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffFFF9E5),
              Color(0xffFFECB3),
            ],
          ),
        ),
        child: Stack(
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/banner_1.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 1.0,
              maxChildSize: 1.0,
              minChildSize: 1.0,
              builder: (context, scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0, top: 80.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 15,
                            spreadRadius: 5,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          Text(
                            AppLocalizations.of(context)
                                .translate('title_answer_secret_question'),
                            style: TextStyle(
                              color: Color(0xff212B36),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            AppLocalizations.of(context)
                                .translate('obligatory'),
                            style: TextStyle(
                              color: Color(0xffeb2629),
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 25),
                          FutureBuilder(
                              future: ApiService().customerQuestion(phoneNumber),
                              builder: (BuildContext context, AsyncSnapshot snapshot){
                                if(snapshot.hasData){
                                  questID1 = int.parse(snapshot.data.questions[0].value);
                                  questID2 = int.parse(snapshot.data.questions[1].value);
                                }
                                  return snapshot.hasData? Container(
                                    margin: EdgeInsets.symmetric(horizontal: 20),
                                    child: Column(
                                      children: [
                                        NewLabel().build(context,
                                            title: snapshot.data.questions[0].display,
                                            fontWeight: FontWeight.w600,
                                            isRequire: true),
                                        NewTextField().build(context,
                                            hintText: AppLocalizations.of(context)
                                                .translate('hint_answer'),
                                            controller: answer1Con),
                                        NewLabel().build(context,
                                            title: snapshot.data.questions[1].display,
                                            fontWeight: FontWeight.w600,
                                            isRequire: true),
                                        NewTextField().build(context,
                                            hintText: AppLocalizations.of(context)
                                                .translate('hint_answer'),
                                            controller: answer2Con),
                                      ],
                                    ),
                                  ):CircularProgressIndicator();
                              }),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RaisedButton(
                                elevation: 5,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                color: Color(0xffEAEEF2),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('come_back'),
                                  style: TextStyle(
                                    color: Color(0xff454f5b),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(width: 20.0),
                              RaisedButton(
                                elevation: 5,
                                onPressed: () {
                                  ForgotPasswordViewModel().customerAnswer(context, phoneNumber, questID1, questID2, answer1Con.text, answer2Con.text);
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (context) => InputNewPassword()));
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                color: Color(0xffffc20e),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('next'),
                                  style: TextStyle(
                                    color: Color(0xff454f5b),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30.0),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
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
}

class VerifyOTP extends StatefulWidget {
  String phoneNumber;


  VerifyOTP({Key key, this.phoneNumber}) : super(key: key);

  @override
  _VerifyOTPState createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  bool disable = false;
  bool isTimerTextShown = false;
  final stConstant = STConstant();

  CountDownController _countdownController = CountDownController();
  ForgotPasswordViewModel forgotten = ForgotPasswordViewModel();
  TextEditingController pinCon = TextEditingController();
  String otp;

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
            begin: Alignment.center,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffFFF9E5),
              Color(0xffFFECB3),
            ],
          ),
        ),
        child: Stack(
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/banner_1.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 1.0,
              maxChildSize: 1.0,
              minChildSize: 1.0,
              builder: (context, scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0, top: 80.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 15,
                            spreadRadius: 5,
                          )
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            SizedBox(height: 20.0),
                            Text(
                              AppLocalizations.of(context)
                                  .translate('customer_authentication'),
                              style: TextStyle(
                                color: Color(0xff454f5b),
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              AppLocalizations.of(context)
                                  .translate('obligatory'),
                              style: TextStyle(
                                color: Color(0xffeb2629),
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Text(
                              AppLocalizations.of(context)
                                      .translate('describe_otp') +
                                  widget.phoneNumber +
                                  AppLocalizations.of(context)
                                      .translate('describe_otp1'),
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context)
                                      .translate('input_otp'),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '*',
                                  style: TextStyle(
                                    color: Color(0xffeb2629),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            PinCodeFields(
                              length: 6,
                              fieldBorderStyle: FieldBorderStyle.Square,
                              responsive: false,
                              fieldHeight:40.0,
                              fieldWidth: 40.0,
                              borderWidth:1.0,
                              activeBorderColor: Colors.black,
                              activeBackgroundColor: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              keyboardType: TextInputType.number,
                              autoHideKeyboard: false,
                              fieldBackgroundColor: Colors.white,
                              borderColor: Colors.black38,
                              textStyle: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                              onComplete: (output) {
                                // Your logic with pin code
                                 otp = output;
                              },
                            ),
                            SizedBox(height: 30),
                            Text(
                              AppLocalizations.of(context)
                                  .translate('describe_otp2'),
                            ),
                            disable
                                ? TextButton(
                                    onPressed: () {
                                      setState(() {
                                        disable = false;
                                        isTimerTextShown = !isTimerTextShown;
                                        _countdownController.restart(
                                            duration: 60);
                                        ApiService().generateOTP(widget.phoneNumber, stConstant.changePassword);
                                      });
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('btn_resend_otp'),
                                      style: TextStyle(
                                        color: Color(0xff1890ff),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )
                                : TextButton(
                                    onPressed: null,
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('btn_resend_otp'),
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                            CircularCountDownTimer(
                              duration: 60,
                              initialDuration: 0,
                              controller: _countdownController,
                              width: MediaQuery.of(context).size.width / 6,
                              height: MediaQuery.of(context).size.height / 12,
                              fillColor: Colors.transparent,
                              ringColor: Colors.transparent,
                              textFormat: CountdownTextFormat.MM_SS,
                              isTimerTextShown: !isTimerTextShown,
                              isReverse: true,
                              autoStart: true,
                              textStyle: TextStyle(color: Colors.red),
                              onComplete: () {
                                setState(() {
                                  disable = true;
                                  isTimerTextShown = !isTimerTextShown;
                                });
                              },
                            ),
                            RaisedButton(
                              elevation: 5,
                              onPressed: () {
                                otp.length>0?
                                forgotten.verifyOtp(context,widget.phoneNumber,otp):
                                Fluttertoast.showToast(
                                    msg: "Vui lòng nhập mã OTP",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM);
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => InputNewPassword()));
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              color: Color(0xffffc20e),
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('btn_confirm'),
                                style: TextStyle(
                                  color: Color(0xff454f5b),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
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
}

class InputNewPassword extends StatefulWidget {
  const InputNewPassword({Key key}) : super(key: key);

  @override
  _InputNewPasswordState createState() => _InputNewPasswordState();
}

class _InputNewPasswordState extends State<InputNewPassword> {

  final newPass = new TextEditingController();
  final confirmNewPass = new TextEditingController();
  ForgotPasswordViewModel forgotten = ForgotPasswordViewModel();

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
            begin: Alignment.center,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffFFF9E5),
              Color(0xffFFECB3),
            ],
          ),
        ),
        child: Stack(
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/banner_1.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 1.0,
              maxChildSize: 1.0,
              minChildSize: 1.0,
              builder: (context, scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0, top: 80.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 15,
                            spreadRadius: 5,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          Text(
                            AppLocalizations.of(context)
                                .translate('title_input_password'),
                            style: TextStyle(
                              color: Color(0xff212B36),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 25),
                          Text(
                            AppLocalizations.of(context)
                                .translate('obligatory'),
                            style: TextStyle(
                              color: Color(0xffeb2629),
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 30),
                          Text(
                            AppLocalizations.of(context)
                                .translate('describe_input_password'),
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)
                                    .translate('title_input_password'),
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '*',
                                style: TextStyle(
                                  color: Color(0xffeb2629),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 25),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                NewTextField().build(context,
                                    isPassword: true,
                                    hintText: AppLocalizations.of(context)
                                        .translate('password'),
                                    controller: newPass),
                                SizedBox(height: 20),
                                NewTextField().build(context,
                                    isPassword: true,
                                    hintText: AppLocalizations.of(context)
                                        .translate('confirm_password'),
                                    controller: confirmNewPass),
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
                          RaisedButton(
                            elevation: 5,
                            onPressed: () {
                              forgotten.changePassword(context, newPass.text, confirmNewPass.text);
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            color: Color(0xffffc20e),
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('btn_confirm'),
                              style: TextStyle(
                                color: Color(0xff454f5b),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(height: 30.0),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
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
}

class Success extends StatelessWidget {
  const Success({Key key}) : super(key: key);

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
            begin: Alignment.center,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffFFF9E5),
              Color(0xffFFECB3),
            ],
          ),
        ),
        child: Stack(
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/banner_1.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 1.0,
              maxChildSize: 1.0,
              minChildSize: 1.0,
              builder: (context, scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 20.0, top: 80.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin:
                      EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color:
                            Colors.black.withOpacity(0.3),
                            blurRadius: 15,
                            spreadRadius: 5,
                          )
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Container(
                              child: Padding(
                                padding:
                                EdgeInsets.only(top: 30.0),
                                child: Image(
                                  image: AssetImage(
                                      'assets/success.png'),
                                  width: 200.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              AppLocalizations.of(context)
                                  .translate('title_success'),
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              AppLocalizations.of(context)
                                  .translate(
                                  'sub_title_change_password_success'),
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            RaisedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.of(context).pushNamed("/SignIn");
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(5),
                              ),
                              color: Color(0xffffc20e),
                              child: Text(
                                'Đăng nhập',
                                style: TextStyle(
                                  color: Color(0xff454f5b),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
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
}


