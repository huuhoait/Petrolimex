import 'dart:core';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:petrolimex/constants/stConstant.dart';
import 'package:petrolimex/helper/app_localizations.dart';
import 'package:petrolimex/helper/format.dart';
import 'package:petrolimex/helper/hashPassword.dart';
import 'package:petrolimex/helper/validation.dart';
import 'package:petrolimex/models/Base.dart';
import 'package:petrolimex/models/District.dart';
import 'package:petrolimex/models/OTP.dart';
import 'package:petrolimex/models/Register.dart' ;
import 'package:petrolimex/models/Static.dart';
import 'package:petrolimex/models/VehicleType.dart';
import 'package:petrolimex/models/Ward.dart';
import 'package:petrolimex/screens/home_screen.dart';
import 'package:petrolimex/screens/qr_screen.dart';
import 'package:petrolimex/services/api_service.dart';
import 'package:petrolimex/utils/DeviceInfo.dart';
import 'package:petrolimex/utils/StringUtil.dart';
import 'package:petrolimex/viewModels/register_viewModel.dart';
import 'package:petrolimex/widgets/appBarWidget.dart';
import 'package:petrolimex/widgets/bottomNavigationBarWidget.dart';
import 'package:petrolimex/widgets/drawerWidget.dart';
import 'package:petrolimex/widgets/floatingActionButtonWidget.dart';
import 'package:petrolimex/widgets/labelWidget.dart';
import 'package:petrolimex/widgets/textFieldWidget.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  int _selectedRadio;
  int pageChanged = 0;
  int pageChanged1 = 0;
  PageController pageController = PageController(initialPage: 0);
  PageController pageController1 = PageController(initialPage: 0);
  bool otp = false;
  bool disable = false;
  bool isTimerTextShown = false;
  DateTime _selectedDate;

  final requestId = StringUtil.generateUUID();
  final requestTime = Format().f.format(DateTime.now());

  List<Vehicle> pts = [];
  List<LinkedCard> cds = [];
  List<Question> qes = [];

  Future<List<VehicleTypeElement>> vehicleTypeData;
  Future<List<Property>> questDataOne;
  Future<List<Property>> questDataTwo;
  Future<List<Property>> genderData;
  Future<List<Property>> provinceData;
  Future<List<District>> districtData;
  Future<List<Ward>> wardData;

  String genderValue,
      provinceValue,
      districtValue,
      wardValue,
      questionValue1,
      questionValue2,
      vehicleTypeValue;
  String genderDisplay,
      provinceDisplay,
      districtDisplay,
      wardDisplay,
      vehicleTypeDisplay;

  final nameCon = new TextEditingController();
  final phoneCon = new TextEditingController();
  final citizenIdCon = new TextEditingController();
  final emailCon = new TextEditingController();
  final dateCon = new TextEditingController();
  final taxCon = new TextEditingController();
  final addressCon = new TextEditingController();
  final pass1Con = new TextEditingController();
  final pass2Con = new TextEditingController();
  final answer1Con = new TextEditingController();
  final answer2Con = new TextEditingController();

  final driveNameCon = new TextEditingController();
  final licensePlatesCon = new TextEditingController();
  final accountNameCon = new TextEditingController();
  final cardNumberCon = new TextEditingController();

  CountDownController _countdownController = CountDownController();
  TextEditingController pinCon = TextEditingController();
  String otpCode;

  final registerViewModel = RegisterViewModel();
  final deviceName = DeviceInfo().getPhoneInfo().toString();
  final channel = STConstant.channel;
  bool status = true;
  final stConstant = STConstant();

  @override
  void initState() {
    super.initState();
    _selectedRadio = 1;
    registerViewModel.checkData();
    vehicleTypeData = ApiService().fetchVehicleType();
    questDataOne = ApiService().fetchQuestionOne();
    questDataTwo = ApiService().fetchQuestionTwo();
    genderData = ApiService().fetchGender();
    provinceData = ApiService().fetchProvince();
  }

  @override
  void dispose() {
    super.dispose();
  }

  setSelectedRadio(int val) {
    setState(() {
      _selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          appBar: newAppBar(context),
          drawer: Drawer(
            child: NewDrawer(onOff: true,),
          ),
          body: Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height,
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
                _selectedRadio == 1
                    ? PageView(
                  scrollDirection: Axis.vertical,
                  controller: pageController,
                  physics: new NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      pageChanged = index;
                    });
                  },
                  children: [
                    //Thông tin đăng nhập cá nhân
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
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
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
                                        .translate('register_PLX'),
                                    style: TextStyle(
                                      color: Color(0xff454f5b),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
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
                                  SizedBox(height: 40.0),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Image.asset(
                                          'assets/one_red_outline.png',
                                          fit: BoxFit.cover,
                                          height: 24.0,
                                          width: 24.0),
                                      Image.asset(
                                          'assets/two_grey_outline.png',
                                          fit: BoxFit.cover,
                                          height: 24.0,
                                          width: 24.0),
                                      Image.asset(
                                          'assets/three_grey_outline.png',
                                          fit: BoxFit.cover,
                                          height: 24.0,
                                          width: 24.0),
                                    ],
                                  ),
                                  SizedBox(height: 10.0),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate('login_information'),
                                        style: TextStyle(
                                          color: Color(0xffbe1128),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate(
                                            'personal_information'),
                                        style: TextStyle(
                                          color: Color(0xffb6bec8),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate('vehicle_card'),
                                        style: TextStyle(
                                          color: Color(0xffb6bec8),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 30.0),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
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
                                                .translate('personal'),
                                          ),
                                        ],
                                      ),
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
                                            AppLocalizations.of(context)
                                                .translate('organization'),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  _buildLoginInfo(),
                                  SizedBox(height: 30),
                                  RaisedButton(
                                    elevation: 5,
                                    onPressed:
                                        () {
                                      registerViewModel.confirmPass(
                                          context, pass1Con.text, pass2Con.text) !=
                                          false &&
                                          registerViewModel.checkNullValue(
                                              context, questionValue1,
                                              "Vui lòng chọn câu hỏi") != false &&
                                          registerViewModel.checkNullValue(
                                              context, questionValue2,
                                              "Vui lòng chọn câu hỏi") != false &&
                                          registerViewModel.compareValue(
                                              context, questionValue1,
                                              questionValue2,
                                              "Vui lòng chọn 2 câu hỏi khác nhau") !=
                                              false &&
                                          registerViewModel.checkEmptyValue(
                                              context, nameCon.text,
                                              "Vui lòng nhập họ tên") != false &&
                                          registerViewModel.checkEmptyValue(
                                              context, answer1Con.text,
                                              "Vui lòng nhập câu trả lời 1") !=
                                              false &&
                                          registerViewModel.checkEmptyValue(
                                              context, answer2Con.text,
                                              "Vui lòng nhập câu trả lời 2") !=
                                              false
                                          ? pageController
                                          .animateToPage(
                                        ++pageChanged,
                                        duration: Duration(
                                          milliseconds: 10,
                                        ),
                                        curve: Curves
                                            .bounceInOut,
                                      )
                                          : pageController
                                          .animateToPage(
                                        pageChanged,
                                        duration: Duration(
                                          milliseconds: 10,
                                        ),
                                        curve: Curves
                                            .bounceInOut,
                                      );
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(5),
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
                                  SizedBox(height: 50),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    //Thông tin cá nhân
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
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
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
                                        .translate('register_PLX'),
                                    style: TextStyle(
                                      color: Color(0xff454f5b),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
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
                                  SizedBox(height: 40.0),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                          'assets/check_green_circle_outline.png',
                                          fit: BoxFit.cover,
                                          height: 24.0,
                                          width: 24.0),
                                      Container(
                                        color: Color(0xffbe1128),
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width /
                                            4,
                                        height: 6.0,
                                      ),
                                      Image.asset(
                                          'assets/two_red_outline.png',
                                          fit: BoxFit.cover,
                                          height: 24.0,
                                          width: 24.0),
                                      Container(
                                        color: Colors.transparent,
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width /
                                            4,
                                        height: 6.0,
                                      ),
                                      Image.asset(
                                          'assets/three_grey_outline.png',
                                          fit: BoxFit.cover,
                                          height: 24.0,
                                          width: 24.0),
                                    ],
                                  ),
                                  SizedBox(height: 10.0),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate('login_information'),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate(
                                            'personal_information'),
                                        style: TextStyle(
                                          color: Color(0xffbe1128),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate('vehicle_card'),
                                        style: TextStyle(
                                          color: Color(0xffb6bec8),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 30),
                                  _buildPersonalInfo(),
                                  SizedBox(height: 30.0),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      RaisedButton(
                                        elevation: 5,
                                        onPressed: () {
                                          pageController.animateToPage(
                                              --pageChanged,
                                              duration:
                                              Duration(milliseconds: 10),
                                              curve: Curves.bounceInOut);
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(5),
                                        ),
                                        color: Color(0xffEAEEF2),
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .translate('back'),
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
                                          registerViewModel.checkNullValue(
                                              context, genderValue,
                                              "Vui lòng giới tính") != false &&
                                              registerViewModel.checkNullValue(
                                                  context, provinceValue,
                                                  "Vui lòng chọn Tỉnh thành") !=
                                                  false &&
                                              registerViewModel.checkNullValue(
                                                  context, districtValue,
                                                  "Vui lòng chọn Quân/Huyện") !=
                                                  false &&
                                              registerViewModel.checkNullValue(
                                                  context, wardValue,
                                                  "Vui lòng chọn Huyện/Xã") !=
                                                  false &&
                                              registerViewModel.checkEmptyValue(
                                                  context, dateCon.text,
                                                  "Vui lòng nhập ngày sinh") !=
                                                  false &&
                                              registerViewModel.checkEmptyValue(
                                                  context, citizenIdCon.text,
                                                  "Vui lòng nhập CMND/CCCD") !=
                                                  false
                                              ? pageController
                                              .animateToPage(
                                            ++pageChanged,
                                            duration:
                                            Duration(
                                              milliseconds:
                                              10,
                                            ),
                                            curve: Curves
                                                .bounceInOut,
                                          )
                                              : pageController
                                              .animateToPage(
                                            pageChanged,
                                            duration:
                                            Duration(
                                              milliseconds:
                                              10,
                                            ),
                                            curve: Curves
                                                .bounceInOut,
                                          );
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(5),
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
                                  SizedBox(height: 30),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    //Phương tiện & thẻ cá nhân
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
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
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
                                        .translate('register_PLX'),
                                    style: TextStyle(
                                      color: Color(0xff454f5b),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
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
                                  SizedBox(height: 40.0),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                          'assets/check_green_circle_outline.png',
                                          fit: BoxFit.cover,
                                          height: 24.0,
                                          width: 24.0),
                                      Container(
                                        color: Color(0xffbe1128),
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width /
                                            4,
                                        height: 6.0,
                                      ),
                                      Image.asset(
                                          'assets/check_green_circle_outline.png',
                                          fit: BoxFit.cover,
                                          height: 24.0,
                                          width: 24.0),
                                      Container(
                                        color: Color(0xffbe1128),
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width /
                                            4,
                                        height: 6.0,
                                      ),
                                      Image.asset(
                                          'assets/three_red_outline.png',
                                          fit: BoxFit.cover,
                                          height: 24.0,
                                          width: 24.0),
                                    ],
                                  ),
                                  SizedBox(height: 10.0),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate('login_information'),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate(
                                            'personal_information'),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate('vehicle_card'),
                                        style: TextStyle(
                                          color: Color(0xffbe1128),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 30),
                                  _buildVehicleCard(),
                                  SizedBox(height: 30.0),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      RaisedButton(
                                        elevation: 5,
                                        onPressed: () {
                                          pageController.animateToPage(
                                              --pageChanged,
                                              duration:
                                              Duration(milliseconds: 10),
                                              curve: Curves.bounceInOut);
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(5),
                                        ),
                                        color: Color(0xffEAEEF2),
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .translate('back'),
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
                                        onPressed: () => showRegisterDialog(),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(5),
                                        ),
                                        color: Color(0xffffc20e),
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .translate('register'),
                                          style: TextStyle(
                                            color: Color(0xff454f5b),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 30),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    otp == true
                        ? DraggableScrollableSheet(
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
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
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
                                    SizedBox(height: 20.0),
                                    Text(
                                      AppLocalizations.of(context)
                                          .translate(
                                          'customer_authentication'),
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
                                          .translate(
                                          'describe_otp') +
                                          phoneCon.text +
                                          AppLocalizations.of(context)
                                              .translate(
                                              'describe_otp1'),
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(height: 30.0),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
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
                                        otpCode = output;
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
                                          isTimerTextShown =
                                          !isTimerTextShown;
                                          _countdownController
                                              .restart(
                                              duration: 60);
                                          ApiService().generateOTP(phoneCon.text, stConstant.register);
                                        });
                                      },
                                      child: Text(
                                        AppLocalizations.of(
                                            context)
                                            .translate(
                                            'btn_resend_otp'),
                                        style: TextStyle(
                                          color:
                                          Color(0xff1890ff),
                                          fontWeight:
                                          FontWeight.w600,
                                        ),
                                      ),
                                    )
                                        : TextButton(
                                      onPressed: null,
                                      child: Text(
                                        AppLocalizations.of(
                                            context)
                                            .translate(
                                            'btn_resend_otp'),
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight:
                                          FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    CircularCountDownTimer(
                                      duration: 60,
                                      initialDuration: 0,
                                      controller: _countdownController,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width /
                                          6,
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height /
                                          12,
                                      fillColor: Colors.transparent,
                                      ringColor: Colors.transparent,
                                      textFormat:
                                      CountdownTextFormat.MM_SS,
                                      isTimerTextShown:
                                      !isTimerTextShown,
                                      isReverse: true,
                                      autoStart: true,
                                      textStyle:
                                      TextStyle(color: Colors.red),
                                      onComplete: () {
                                        setState(() {
                                          disable = true;
                                          isTimerTextShown =
                                          !isTimerTextShown;
                                        });
                                      },
                                    ),
                                    RaisedButton(
                                      elevation: 5,
                                      onPressed: () {
                                        otpCode.length>0?
                                        registerViewModel.verifyOtp(
                                            context,
                                            phoneCon.text,
                                            pass2Con.text,
                                            otpCode,
                                            Register(
                                              requestId: requestId,
                                              requestTime: requestTime,
                                              deviceName: deviceName,
                                              channel: channel,
                                              customerInfo:
                                              CustomerInfo(
                                                customerBasic:
                                                CustomerBasic(
                                                  name: nameCon.text,
                                                  phone: phoneCon.text,
                                                  email: emailCon.text,
                                                  password: HasPassword().hasPassword(pass2Con.text),
                                                  questions: qes,
                                                  customerTypeId:
                                                  _selectedRadio,
                                                ),
                                                customerCard:
                                                CustomerCard(
                                                  cardId:
                                                  citizenIdCon.text,
                                                  date: dateCon.text,
                                                  gender: genderValue,
                                                  taxCode: taxCon.text,
                                                  provinceId: int.parse(
                                                      provinceValue),
                                                  districtId: int.parse(
                                                      districtValue),
                                                  wardId: int.parse(
                                                      wardValue),
                                                  address:
                                                  addressCon.text,
                                                ),
                                              ),
                                              vehicles: pts,
                                              linkedCards: cds,
                                            ),
                                            pageController,
                                            pageChanged):
                                        Fluttertoast.showToast(
                                            msg: "Vui lòng nhập mã OTP",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM);
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(5),
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
                    )
                        : null,
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
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
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
                                    Container(
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 30.0),
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
                                          .translate('sub_title_success'),
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    RaisedButton(
                                      onPressed: () {
                                        passDataToQR(
                                            context,
                                            nameCon.text,
                                            phoneCon.text,
                                            emailCon.text,
                                            taxCon.text,
                                            addressCon.text+" "+ wardDisplay+" "+districtDisplay+" "+provinceDisplay,
                                            pts,
                                            _selectedRadio
                                        );
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(5),
                                      ),
                                      color: Color(0xffffc20e),
                                      child: Text(
                                        'QR code',
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
                    )
                  ],
                )
                    : PageView(
                  controller: pageController1,
                  physics: new NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  onPageChanged: (index) {
                    setState(() {
                      pageChanged1 = index;
                    });
                  },
                  children: [
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
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
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
                                        .translate('register_PLX'),
                                    style: TextStyle(
                                      color: Color(0xff454f5b),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
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
                                  SizedBox(height: 40.0),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Image.asset(
                                          'assets/one_red_outline.png',
                                          fit: BoxFit.cover,
                                          height: 24.0,
                                          width: 24.0),
                                      Image.asset(
                                          'assets/two_grey_outline.png',
                                          fit: BoxFit.cover,
                                          height: 24.0,
                                          width: 24.0),
                                      Image.asset(
                                          'assets/three_grey_outline.png',
                                          fit: BoxFit.cover,
                                          height: 24.0,
                                          width: 24.0),
                                    ],
                                  ),
                                  SizedBox(height: 10.0),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate('login_information'),
                                        style: TextStyle(
                                          color: Color(0xffbe1128),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate(
                                            'personal_information'),
                                        style: TextStyle(
                                          color: Color(0xffb6bec8),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate('vehicle_card'),
                                        style: TextStyle(
                                          color: Color(0xffb6bec8),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 30.0),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
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
                                                .translate('personal'),
                                          ),
                                        ],
                                      ),
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
                                            AppLocalizations.of(context)
                                                .translate('organization'),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  //
                                  _buildSignInInfo(),
                                  //
                                  SizedBox(height: 30),
                                  RaisedButton(
                                    elevation: 5,
                                    onPressed: () {
                                      registerViewModel.confirmPass(
                                          context, pass1Con.text, pass2Con.text) !=
                                          false &&
                                          registerViewModel.checkNullValue(
                                              context, questionValue1,
                                              "Vui lòng chọn câu hỏi") != false &&
                                          registerViewModel.checkNullValue(
                                              context, questionValue2,
                                              "Vui lòng chọn câu hỏi") != false &&
                                          registerViewModel.compareValue(
                                              context, questionValue1,
                                              questionValue2,
                                              "Vui lòng chọn 2 câu hỏi khác nhau") !=
                                              false
                                          ? pageController1.animateToPage(
                                          ++pageChanged1,
                                          duration: Duration(
                                              milliseconds: 10),
                                          curve: Curves
                                              .bounceInOut)
                                          : pageController1.animateToPage(
                                          pageChanged1,
                                          duration: Duration(milliseconds: 10),
                                          curve: Curves.bounceInOut);
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(5),
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
                                  SizedBox(height: 50),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
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
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
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
                                        .translate('register_PLX'),
                                    style: TextStyle(
                                      color: Color(0xff454f5b),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
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
                                  SizedBox(height: 40.0),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                          'assets/check_green_circle_outline.png',
                                          fit: BoxFit.cover,
                                          height: 24.0,
                                          width: 24.0),
                                      Container(
                                        color: Color(0xffbe1128),
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width /
                                            4,
                                        height: 6.0,
                                      ),
                                      Image.asset(
                                          'assets/two_red_outline.png',
                                          fit: BoxFit.cover,
                                          height: 24.0,
                                          width: 24.0),
                                      Container(
                                        color: Colors.transparent,
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width /
                                            4,
                                        height: 6.0,
                                      ),
                                      Image.asset(
                                          'assets/three_grey_outline.png',
                                          fit: BoxFit.cover,
                                          height: 24.0,
                                          width: 24.0),
                                    ],
                                  ),
                                  SizedBox(height: 10.0),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate('login_information'),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate(
                                            'personal_information'),
                                        style: TextStyle(
                                          color: Color(0xffbe1128),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate('vehicle_card'),
                                        style: TextStyle(
                                          color: Color(0xffb6bec8),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 30),
                                  //
                                  _buildOrganizationInfo(),
                                  //
                                  SizedBox(height: 30.0),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      RaisedButton(
                                        elevation: 5,
                                        onPressed: () {
                                          pageController1.animateToPage(
                                              --pageChanged1,
                                              duration:
                                              Duration(milliseconds: 10),
                                              curve: Curves.bounceInOut);
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(5),
                                        ),
                                        color: Color(0xffEAEEF2),
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .translate('back'),
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
                                          registerViewModel.checkNullValue(
                                              context, provinceValue,
                                              "Vui lòng chọn Tỉnh thành") !=
                                              false &&
                                              registerViewModel.checkNullValue(
                                                  context, districtValue,
                                                  "Vui lòng chọn Quân/Huyện") !=
                                                  false &&
                                              registerViewModel.checkNullValue(
                                                  context, wardValue,
                                                  "Vui lòng chọn Huyện/Xã") != false
                                              ? pageController1
                                              .animateToPage(
                                            ++pageChanged1,
                                            duration:
                                            Duration(
                                              milliseconds:
                                              10,
                                            ),
                                            curve: Curves
                                                .bounceInOut,
                                          )
                                              : pageController1
                                              .animateToPage(
                                            pageChanged1,
                                            duration:
                                            Duration(
                                              milliseconds:
                                              10,
                                            ),
                                            curve: Curves
                                                .bounceInOut,
                                          );
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(5),
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
                                  SizedBox(height: 30),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
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
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
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
                                        .translate('register_PLX'),
                                    style: TextStyle(
                                      color: Color(0xff454f5b),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
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
                                  SizedBox(height: 40.0),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                          'assets/check_green_circle_outline.png',
                                          fit: BoxFit.cover,
                                          height: 24.0,
                                          width: 24.0),
                                      Container(
                                        color: Color(0xffbe1128),
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width /
                                            4,
                                        height: 6.0,
                                      ),
                                      Image.asset(
                                          'assets/check_green_circle_outline.png',
                                          fit: BoxFit.cover,
                                          height: 24.0,
                                          width: 24.0),
                                      Container(
                                        color: Color(0xffbe1128),
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width /
                                            4,
                                        height: 6.0,
                                      ),
                                      Image.asset(
                                          'assets/three_red_outline.png',
                                          fit: BoxFit.cover,
                                          height: 24.0,
                                          width: 24.0),
                                    ],
                                  ),
                                  SizedBox(height: 10.0),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate('login_information'),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate(
                                            'personal_information'),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate('vehicle_card'),
                                        style: TextStyle(
                                          color: Color(0xffbe1128),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 30),
                                  _buildVehicleCard(),
                                  SizedBox(height: 30.0),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      RaisedButton(
                                        elevation: 5,
                                        onPressed: () {
                                          pageController1.animateToPage(
                                              --pageChanged1,
                                              duration:
                                              Duration(milliseconds: 10),
                                              curve: Curves.bounceInOut);
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(5),
                                        ),
                                        color: Color(0xffEAEEF2),
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .translate('back'),
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
                                        onPressed: () => showRegisterDialog(),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(5),
                                        ),
                                        color: Color(0xffffc20e),
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .translate('register'),
                                          style: TextStyle(
                                            color: Color(0xff454f5b),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 30),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    otp == true
                        ? DraggableScrollableSheet(
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
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
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
                                    SizedBox(height: 20.0),
                                    Text(
                                      AppLocalizations.of(context)
                                          .translate(
                                          'customer_authentication'),
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
                                          .translate(
                                          'describe_otp') +
                                          phoneCon.text +
                                          AppLocalizations.of(context)
                                              .translate(
                                              'describe_otp1'),
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(height: 30.0),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
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
                                        otpCode = output;
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
                                          isTimerTextShown =
                                          !isTimerTextShown;
                                          _countdownController
                                              .restart(
                                              duration: 60);
                                          ApiService().generateOTP(phoneCon.text, stConstant.register);
                                        });
                                      },
                                      child: Text(
                                        AppLocalizations.of(
                                            context)
                                            .translate(
                                            'btn_resend_otp'),
                                        style: TextStyle(
                                          color:
                                          Color(0xff1890ff),
                                          fontWeight:
                                          FontWeight.w600,
                                        ),
                                      ),
                                    )
                                        : TextButton(
                                      onPressed: null,
                                      child: Text(
                                        AppLocalizations.of(
                                            context)
                                            .translate(
                                            'btn_resend_otp'),
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight:
                                          FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    CircularCountDownTimer(
                                      duration: 60,
                                      initialDuration: 0,
                                      controller: _countdownController,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width /
                                          6,
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height /
                                          12,
                                      fillColor: Colors.transparent,
                                      ringColor: Colors.transparent,
                                      textFormat:
                                      CountdownTextFormat.MM_SS,
                                      isTimerTextShown:
                                      !isTimerTextShown,
                                      isReverse: true,
                                      autoStart: true,
                                      textStyle:
                                      TextStyle(color: Colors.red),
                                      onComplete: () {
                                        setState(() {
                                          disable = true;
                                          isTimerTextShown =
                                          !isTimerTextShown;
                                        });
                                      },
                                    ),
                                    RaisedButton(
                                      elevation: 5,
                                      onPressed: () {
                                       otpCode.length>0?
                                        registerViewModel.verifyOtp(
                                            context,
                                            phoneCon.text,
                                            pass2Con.text,
                                            otpCode,
                                            Register(
                                              requestId: requestId,
                                              requestTime: requestTime,
                                              deviceName: deviceName,
                                              channel: channel,
                                              customerInfo:
                                              CustomerInfo(
                                                customerBasic:
                                                CustomerBasic(
                                                  name: nameCon.text,
                                                  phone: phoneCon.text,
                                                  email: emailCon.text,
                                                  password: HasPassword().hasPassword(pass2Con.text),
                                                  questions: qes,
                                                  customerTypeId:
                                                  _selectedRadio,
                                                ),
                                                customerCard:
                                                CustomerCard(
                                                  cardId: "",
                                                  date: dateCon.text,
                                                  gender: "",
                                                  taxCode: taxCon.text,
                                                  provinceId: int.parse(
                                                      provinceValue),
                                                  districtId: int.parse(
                                                      districtValue),
                                                  wardId: int.parse(
                                                      wardValue),
                                                  address:
                                                  addressCon.text,
                                                ),
                                              ),
                                              vehicles: pts,
                                              linkedCards: cds,
                                            ),
                                            pageController1,
                                            pageChanged1):Fluttertoast.showToast(
                                           msg: "Vui lòng nhập mã OTP",
                                           toastLength: Toast.LENGTH_SHORT,
                                           gravity: ToastGravity.BOTTOM);
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(5),
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
                    )
                        : null,
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
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
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
                                    Container(
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 30.0),
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
                                          .translate('sub_title_success'),
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    RaisedButton(
                                      onPressed: () {
                                        passDataToQR(
                                          context,
                                            nameCon.text,
                                            phoneCon.text,
                                          emailCon.text,
                                          taxCon.text,
                                          addressCon.text+" "+ wardDisplay+" "+districtDisplay+" "+provinceDisplay,
                                          pts,
                                          _selectedRadio
                                        );
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(5),
                                      ),
                                      color: Color(0xffffc20e),
                                      child: Text(
                                        'QR code',
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
                    )
                  ],
                )
              ],
            ),
          ),
          floatingActionButton: Visibility(
            visible: !keyboardIsOpen,
            child: NewFloatingActionButton(),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: NewBottomNavigationBar(),
        ), );
  }

  Widget _buildLoginInfo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          NewLabel().build(context,
              title: AppLocalizations.of(context)
                  .translate('title_login_information'),
              isRequire: false,
              fontWeight: FontWeight.bold),
          NewLabel().build(context,
              title: AppLocalizations.of(context).translate('full_name') + ':',
              isRequire: true),
          NewTextField().build(
            context,
            hintText: AppLocalizations.of(context).translate('full_name'),
            controller: nameCon,
          ),
          NewLabel().build(context,
              title: AppLocalizations.of(context).translate('phone') + ':',
              isRequire: true),
          NewTextField().build(
            context,
            hintText: '0912123456',
            isPhone: true,
            controller: phoneCon,
            errorText: phoneCon.text.length == 0
                ? null
                : !Validation.validationPhone(phoneCon.text)
                ? AppLocalizations.of(context).translate('msg_valid_phone')
                : null,
          ),
          NewLabel().build(context,
              title: AppLocalizations.of(context).translate('email') + ':',
              isRequire: true),
          NewTextField().build(
            context,
            hintText: 'mail@hdbank.com.vn',
            isEmail: true,
            controller: emailCon,
            errorText: emailCon.text.length == 0
                ? null
                : !Validation.validationEmail(emailCon.text)
                ? AppLocalizations.of(context).translate('msg_valid_email')
                : null,
          ),
          NewLabel().build(context,
              title: AppLocalizations.of(context).translate('password') + ':',
              isRequire: true),
          NewTextField().build(
            context,
            hintText: '********',
            isPassword: true,
            controller: pass1Con,
            errorText: pass1Con.text.length == 0
                ? null
                : !Validation.validationPass(pass1Con.text)
                ? AppLocalizations.of(context).translate('msg_valid_pass')
                : null,
          ),
          NewLabel().build(context,
              title:
              AppLocalizations.of(context).translate('confirm_password') +
                  ':',
              isRequire: true),
          NewTextField().build(
            context,
            hintText: '********',
            isPassword: true,
            controller: pass2Con,
            errorText: pass2Con.text.length == 0
                ? null
                : !Validation.validationPass(pass2Con.text)
                ? AppLocalizations.of(context).translate('msg_valid_pass')
                : null,
          ),
          NewLabel().build(context,
              title: AppLocalizations.of(context).translate('question1') + ':',
              isRequire: true),
          FutureBuilder<List<Property>>(
            future: questDataOne,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    hint: Text(
                      AppLocalizations.of(context)
                          .translate('hint_question'),
                    ),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      contentPadding: EdgeInsets.all(10.0),
                    ),
                    value: questionValue1,
                    onChanged: (newValue) {
                      setState(() {
                        questionValue1 = newValue;
                      });
                    },
                    items:
                    snapshot.data.map<DropdownMenuItem<String>>((item) {
                      return DropdownMenuItem<String>(
                        value: item.value,
                        child: Text(item.display),
                      );
                    }).toList(),
                  ),
                );
              }
              else {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: DropdownButtonFormField(
                    hint: Text(
                        AppLocalizations.of(context).translate('hint_question')),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      contentPadding: EdgeInsets.all(10.0),
                    ),
                  ),
                );
              }
            },
          ),
          NewTextField().build(
            context,
            hintText: AppLocalizations.of(context).translate('hint_answer'),
            controller: answer1Con,
          ),
          NewLabel().build(context,
              title: AppLocalizations.of(context).translate('question2') + ':',
              isRequire: true),
          FutureBuilder<List<Property>>(
            future: questDataTwo,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    hint: Text(
                      AppLocalizations.of(context)
                          .translate('hint_question'),
                    ),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      contentPadding: EdgeInsets.all(10.0),
                    ),
                    value: questionValue2,
                    onChanged: (newValue) {
                      setState(() {
                        questionValue2 = newValue;
                      });
                    },
                    items:
                    snapshot.data.map<DropdownMenuItem<String>>((item) {
                      return DropdownMenuItem<String>(
                        value: item.value,
                        child: Text(item.display),
                      );
                    }).toList(),
                  ),
                );
              }
              else {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: DropdownButtonFormField(
                    hint: Text(
                        AppLocalizations.of(context).translate('hint_question')),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      contentPadding: EdgeInsets.all(10.0),
                    ),
                  ),
                );
              }
            },
          ),
          NewTextField().build(
            context,
            hintText: AppLocalizations.of(context).translate('hint_answer'),
            controller: answer2Con,
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          NewLabel().build(context,
              title: AppLocalizations.of(context)
                  .translate('title_personal_information'),
              isRequire: false,
              fontWeight: FontWeight.bold),
          NewLabel().build(context,
              title: AppLocalizations.of(context).translate('id') + ':',
              isRequire: true),
          NewTextField().build(
            context,
            hintText: 'xxx-xxxx-xxx',
            controller: citizenIdCon,
          ),
          NewLabel().build(context,
              title: AppLocalizations.of(context).translate('birth') + ':',
              isRequire: true),
          NewTextField().build(
            context,
            hintText: 'xx-xx-xxxx',
            controller: dateCon,
            onTap: () {
              _selectDate(context);
            },
          ),
          NewLabel().build(context,
              title: AppLocalizations.of(context).translate('gender') + ':',
              isRequire: true),
          FutureBuilder<List<Property>>(
            future: genderData,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return snapshot.hasData
                  ? Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: DropdownButtonFormField(
                  isExpanded: true,
                  hint: Text(
                    AppLocalizations.of(context).translate('gender'),
                  ),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                  value: genderValue,
                  onChanged: (newValue) {
                    setState(() {
                      genderValue = newValue;
                    });
                  },
                  items:
                  snapshot.data.map<DropdownMenuItem<String>>((item) {
                    return DropdownMenuItem<String>(
                      value: item.value,
                      child: Text(item.display),
                      onTap: () {
                        genderDisplay = item.display;
                      },
                    );
                  }).toList(),
                ),
              )
                  : Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: DropdownButtonFormField(
                  hint: Text(
                      AppLocalizations.of(context).translate('gender')),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                ),
              );
            },
          ),
          NewLabel().build(context,
              title: AppLocalizations.of(context).translate('tax') + ':',
              isRequire: false),
          NewTextField()
              .build(context, hintText: 'xxxxxxxxx', controller: taxCon),
          NewLabel().build(context,
              title: AppLocalizations.of(context).translate('province') + ':',
              isRequire: true),
          FutureBuilder<List<Property>>(
            future: provinceData,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return snapshot.hasData
                  ? Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: DropdownButtonFormField(
                  hint: Text(
                    AppLocalizations.of(context).translate('province'),
                  ),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                  value: provinceValue,
                  onChanged: (newValue) {
                    setState(() {
                      provinceValue = newValue;
                      districtValue = null;
                      wardValue = null;
                      districtData = ApiService().fetchDistrict(provinceValue);
                    });
                  },
                  items:
                  snapshot.data.map<DropdownMenuItem<String>>((item) {
                    return DropdownMenuItem<String>(
                      value: item.value,
                      child: Text(item.display),
                      onTap: () {
                        provinceDisplay = item.display;
                      },
                    );
                  }).toList(),
                ),
              )
                  : Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: DropdownButtonFormField(
                  hint: Text(
                      AppLocalizations.of(context).translate('province')),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                ),
              );
            },
          ),
          NewLabel().build(context,
              title: AppLocalizations.of(context).translate('district') + ':',
              isRequire: true),
          FutureBuilder<List<District>>(
            future: districtData,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              List<District> dis = snapshot.data;
              return snapshot.hasData
                  ? Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: DropdownButtonFormField(
                  hint: Text(
                    AppLocalizations.of(context).translate('district'),
                  ),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                  value: districtValue,
                  onChanged: (newValue) {
                    setState(() {
                      districtValue = newValue;
                      wardValue = null;
                      wardData = ApiService().fetchWard(districtValue);
                    });
                  },
                  items: dis.map<DropdownMenuItem<String>>((item) {
                    return DropdownMenuItem<String>(
                      value: item.value,
                      child: Text(item.display),
                      onTap: () {
                        districtDisplay = item.display;
                      },
                    );
                  }).toList(),
                ),
              )
                  : Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: DropdownButtonFormField(
                  hint: Text(
                      AppLocalizations.of(context).translate('district')),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                ),
              );
            },
          ),
          NewLabel().build(context,
              title: AppLocalizations.of(context).translate('ward') + ':',
              isRequire: true),
          FutureBuilder<List<Ward>>(
            future: wardData,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return snapshot.hasData
                  ? Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: DropdownButtonFormField(
                  hint: Text(
                      AppLocalizations.of(context).translate('ward')),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                  value: wardValue,
                  onChanged: (newValue) {
                    setState(() {
                      wardValue = newValue;
                    });
                  },
                  items:
                  snapshot.data.map<DropdownMenuItem<String>>((item) {
                    return DropdownMenuItem<String>(
                      value: item.value,
                      child: Text(item.display),
                      onTap: () {
                        wardDisplay = item.display;
                      },
                    );
                  }).toList(),
                ),
              )
                  : Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: DropdownButtonFormField(
                  hint: Text(
                      AppLocalizations.of(context).translate('ward')),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                ),
              );
            },
          ),
          NewLabel().build(context,
              title: AppLocalizations.of(context).translate('address') + ':',
              isRequire: true),
          NewTextField().build(context,
              hintText:
              AppLocalizations.of(context).translate('hint_address'),
              controller: addressCon),
        ],
      ),
    );
  }

  Widget _buildVehicleCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          NewLabel().build(context,
              title: AppLocalizations.of(context).translate('title_vehicle'),
              isRequire: false,
              fontWeight: FontWeight.bold),
          Row(
            children: [
              RaisedButton.icon(
                elevation: 5,
                onPressed: () {
                  driveNameCon.text = '';
                  licensePlatesCon.text = '';
                  showAddDialog(context, true);
                },
                icon: Icon(Icons.add),
                label: Text(
                  AppLocalizations.of(context).translate('add_new'),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: Color(0xffEAEEF2),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // children: [
            //   // _buildVehicle(),
            // ],
            children: pts.map((pt) => _buildVehicle(pt)).toList(),
          ),
          SizedBox(height: 10.0),
          NewLabel().build(context,
              title: AppLocalizations.of(context).translate('title_card'),
              isRequire: false,
              fontWeight: FontWeight.bold),
          Row(
            children: [
              RaisedButton.icon(
                elevation: 5,
                onPressed: () {
                  accountNameCon.text = '';
                  cardNumberCon.text = '';
                  showAddDialog(context, false);
                },
                icon: Icon(Icons.add),
                label: Text(
                  AppLocalizations.of(context).translate('add_new'),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: Color(0xffEAEEF2),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: cds.map((cd) => _buildCard(cd)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSignInInfo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          NewLabel().build(context,
              title: AppLocalizations.of(context)
                  .translate('title_login_information'),
              isRequire: false,
              fontWeight: FontWeight.bold),
          NewLabel().build(context,
              title: AppLocalizations.of(context).translate('unit_name') + ':',
              isRequire: true),
          NewTextField().build(
            context,
            hintText: AppLocalizations.of(context).translate('unit_name'),
            controller: nameCon,
          ),
          NewLabel().build(context,
              title: AppLocalizations.of(context).translate('hintText_phoneNumber') + ':',
              isRequire: true),
          NewTextField().build(
            context,
            hintText: '0912123456',
            isPhone: true,
            controller: phoneCon,
            errorText: phoneCon.text.length == 0
                ? null
                : !Validation.validationPhone(phoneCon.text)
                ? AppLocalizations.of(context).translate('msg_valid_phone')
                : null,
          ),
          NewLabel().build(context,
              title: AppLocalizations.of(context).translate('email') + ':',
              isRequire: true),
          NewTextField().build(
            context,
            hintText: 'mail@hdbank.com.vn',
            isEmail: true,
            controller: emailCon,
            errorText: emailCon.text.length == 0
                ? null
                : !Validation.validationEmail(emailCon.text)
                ? AppLocalizations.of(context).translate('msg_valid_email')
                : null,
          ),
          NewLabel().build(context,
              title: AppLocalizations.of(context).translate('password') + ':',
              isRequire: true),
          NewTextField().build(
            context,
            hintText: '********',
            isPassword: true,
            controller: pass1Con,
            errorText: pass1Con.text.length == 0
                ? null
                : !Validation.validationPass(pass1Con.text)
                ? AppLocalizations.of(context).translate('msg_valid_pass')
                : null,
          ),
          NewLabel().build(context,
              title:
              AppLocalizations.of(context).translate('confirm_password') +
                  ':',
              isRequire: true),
          NewTextField().build(
            context,
            hintText: '********',
            isPassword: true,
            controller: pass2Con,
            errorText: pass2Con.text.length == 0
                ? null
                : !Validation.validationPass(pass2Con.text)
                ? AppLocalizations.of(context).translate('msg_valid_pass')
                : null,
          ),
          NewLabel().build(context,
              title: AppLocalizations.of(context).translate('question1') + ':',
              isRequire: true),
          FutureBuilder(
            future: questDataOne,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return snapshot.hasData
                  ? Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: DropdownButtonFormField(
                  isExpanded: true,
                  hint: Text(
                    AppLocalizations.of(context)
                        .translate('hint_question'),
                  ),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                  value: questionValue1,
                  onChanged: (newValue) {
                    setState(() {
                      questionValue1 = newValue;
                    });
                  },
                  items:
                  snapshot.data.map<DropdownMenuItem<String>>((item) {
                    return DropdownMenuItem<String>(
                      value: item.value,
                      child: Text(item.display),
                    );
                  }).toList(),
                ),
              )
                  : Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: DropdownButtonFormField(
                  hint: Text(
                      AppLocalizations.of(context).translate('hint_question')),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                ),
              );
            },
          ),
          NewTextField().build(
            context,
            hintText: AppLocalizations.of(context).translate('hint_answer'),
            controller: answer1Con,
          ),
          NewLabel().build(context,
              title: AppLocalizations.of(context).translate('question2') + ':',
              isRequire: true),
          FutureBuilder(
            future: questDataTwo,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return snapshot.hasData
                  ? Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: DropdownButtonFormField(
                  isExpanded: true,
                  hint: Text(
                    AppLocalizations.of(context)
                        .translate('hint_question'),
                  ),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                  value: questionValue2,
                  onChanged: (newValue) {
                    setState(() {
                      questionValue2 = newValue;
                    });
                  },
                  items:
                  snapshot.data.map<DropdownMenuItem<String>>((item) {
                    return DropdownMenuItem<String>(
                      value: item.value,
                      child: Text(item.display),
                    );
                  }).toList(),
                ),
              )
                  : Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: DropdownButtonFormField(
                  hint: Text(
                      AppLocalizations.of(context).translate('hint_question')),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                ),
              );
            },
          ),
          NewTextField().build(
            context,
            hintText: AppLocalizations.of(context).translate('hint_answer'),
            controller: answer2Con,
          ),
        ],
      ),
    );
  }

  Widget _buildOrganizationInfo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          NewLabel().build(context,
              title: AppLocalizations.of(context)
                  .translate('title_personal_information'),
              isRequire: false,
              fontWeight: FontWeight.bold),
          NewLabel().build(context,
              title:
              'Mã số thuế\n(Nhập @ nếu là cơ quan\nnhà nước & không có MST):',
              isRequire: true),
          NewTextField().build(
            context,
            hintText: 'xxxxxxxxx',
            controller: taxCon,
          ),
          NewLabel().build(context,
              title: AppLocalizations.of(context).translate('founding') + ':',
              isRequire: true),
          NewTextField().build(
            context,
            hintText: 'xx-xx-xxxx',
            controller: dateCon,
            onTap: () {
              _selectDate(context);
            },
          ),
          NewLabel().build(context,
              title: AppLocalizations.of(context).translate('province') + ':',
              isRequire: true),
          FutureBuilder(
            future: provinceData,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return snapshot.hasData
                  ? Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: DropdownButtonFormField(
                  hint: Text(
                    AppLocalizations.of(context).translate('province'),
                  ),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                  value: provinceValue,
                  onChanged: (newValue) {
                    setState(() {
                      provinceValue = newValue;
                      districtValue = null;
                      wardValue = null;
                      districtData = ApiService().fetchDistrict(provinceValue);
                    });
                  },
                  items:
                  snapshot.data.map<DropdownMenuItem<String>>((item) {
                    return DropdownMenuItem<String>(
                      value: item.value,
                      child: Text(item.display),
                      onTap: () {
                        provinceDisplay = item.display;
                      },
                    );
                  }).toList(),
                ),
              )
                  : Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: DropdownButtonFormField(
                  hint: Text(
                      AppLocalizations.of(context).translate('province')),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                ),
              );
            },
          ),
          NewLabel().build(context,
              title: AppLocalizations.of(context).translate('district') + ':',
              isRequire: true),
          FutureBuilder(
            future: districtData,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return snapshot.hasData
                  ? Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: DropdownButtonFormField(
                  hint: Text(
                    AppLocalizations.of(context).translate('district'),
                  ),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                  value: districtValue,
                  onChanged: (newValue) {
                    setState(() {
                      districtValue = newValue;
                      wardValue = null;
                      wardData = ApiService().fetchWard(districtValue);
                    });
                  },
                  items:
                  snapshot.data.map<DropdownMenuItem<String>>((item) {
                    return DropdownMenuItem<String>(
                      value: item.value,
                      child: Text(item.display),
                      onTap: () {
                        districtDisplay = item.display;
                      },
                    );
                  }).toList(),
                ),
              )
                  : Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: DropdownButtonFormField(
                  hint: Text(
                      AppLocalizations.of(context).translate('district')),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                ),
              );
            },
          ),
          NewLabel().build(context,
              title: AppLocalizations.of(context).translate('ward') + ':',
              isRequire: true),
          FutureBuilder(
            future: wardData,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return snapshot.hasData
                  ? Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: DropdownButtonFormField(
                  hint: Text(
                    AppLocalizations.of(context).translate('ward'),
                  ),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                  value: wardValue,
                  onChanged: (newValue) {
                    setState(() {
                      wardValue = newValue;
                    });
                  },
                  items:
                  snapshot.data.map<DropdownMenuItem<String>>((item) {
                    return DropdownMenuItem<String>(
                      value: item.value,
                      child: Text(item.display),
                      onTap: () {
                        wardDisplay = item.display;
                      },
                    );
                  }).toList(),
                ),
              )
                  : Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: DropdownButtonFormField(
                  hint: Text(
                      AppLocalizations.of(context).translate('ward')),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                ),
              );
            },
          ),
          NewLabel().build(context,
              title: AppLocalizations.of(context).translate('address') + ':',
              isRequire: true),
          NewTextField().build(
            context,
            hintText:
            AppLocalizations.of(context).translate('hint_address'),
            controller: addressCon,
          ),
        ],
      ),
    );
  }

  Widget _buildVehicle(pt) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context).translate('driver_name') + ':',
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        driveNameCon.text = pt.name;
                        licensePlatesCon.text = pt.licensePlate;
                        vehicleTypeValue = pt.vehicleTypeId.toString();
                        showEditDialog(context, true, pt);
                      },
                      color: Color(0xffb6bec8),
                      icon: Icon(Icons.edit_outlined),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          pts.removeWhere((element) =>
                          element.licensePlate == pt.licensePlate);
                        });
                      },
                      color: Color(0xffb6bec8),
                      icon: Icon(Icons.restore_from_trash),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              pt.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context).translate('license_plates') +
                      ':',
                ),
                Text(
                  pt.licensePlate,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context).translate('vehicle') + ':',
                ),
                Text(
                  pt.nameVehicleType,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(cd) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context).translate('account_name') + ':',
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        accountNameCon.text = cd.name;
                        cardNumberCon.text = cd.cardNumber;
                        showEditDialog(context, false, cd);
                      },
                      color: Color(0xffb6bec8),
                      icon: Icon(Icons.edit_outlined),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          cds.removeWhere(
                                  (element) =>
                              element.cardNumber == cd.cardNumber);
                        });
                      },
                      color: Color(0xffb6bec8),
                      icon: Icon(Icons.restore_from_trash),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              cd.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context).translate('card_number') + ':',
                ),
                Text(
                  cd.cardNumber,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  showAddDialog(BuildContext context, bool val) =>
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) =>
            Dialog(
              child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: val == true
                        ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)
                                  .translate('title_vehicle'),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              color: Color(0xffb6bec8),
                              icon: Icon(Icons.close),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        NewLabel().build(context,
                            title: AppLocalizations.of(context)
                                .translate('driver_name'),
                            isRequire: true,
                            fontWeight: FontWeight.w300),
                        NewTextField().build(context,
                            hintText: 'NGUYEN VAN A', controller: driveNameCon),
                        NewLabel().build(context,
                            title: AppLocalizations.of(context)
                                .translate('license_plates'),
                            isRequire: true,
                            fontWeight: FontWeight.w300),
                        NewTextField().build(context,
                            hintText: '59S145302',
                            controller: licensePlatesCon),
                        NewLabel().build(context,
                            title:
                            AppLocalizations.of(context).translate('vehicle'),
                            isRequire: true,
                            fontWeight: FontWeight.w300),
                        FutureBuilder(
                          future: vehicleTypeData,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            return snapshot.hasData
                                ? Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: DropdownButtonFormField(
                                hint: Text(
                                  AppLocalizations.of(context)
                                      .translate('type_vehicle'),
                                ),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5)),
                                      borderSide:
                                      BorderSide(color: Colors.grey)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5)),
                                  ),
                                  contentPadding: EdgeInsets.all(10.0),
                                ),
                                value: vehicleTypeValue,
                                onChanged: (newValue) {
                                  setState(() {
                                    vehicleTypeValue = newValue;
                                  });
                                },
                                items: snapshot.data
                                    .map<DropdownMenuItem<String>>((item) {
                                  return DropdownMenuItem<String>(
                                    value: item.value,
                                    child: Text(item.display),
                                    onTap: () {
                                      vehicleTypeDisplay = item.display;
                                    },
                                  );
                                }).toList(),
                              ),
                            )
                                : Container(
                              child: Center(
                                child: IconButton(
                                  icon: Icon(Icons.refresh),
                                  onPressed: () {
                                    setState(() {
                                      vehicleTypeData = ApiService().fetchVehicleType();
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RaisedButton(
                              elevation: 5,
                              onPressed: () {
                                Navigator.of(context).pop();
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
                                setState(() {
                                  pts.add(Vehicle(
                                      name: driveNameCon.text,
                                      licensePlate: licensePlatesCon.text,
                                      vehicleTypeId: int.parse(
                                          vehicleTypeValue),
                                      nameVehicleType: vehicleTypeDisplay));
                                  Navigator.of(context).pop();
                                });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              color: Color(0xffffc20e),
                              child: Text(
                                AppLocalizations.of(context).translate('save'),
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
                    )
                        : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)
                                  .translate('title_card'),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              color: Color(0xffb6bec8),
                              icon: Icon(Icons.close),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        NewLabel().build(context,
                            title: AppLocalizations.of(context)
                                .translate('account_name'),
                            isRequire: true,
                            fontWeight: FontWeight.w300),
                        NewTextField().build(context,
                            hintText: 'NGUYEN VAN A',
                            controller: accountNameCon),
                        NewLabel().build(context,
                            title: AppLocalizations.of(context)
                                .translate('card_number'),
                            isRequire: true,
                            fontWeight: FontWeight.w300),
                        NewTextField().build(context,
                            hintText: '0000-xxxx-xxxx-0000',
                            controller: cardNumberCon),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RaisedButton(
                              elevation: 5,
                              onPressed: () {
                                Navigator.of(context).pop();
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
                                setState(() {
                                  cds.add(LinkedCard(
                                      name: accountNameCon.text,
                                      cardNumber: cardNumberCon.text));
                                  Navigator.of(context).pop();
                                });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              color: Color(0xffffc20e),
                              child: Text(
                                AppLocalizations.of(context).translate('save'),
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
                  )),
            ),
      );

  showEditDialog(BuildContext context, bool val, pt) =>
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) =>
            Dialog(
              child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: val == true
                        ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)
                                  .translate('title_vehicle'),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              color: Color(0xffb6bec8),
                              icon: Icon(Icons.close),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        NewLabel().build(context,
                            title: AppLocalizations.of(context)
                                .translate('driver_name'),
                            isRequire: true,
                            fontWeight: FontWeight.w300),
                        NewTextField().build(context,
                            hintText: 'NGUYEN VAN A', controller: driveNameCon),
                        NewLabel().build(context,
                            title: AppLocalizations.of(context)
                                .translate('license_plates'),
                            isRequire: true,
                            fontWeight: FontWeight.w300),
                        NewTextField().build(context,
                            hintText: '59S145302',
                            controller: licensePlatesCon),
                        NewLabel().build(context,
                            title:
                            AppLocalizations.of(context).translate('vehicle'),
                            isRequire: true,
                            fontWeight: FontWeight.w300),
                        FutureBuilder(
                          future: vehicleTypeData,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            return snapshot.hasData
                                ? Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: DropdownButtonFormField(
                                hint: Text(
                                  AppLocalizations.of(context)
                                      .translate('type_vehicle'),
                                ),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5)),
                                      borderSide:
                                      BorderSide(color: Colors.grey)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5)),
                                  ),
                                  contentPadding: EdgeInsets.all(10.0),
                                ),
                                value: vehicleTypeValue,
                                onChanged: (newValue) {
                                  setState(() {
                                    vehicleTypeValue = newValue;
                                  });
                                },
                                items: snapshot.data
                                    .map<DropdownMenuItem<String>>((item) {
                                  return DropdownMenuItem<String>(
                                    value: item.value,
                                    child: Text(item.display),
                                    onTap: () {
                                      vehicleTypeDisplay = item.display;
                                    },
                                  );
                                }).toList(),
                              ),
                            )
                                : Container(
                              child: Center(
                                child: IconButton(
                                  icon: Icon(Icons.refresh),
                                  onPressed: () {
                                    setState(() {
                                      vehicleTypeData =
                                          ApiService().fetchVehicleType();
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RaisedButton(
                              elevation: 5,
                              onPressed: () {
                                Navigator.of(context).pop();
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
                                setState(() {
                                  pt.licensePlate = licensePlatesCon.text;
                                  pt.name = driveNameCon.text;
                                  pt.vehicleTypeId =
                                      int.parse(vehicleTypeValue);
                                  pt.nameVehicleType = vehicleTypeDisplay;
                                  pts[pts.indexWhere((element) =>
                                  element.licensePlate ==
                                      pt.licensePlate)] = pt;
                                  Navigator.of(context).pop();
                                });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              color: Color(0xffffc20e),
                              child: Text(
                                AppLocalizations.of(context).translate('save'),
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
                    )
                        : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)
                                  .translate('title_card'),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              color: Color(0xffb6bec8),
                              icon: Icon(Icons.close),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        NewLabel().build(context,
                            title: AppLocalizations.of(context)
                                .translate('account_name'),
                            isRequire: true,
                            fontWeight: FontWeight.w300),
                        NewTextField().build(context,
                            hintText: 'NGUYEN VAN A',
                            controller: accountNameCon),
                        NewLabel().build(context,
                            title: AppLocalizations.of(context)
                                .translate('card_number'),
                            isRequire: true,
                            fontWeight: FontWeight.w300),
                        NewTextField().build(context,
                            hintText: '0000-xxxx-xxxx-0000',
                            controller: cardNumberCon),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RaisedButton(
                              elevation: 5,
                              onPressed: () {
                                Navigator.of(context).pop();
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
                                setState(() {
                                  pt.name = accountNameCon.text;
                                  pt.cardNumber = cardNumberCon.text;
                                  cds[cds.indexWhere((element) =>
                                  element.cardNumber == pt.cardNumber)] = pt;
                                  Navigator.of(context).pop();
                                });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              color: Color(0xffffc20e),
                              child: Text(
                                AppLocalizations.of(context).translate('save'),
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
                  )),
            ),
      );

  showRegisterDialog() =>
      showGeneralDialog(
        barrierDismissible: false,
        context: context,
        pageBuilder: (BuildContext context, Animation animation,
            Animation secondaryAnimation) =>
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 80.0),
                child: Material(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10.0)),
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: SingleChildScrollView(
                        child: _selectedRadio == 1
                            ? Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalizations.of(context)
                                      .translate('entered_information'),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                IconButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(),
                                  color: Color(0xffb6bec8),
                                  icon: Icon(Icons.close),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.0),
                            NewLabel().build(context,
                                title: AppLocalizations.of(context)
                                    .translate('full_name') +
                                    ':',
                                fontWeight: FontWeight.w600),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(nameCon.text),
                            ),
                            NewLabel().build(context,
                                title: AppLocalizations.of(context)
                                    .translate('phone') +
                                    ':',
                                fontWeight: FontWeight.w600),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(phoneCon.text),
                            ),
                            NewLabel().build(context,
                                title: AppLocalizations.of(context)
                                    .translate('id') +
                                    ':',
                                fontWeight: FontWeight.w600),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(citizenIdCon.text),
                            ),
                            NewLabel().build(context,
                                title: AppLocalizations.of(context)
                                    .translate('email') +
                                    ':',
                                fontWeight: FontWeight.w600),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(emailCon.text),
                            ),
                            NewLabel().build(context,
                                title: AppLocalizations.of(context)
                                    .translate('birth') +
                                    ':',
                                fontWeight: FontWeight.w600),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(dateCon.text),
                            ),
                            NewLabel().build(context,
                                title: AppLocalizations.of(context)
                                    .translate('gender') +
                                    ':',
                                fontWeight: FontWeight.w600),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(genderDisplay),
                            ),
                            NewLabel().build(context,
                                title: AppLocalizations.of(context)
                                    .translate('tax') +
                                    ':',
                                fontWeight: FontWeight.w600),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(taxCon.text),
                            ),
                            NewLabel().build(context,
                                title: AppLocalizations.of(context)
                                    .translate('province') +
                                    ':',
                                fontWeight: FontWeight.w600),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(provinceDisplay),
                            ),
                            NewLabel().build(context,
                                title: AppLocalizations.of(context)
                                    .translate('district') +
                                    ':',
                                fontWeight: FontWeight.w600),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(districtDisplay),
                            ),
                            NewLabel().build(context,
                                title: AppLocalizations.of(context)
                                    .translate('ward') +
                                    ':',
                                fontWeight: FontWeight.w600),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(wardDisplay),
                            ),
                            NewLabel().build(context,
                                title: AppLocalizations.of(context)
                                    .translate('address') +
                                    ':',
                                fontWeight: FontWeight.w600),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(addressCon.text),
                            ),
                            NewLabel().build(context,
                                title: AppLocalizations.of(context)
                                    .translate('amount_vehicle') +
                                    ':',
                                fontWeight: FontWeight.w600),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(pts.length.toString()),
                            ),
                            NewLabel().build(context,
                                title: AppLocalizations.of(context)
                                    .translate('amount_card') +
                                    ':',
                                fontWeight: FontWeight.w600),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(cds.length.toString()),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                RaisedButton(
                                  elevation: 5,
                                  onPressed: () =>
                                      Navigator.of(context).pop(),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  color: Color(0xffEAEEF2),
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate('adjusted'),
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
                                    otp = true;
                                    ApiService().generateOTP(phoneCon.text, stConstant.register);
                                    qes.add(Question(
                                        questionId: int.parse(questionValue1),
                                        answer: answer1Con.text));
                                    qes.add(Question(
                                        questionId: int.parse(questionValue2),
                                        answer: answer2Con.text));
                                    Navigator.of(context).pop();
                                    pageController.animateToPage(
                                        ++pageChanged,
                                        duration: Duration(milliseconds: 10),
                                        curve: Curves.bounceInOut);
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
                          ],
                        )
                            : Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalizations.of(context)
                                      .translate('entered_information'),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                IconButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(),
                                  color: Color(0xffb6bec8),
                                  icon: Icon(Icons.close),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.0),
                            NewLabel().build(context,
                                title: AppLocalizations.of(context)
                                    .translate('unit_name') +
                                    ':',
                                fontWeight: FontWeight.w600),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(nameCon.text),
                            ),
                            NewLabel().build(context,
                                title: AppLocalizations.of(context)
                                    .translate('phone') +
                                    ':',
                                fontWeight: FontWeight.w600),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(phoneCon.text),
                            ),
                            NewLabel().build(context,
                                title: AppLocalizations.of(context)
                                    .translate('tax') +
                                    ':',
                                fontWeight: FontWeight.w600),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(taxCon.text),
                            ),
                            NewLabel().build(context,
                                title: AppLocalizations.of(context)
                                    .translate('email') +
                                    ':',
                                fontWeight: FontWeight.w600),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(emailCon.text),
                            ),
                            NewLabel().build(context,
                                title: AppLocalizations.of(context)
                                    .translate('province') +
                                    ':',
                                fontWeight: FontWeight.w600),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(provinceDisplay),
                            ),
                            NewLabel().build(context,
                                title: AppLocalizations.of(context)
                                    .translate('district') +
                                    ':',
                                fontWeight: FontWeight.w600),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(districtDisplay),
                            ),
                            NewLabel().build(context,
                                title: AppLocalizations.of(context)
                                    .translate('ward') +
                                    ':',
                                fontWeight: FontWeight.w600),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(wardDisplay),
                            ),
                            NewLabel().build(context,
                                title: AppLocalizations.of(context)
                                    .translate('address') +
                                    ':',
                                fontWeight: FontWeight.w600),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(addressCon.text),
                            ),
                            NewLabel().build(context,
                                title: AppLocalizations.of(context)
                                    .translate('amount_vehicle') +
                                    ':',
                                fontWeight: FontWeight.w600),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(pts.length.toString()),
                            ),
                            NewLabel().build(context,
                                title: AppLocalizations.of(context)
                                    .translate('amount_card') +
                                    ':',
                                fontWeight: FontWeight.w600),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(cds.length.toString()),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                RaisedButton(
                                  elevation: 5,
                                  onPressed: () =>
                                      Navigator.of(context).pop(),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  color: Color(0xffEAEEF2),
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate('adjusted') +
                                        ':',
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
                                    otp = true;
                                    ApiService().generateOTP(phoneCon.text, stConstant.register);
                                    qes.add(Question(
                                        questionId: int.parse(questionValue1),
                                        answer: answer1Con.text));
                                    qes.add(Question(
                                        questionId: int.parse(questionValue2),
                                        answer: answer2Con.text));
                                    Navigator.of(context).pop();
                                    pageController1.animateToPage(
                                        ++pageChanged1,
                                        duration: Duration(milliseconds: 10),
                                        curve: Curves.bounceInOut);
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
                          ],
                        )),
                  ),
                ),
              ),
            ),
      );

  passDataToQR(BuildContext context, String name, String phone, String email,
      String tax, String address, List<Vehicle> list, int type) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QRListSignUp(
              name: name,
              phone: phone,
              email: email,
              tax: tax,
              address: address,
              list: list,
              type: type,
            )));
  }

  _selectDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2040),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Color(0xffffc20e),
                onPrimary: Colors.white,
                surface: Color(0xffffc20e),
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child,
          );
        });
    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      dateCon
        ..text = Format().fSelectDate.format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: dateCon.text.length, affinity: TextAffinity.upstream));
    }
  }

  Future<bool> onWillPop() async{
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Home(),
      ),
          (route) => false,
    );
    return true;
  }
}
