import 'package:flutter/material.dart';
import 'package:petrolimex/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

AppBar newAppBar (context){
  return AppBar(
    iconTheme: IconThemeData(
      color: Color(0xff454f5b),
    ),
    title: Image.asset('assets/image1.png', fit: BoxFit.cover),
    centerTitle: true,
    backgroundColor: Color(0xffffc20e),
    elevation: 4.0,
    actions: [
      IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {
          }
      ),
      IconButton(
          icon: Icon(Icons.person_outline),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            var session = prefs.getString('session');
            //ApiService().fetchCustomInfo();
            Navigator.of(context).pushNamed(session != null ? "/Info" : "/SignIn");
          }
      ),
    ],
  );
}