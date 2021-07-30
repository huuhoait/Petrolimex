import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petrolimex/helper/app_localizations.dart';
import 'package:petrolimex/helper/format.dart';
import 'package:petrolimex/models/CustomerInfo.dart';
import 'package:petrolimex/models/District.dart';
import 'package:petrolimex/models/Static.dart';
import 'package:petrolimex/models/Ward.dart';
import 'package:petrolimex/screens/qr_screen.dart';
import 'package:petrolimex/screens/update_screen.dart';
import 'package:petrolimex/services/api_service.dart';
import 'package:petrolimex/utils/DeviceInfo.dart';
import 'package:petrolimex/utils/StringUtil.dart';
import 'package:petrolimex/viewModels/home_viewModel.dart';
import 'package:petrolimex/viewModels/update_viewModel.dart';
import 'package:petrolimex/widgets/appBarWidget.dart';
import 'package:petrolimex/widgets/bottomNavigationBarWidget.dart';
import 'package:petrolimex/widgets/drawerWidget.dart';
import 'package:petrolimex/widgets/floatingActionButtonWidget.dart';
import 'package:petrolimex/widgets/subTitleWidget.dart';
import 'package:petrolimex/widgets/textWidget.dart';
import 'package:petrolimex/widgets/titleWidget.dart';

class Info extends StatefulWidget {
  const Info({Key key}) : super(key: key);

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  final homeViewModel = HomeViewModel();
  String ward, district, province;

  Future<CustomerInfo> cusData;

  @override
  void initState() {
    super.initState();
    cusData = ApiService().fetchCustomInfo(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: newAppBar(context),
      drawer: Drawer(
          child: FutureBuilder(
        future: homeViewModel.getName(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? NewDrawer(
                  onOff: false,
                  name: snapshot.data,
                )
              : Text("Đăng ký PLX ID");
        },
      )),
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
                      child: FutureBuilder<CustomerInfo>(
                        future: cusData,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          return snapshot.hasData
                              ? Column(
                                  children: [
                                    SizedBox(height: 30),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)
                                              .translate('detail_PLX'),
                                          style: TextStyle(
                                            color: Color(0xff454f5b),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 110.0,
                                        ),
                                        IconButton(
                                          color: Color(0xffb6bec8),
                                          icon: Icon(Icons.edit_outlined),
                                          onPressed: () {
                                            passData(
                                                context,
                                                snapshot.data.customer.name,
                                                snapshot.data.customer.phone,
                                                snapshot.data.customer.cardId,
                                                snapshot.data.customer.email,
                                                snapshot.data.customer.date,
                                                snapshot.data.customer.taxCode,
                                                snapshot.data.customer.address,
                                                snapshot.data.questions[0].answer,
                                                snapshot.data.questions[1].answer,
                                                snapshot.data.questions[0].id.toString(),
                                                snapshot.data.questions[1].id.toString(),
                                                snapshot.data.customer.gender,
                                                snapshot.data.customer.provinceId.toString(),
                                                snapshot.data.customer.districtId.toString(),
                                                snapshot.data.customer.wardId.toString(),
                                                province,
                                                district,
                                                ward);
                                          },
                                        ),
                                      ],
                                    ),
                                    RaisedButton.icon(
                                      icon: Icon(Icons.qr_code),
                                      elevation: 5,
                                      onPressed: () {
                                        passDataToQR(
                                            context,
                                            snapshot.data.customer.name,
                                            snapshot.data.customer.phone,
                                            snapshot.data.customer.email,
                                            snapshot.data.customer.taxCode,
                                            snapshot.data.customer.address +
                                                " " +
                                                ward +
                                                " " +
                                                district +
                                                " " +
                                                province,
                                            snapshot.data.vehicles,
                                            snapshot
                                                .data.customer.customerTypeId);
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      color: Color(0xffEAEEF2),
                                      label: Text(
                                        'QR Code',
                                        style: TextStyle(
                                          color: Color(0xff454f5b),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        SubTitle().build(context,
                                            text: 'Thông tin PLX ID:'),
                                        snapshot.data.customer.customerTypeId ==
                                                1
                                            ? NewText()
                                                .build(context, text: 'Cá nhân')
                                            : NewText().build(context,
                                                text: 'Tổ chức'),
                                        NewTitle().build(context,
                                            text: 'Thông tin đăng nhập'),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SubTitle().build(context,
                                                    text: 'Họ và tên:'),
                                                NewText().build(context,
                                                    text: snapshot
                                                        .data.customer.name),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SubTitle().build(context,
                                                    text: 'Số điện thoại:'),
                                                NewText().build(context,
                                                    text: snapshot
                                                        .data.customer.phone),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SubTitle().build(context,
                                            text: 'Câu hỏi bí mật 1:'),
                                        FutureBuilder<List<Property>>(
                                            future:
                                                ApiService().fetchQuestionOne(),
                                            builder: (context, quesSnapshot) {
                                              if (quesSnapshot.hasData) {
                                                List<Property> q =
                                                    quesSnapshot.data;
                                                var results = q.indexWhere(
                                                    (e) =>
                                                        e.value ==
                                                        snapshot.data
                                                            .questions[0].id
                                                            .toString());
                                                return NewText().build(context,
                                                    text: q[results].display);
                                              }
                                              return CircularProgressIndicator();
                                            }),
                                        SubTitle().build(context,
                                            text: 'Câu hỏi bí mật 2:'),
                                        FutureBuilder<List<Property>>(
                                            future:
                                                ApiService().fetchQuestionTwo(),
                                            builder: (context, quesSnapshot) {
                                              if (quesSnapshot.hasData) {
                                                List<Property> q =
                                                    quesSnapshot.data;
                                                var results = q.indexWhere(
                                                    (e) =>
                                                        e.value ==
                                                        snapshot.data
                                                            .questions[1].id
                                                            .toString());
                                                return NewText().build(context,
                                                    text: q[results].display);
                                              }
                                              return CircularProgressIndicator();
                                            }),
                                        NewTitle().build(context,
                                            text: 'Thông tin đăng ký thẻ'),
                                        snapshot.data.customer.customerTypeId ==
                                                1
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SubTitle().build(context,
                                                          text:
                                                              'Số CMND/CCCD:'),
                                                      NewText().build(context,
                                                          text: snapshot.data
                                                              .customer.cardId),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SubTitle().build(context,
                                                          text: 'Email:'),
                                                      NewText().build(context,
                                                          text: snapshot.data
                                                              .customer.email),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SubTitle().build(context,
                                                      text: 'Email:'),
                                                  NewText().build(context,
                                                      text: snapshot
                                                          .data.customer.email),
                                                ],
                                              ),
                                        snapshot.data.customer.customerTypeId ==
                                                1
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SubTitle().build(context,
                                                          text: 'Ngày sinh:'),
                                                      NewText().build(context,
                                                          text: Format().split(
                                                              snapshot
                                                                  .data
                                                                  .customer
                                                                  .date)),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SubTitle().build(context,
                                                          text: 'Giới tính:'),
                                                      FutureBuilder<
                                                              List<Property>>(
                                                          future: ApiService()
                                                              .fetchGender(),
                                                          builder: (context,
                                                              quesSnapshot) {
                                                            if (quesSnapshot
                                                                .hasData) {
                                                              List<Property> q =
                                                                  quesSnapshot
                                                                      .data;
                                                              var results = q
                                                                  .indexWhere((e) =>
                                                                      e.value ==
                                                                      snapshot
                                                                          .data
                                                                          .customer
                                                                          .gender
                                                                          .toString());
                                                              return NewText().build(
                                                                  context,
                                                                  text: q[results]
                                                                      .display);
                                                            }
                                                            return CircularProgressIndicator();
                                                          }),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SubTitle().build(context,
                                                      text: 'Ngày thành lập:'),
                                                  NewText().build(context,
                                                      text: Format().split(
                                                          snapshot.data.customer
                                                              .date)),
                                                ],
                                              ),
                                        SubTitle().build(context,
                                            text: 'Mã số thuế:'),
                                        NewText().build(context,
                                            text:
                                                snapshot.data.customer.taxCode),
                                        SubTitle()
                                            .build(context, text: 'Tỉnh:'),
                                        FutureBuilder<List<Property>>(
                                            future:
                                                ApiService().fetchProvince(),
                                            builder: (context, quesSnapshot) {
                                              if (quesSnapshot.hasData) {
                                                List<Property> q =
                                                    quesSnapshot.data;
                                                var results = q.indexWhere(
                                                    (e) =>
                                                        e.value ==
                                                        snapshot.data.customer
                                                            .provinceId
                                                            .toString());
                                                province = q[results].display;
                                                return NewText().build(context,
                                                    text: q[results].display);
                                              }
                                              return CircularProgressIndicator();
                                            }),
                                        SubTitle().build(context,
                                            text: 'Quận/Huyện:'),
                                        FutureBuilder(
                                            future: ApiService().fetchDistrict(
                                                snapshot
                                                    .data.customer.provinceId
                                                    .toString()),
                                            builder: (context, quesSnapshot) {
                                              if (quesSnapshot.hasData) {
                                                List<District> q =
                                                    quesSnapshot.data;
                                                var results = q.indexWhere(
                                                    (e) =>
                                                        e.value ==
                                                        snapshot.data.customer
                                                            .districtId
                                                            .toString());
                                                district = q[results].display;
                                                return NewText().build(context,
                                                    text: q[results].display);
                                              }
                                              return CircularProgressIndicator();
                                            }),
                                        SubTitle()
                                            .build(context, text: 'Phườn/Xã:'),
                                        FutureBuilder(
                                            future: ApiService().fetchWard(
                                                snapshot
                                                    .data.customer.districtId
                                                    .toString()),
                                            builder: (context, quesSnapshot) {
                                              if (quesSnapshot.hasData) {
                                                List<Ward> q =
                                                    quesSnapshot.data;
                                                var results = q.indexWhere(
                                                    (e) =>
                                                        e.value ==
                                                        snapshot.data.customer
                                                            .wardId
                                                            .toString());
                                                ward = q[results].display;
                                                return NewText().build(context,
                                                    text: q[results].display);
                                              }
                                              return Container(
                                                width: 50.0,
                                                height: 50.0,
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }),
                                        SubTitle().build(context,
                                            text: 'Địa chỉ liên hệ:'),
                                        NewText().build(context,
                                            text:
                                                snapshot.data.customer.address),
                                        NewTitle().build(context,
                                            text: 'Phương tiện & thẻ'),
                                        SubTitle().build(context,
                                            text: 'Số phương tiện đăng ký:'),
                                        NewText().build(context,
                                            text: snapshot.data.vehicles.length
                                                .toString()),
                                        SubTitle().build(context,
                                            text: 'Số thẻ liên kết:'),
                                        NewText().build(context,
                                            text: snapshot
                                                .data.linkedCards.length
                                                .toString()),
                                      ],
                                    )
                                  ],
                                )
                              : LinearProgressIndicator();
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: NewFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: NewBottomNavigationBar(),
    );
  }

  passData(
    BuildContext context,
    String nameCon,
    String phoneCon,
    String citizenIdCon,
    String emailCon,
    String dateCon,
    String taxCon,
    String addressCon,
    String answer1Con,
    String answer2Con,
    String questOne,
    String questTwo,
    String gender,
    String province,
    String district,
    String ward,
    String provinceDisplay,
    String districtDisplay,
    String wardDisplay,
  ) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Update(
                  nameCon: nameCon,
                  phoneCon: phoneCon,
                  citizenIdCon: citizenIdCon,
                  emailCon: emailCon,
                  dateCon: dateCon,
                  taxCon: taxCon,
                  addressCon: addressCon,
                  answer1Con: answer1Con,
                  answer2Con: answer2Con,
                  questOne: questOne,
                  questTwo: questTwo,
                  gender: gender,
                  province: province,
                  district: district,
                  ward: ward,
                  provinceDisplay: provinceDisplay,
                  districtDisplay: districtDisplay,
                  wardDisplay: wardDisplay,
                )));
  }

  passDataToQR(BuildContext context, String name, String phone, String email,
      String tax, String address, List<Vehicle> list, int type) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QRList(
                  name: name,
                  phone: phone,
                  email: email,
                  tax: tax,
                  address: address,
                  list: list,
                  type: type,
                )));
  }
}
