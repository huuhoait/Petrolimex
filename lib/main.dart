import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:petrolimex/screens/home_screen.dart';
import 'package:petrolimex/screens/info_screen.dart';
import 'package:petrolimex/screens/sign_in_screen.dart';
import 'package:petrolimex/screens/sign_up_screen.dart';
import 'package:petrolimex/screens/update_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helper/app_localizations.dart';

Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var session = prefs.getString('session');

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark
  ));
  runApp(MaterialApp(
    // builder: (context, widget) => ResponsiveWrapper.builder(
    //     BouncingScrollWrapper.builder(context, widget),
    //     maxWidth: 1200,
    //     minWidth: 450,
    //     defaultScale: true,
    //     breakpoints: [
    //       ResponsiveBreakpoint.resize(450, name: MOBILE),
    //       ResponsiveBreakpoint.autoScale(800, name: TABLET),
    //       ResponsiveBreakpoint.autoScale(1000, name: TABLET),
    //       ResponsiveBreakpoint.resize(1200, name: DESKTOP),
    //       ResponsiveBreakpoint.autoScale(2460, name: "4K"),
    //     ],
    //   ),
    home: session == null ? SignIn() : Home(),
    //initialRoute: '/Home',
    routes: {
      '/SignIn': (context) => SignIn(),
      '/SignUp': (context) => SignUp(),
      '/Home': (context) => Home(),
      '/Info': (context) => Info(),
      '/Update': (context) => Update(),
    },
    supportedLocales: [
      Locale('vi', 'VN'),
      Locale('en', 'US'),
    ],
    localizationsDelegates: [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    localeResolutionCallback: (locale, supportedLocales) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode &&
            supportedLocale.countryCode == locale.countryCode) {
          return supportedLocale;
        }
      }
      return supportedLocales.first;
    },
  ));
}


