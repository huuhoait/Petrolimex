import 'dart:async';

import 'package:flutter/material.dart';
import 'package:petrolimex/constants/stConstant.dart';
import 'package:petrolimex/helper/app_localizations.dart';
import 'package:petrolimex/helper/format.dart';
import 'package:petrolimex/models/Base.dart';
import 'package:petrolimex/screens/sign_in_screen.dart';
import 'package:petrolimex/utils/DeviceInfo.dart';
import 'package:petrolimex/utils/StringUtil.dart';
import 'package:petrolimex/viewModels/home_viewModel.dart';
import 'package:petrolimex/widgets/appBarWidget.dart';
import 'package:petrolimex/widgets/drawerWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final homeViewModel = HomeViewModel();
  String name;
  Timer _authTimer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logout();
  }



  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: newAppBar(context),
      drawer: Drawer(
        child: FutureBuilder(
          future: homeViewModel.getName(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            return snapshot.hasData ?
            NewDrawer(
              onOff: false,
              name: snapshot.data,
            ): Text(AppLocalizations.of(context).translate('register_PLX'));
          },
        )
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://files.petrolimex.com.vn/files/6783dc1271ff449e95b74a9520964169/image=jpeg/c0471f577d194b38b0c0ea656cbebbed/Cam%20k%E1%BA%BFt-mb.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void logout(){
    if(_authTimer!=null){
      _authTimer.cancel();
    }
    _authTimer = new Timer.periodic(new Duration(minutes: 5), (time) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      _authTimer.cancel();
      Navigator.of(context).pop();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => SignIn(),
        ),
            (route) => false,
      );
    });
  }

}
