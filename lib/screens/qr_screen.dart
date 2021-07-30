import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:petrolimex/helper/app_localizations.dart';
import 'package:petrolimex/models/CustomerInfo.dart';
import 'package:petrolimex/models/VehicleType.dart';
import 'package:petrolimex/services/api_service.dart';
import 'package:petrolimex/viewModels/update_viewModel.dart';
import 'package:petrolimex/widgets/appBarWidget.dart';
import 'package:petrolimex/widgets/drawerWidget.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:petrolimex/models/Register.dart' as regis;

class QRList extends StatelessWidget {
  String name, phone, email, tax, address;
  int type;
  List<Vehicle> list;

  QRList({Key key,
    this.name,
    this.phone,
    this.email,
    this.tax,
    this.address,
    this.list,
    this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Vehicle> pts = List.from(list);
    return Scaffold(
      appBar: newAppBar(context),
      drawer: Drawer(
        child: NewDrawer(),
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
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(25.0),
              child: Text(
                'Danh sách QR',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _showModalSheet(context, null);
              },
              child: Container(
                color: Color(0xffFFECB3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:
                      EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                      child: Column(
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Icon(
                                        Icons.phone_outlined,
                                        size: 15.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: phone,
                                      style: TextStyle(
                                          fontSize: 15.0, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Icon(
                                        Icons.email_outlined,
                                        size: 15.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: email,
                                      style: TextStyle(
                                          fontSize: 15.0, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Mã số thuế: ',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                ),
                                TextSpan(
                                  text: tax,
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    type == 1
                        ? QrImage(
                      data: "$name\n$phone\n$email\n$tax",
                      version: QrVersions.auto,
                      backgroundColor: Colors.white,
                      size: 80.0,
                    )
                        : QrImage(
                        data:
                        "Tên đơn vị: $name\nSố điện thoại: $phone\nEmail: $email\nMã số thuế: $tax\nĐịa chỉ: $address",
                        version: QrVersions.auto,
                        backgroundColor: Colors.white,
                        size: 80.0),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: pts.where((e) => e.recordType != 3).length,
                itemBuilder: (context, index) {
                  return
                    GestureDetector(
                      onTap: () {
                        _showModalSheet(context, pts[index].licensePlate);
                      },
                      child: Column(
                        children: [
                          Container(
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Column(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Biển số xe: ',
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                            ),
                                            TextSpan(
                                              text: pts[index].licensePlate,
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Loại phương tiện: ",
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          FutureBuilder<List<VehicleTypeElement>>(
                                              future: ApiService()
                                                  .fetchVehicleType(),
                                              builder: (context, quesSnapshot) {
                                                if (quesSnapshot.hasData) {
                                                  List<VehicleTypeElement> q =
                                                      quesSnapshot.data;
                                                  var results = q.indexWhere((e) =>
                                                  e.value ==
                                                      pts[index]
                                                          .vehicleTypeId
                                                          .toString());
                                                  return Text(
                                                    q[results].display,
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                    ),
                                                  );
                                                }
                                                return CircularProgressIndicator();
                                              })
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                QrImage(
                                  data:
                                  "Tên đơn vị: $name\nSố điện thoại: $phone\nEmail: $email\nMã số thuế: $tax\nĐịa chỉ: $address\nBiển số xe: " +
                                      pts[index].licensePlate,
                                  version: QrVersions.auto,
                                  size: 80.0,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                        ],
                      ),
                    );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showModalSheet(BuildContext context, String licensePlate) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0))),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            height: MediaQuery
                .of(context)
                .size
                .height * 2 / 3,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Mã QR",
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      color: Color(0xffb6bec8),
                      icon: Icon(
                        Icons.close,
                        size: 25.0,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                licensePlate != null ?
                QrImage(
                  data:
                  "Tên đơn vị: $name\nSố điện thoại: $phone\nEmail: $email\nMã số thuế: $tax\nĐịa chỉ: $address\nBiển số xe: $licensePlate",
                  version: QrVersions.auto,
                  size: 250.0,
                ) : QrImage(
                  data:
                  "Tên đơn vị: $name\nSố điện thoại: $phone\nEmail: $email\nMã số thuế: $tax\nĐịa chỉ: $address\n",
                  version: QrVersions.auto,
                  size: 250.0,
                ),
                licensePlate != null
                    ? RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Biển số xe: ",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: licensePlate,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                )
                    : Text(''),
                SizedBox(width: 200.0, child: RaisedButton(
                  elevation: 5,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Color(0xffffc20e),
                  child: Text(
                    "Lưu mã QR",
                    style: TextStyle(
                      color: Color(0xff454f5b),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),),

                TextButton(
                  onPressed: () {
                  },
                  child: Text(
                    "Chia sẽ QR",
                    style: TextStyle(
                      color: Color(0xff1890ff),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class QRListSignUp extends StatelessWidget {
  String name, phone, email, tax, address;
  int type;
  List<regis.Vehicle> list;

  QRListSignUp({Key key,
    this.name,
    this.phone,
    this.email,
    this.tax,
    this.address,
    this.list,
    this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Vehicle> pts = List.from(list);
    return Scaffold(
      appBar: newAppBar(context),
      drawer: Drawer(
        child: NewDrawer(),
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
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(25.0),
              child: Text(
                'Danh sách QR',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _showModalSheet(context, null);
              },
              child: Container(
                color: Color(0xffFFECB3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:
                      EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                      child: Column(
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Icon(
                                        Icons.phone_outlined,
                                        size: 15.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: phone,
                                      style: TextStyle(
                                          fontSize: 15.0, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Icon(
                                        Icons.email_outlined,
                                        size: 15.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: email,
                                      style: TextStyle(
                                          fontSize: 15.0, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Mã số thuế: ',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                ),
                                TextSpan(
                                  text: tax,
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    type == 1
                        ? QrImage(
                      data: "$name\n$phone\n$email\n$tax",
                      version: QrVersions.auto,
                      backgroundColor: Colors.white,
                      size: 80.0,
                    )
                        : QrImage(
                        data:
                        "Tên đơn vị: $name\nSố điện thoại: $phone\nEmail: $email\nMã số thuế: $tax\nĐịa chỉ: $address",
                        version: QrVersions.auto,
                        backgroundColor: Colors.white,
                        size: 80.0),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: pts.length,
                itemBuilder: (context, index) {
                  return
                    GestureDetector(
                      onTap: () {
                        _showModalSheet(context, pts[index].licensePlate);
                      },
                      child: Column(
                        children: [
                          Container(
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Column(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Biển số xe: ',
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                            ),
                                            TextSpan(
                                              text: pts[index].licensePlate,
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Loại phương tiện: ",
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          FutureBuilder<List<VehicleTypeElement>>(
                                              future: ApiService()
                                                  .fetchVehicleType(),
                                              builder: (context, quesSnapshot) {
                                                if (quesSnapshot.hasData) {
                                                  List<VehicleTypeElement> q =
                                                      quesSnapshot.data;
                                                  var results = q.indexWhere((e) =>
                                                  e.value ==
                                                      pts[index]
                                                          .vehicleTypeId
                                                          .toString());
                                                  return Text(
                                                    q[results].display,
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                    ),
                                                  );
                                                }
                                                return CircularProgressIndicator();
                                              })
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                QrImage(
                                  data:
                                  "Tên đơn vị: $name\nSố điện thoại: $phone\nEmail: $email\nMã số thuế: $tax\nĐịa chỉ: $address\nBiển số xe: " +
                                      pts[index].licensePlate,
                                  version: QrVersions.auto,
                                  size: 80.0,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                        ],
                      ),
                    );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showModalSheet(BuildContext context, String licensePlate) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0))),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            height: MediaQuery
                .of(context)
                .size
                .height * 2 / 3,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Mã QR",
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      color: Color(0xffb6bec8),
                      icon: Icon(
                        Icons.close,
                        size: 25.0,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                licensePlate != null ?
                QrImage(
                  data:
                  "Tên đơn vị: $name\nSố điện thoại: $phone\nEmail: $email\nMã số thuế: $tax\nĐịa chỉ: $address\nBiển số xe: $licensePlate",
                  version: QrVersions.auto,
                  size: 250.0,
                ) : QrImage(
                  data:
                  "Tên đơn vị: $name\nSố điện thoại: $phone\nEmail: $email\nMã số thuế: $tax\nĐịa chỉ: $address\n",
                  version: QrVersions.auto,
                  size: 250.0,
                ),
                licensePlate != null
                    ? RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Biển số xe: ",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: licensePlate,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                )
                    : Text(''),
                SizedBox(width: 200.0, child: RaisedButton(
                  elevation: 5,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Color(0xffffc20e),
                  child: Text(
                    "Lưu mã QR",
                    style: TextStyle(
                      color: Color(0xff454f5b),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),),

                TextButton(
                  onPressed: () {
                  },
                  child: Text(
                    "Chia sẽ QR",
                    style: TextStyle(
                      color: Color(0xff1890ff),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}